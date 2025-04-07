const fs = require('fs');
const os = require('os');
const path = require('path');
const {promisify} = require('util');
const {v4: uuidv4} = require('uuid');
const {pipeline} = require('stream');
const {createReadStream} = require('fs');
const zlib = require('zlib');
const userGroupStateRepository = require('../repositories/userGroupStateRepository');
const groupRepository = require('../repositories/groupRepository');
const userRepository = require('../repositories/userRepository');
const unzipper = require('unzipper');
const pipelineAsync = promisify(pipeline);

class TestService {
  constructor() {
    this.userRepository = userRepository;
    this.groupRepository = groupRepository;
    this.userGroupStateRepository = userGroupStateRepository;
    this.tempFilesByOriginalFilename = {};
  }

  async handleFileUpload(file) {
    try {
      await this.unzipFile(file);
      await this.importFromFile();
    } finally {
      this.cleanupTempFiles();
    }
  }

  async unzipFile(file) {
    const tempDirPath = this.createTempDir();

    try {
      const extractionPromises = [];

      // Open ZIP file
      const filePath = file.path;
      const zipStream = createReadStream(filePath).pipe(unzipper.Parse({forceStream: true}));

      for await (const entry of zipStream) {
        if (entry.path.endsWith('.csv')) {
          const tempFilePath = path.join(tempDirPath, entry.path);
          const destination = fs.createWriteStream(tempFilePath);
          this.tempFilesByOriginalFilename[entry.path] = tempFilePath;

          // Pipe entry stream to file
          const extractionPromise = pipelineAsync(entry, destination)
            .catch(err => {
              console.error(`Error extracting ${entry.path}:`, err);
              throw new Error(`Error extracting ${entry.path}: ${err.message}`);
            });

          extractionPromises.push(extractionPromise);
        } else {
          entry.autodrain(); // Ignore non-CSV files
        }
      }

      await Promise.all(extractionPromises);

    } catch (err) {
      console.error('Error extracting ZIP file:', err);
      throw new Error(`Error extracting ZIP file: ${err.message}`);
    }
  }

  createTempDir() {
    const tempDir = os.tmpdir();
    const uniqueFolderName = `tmp_${uuidv4()}`;
    const tempDirPath = path.join(tempDir, uniqueFolderName);
    fs.mkdirSync(tempDirPath, {recursive: true});
    return tempDirPath;
  }

  getTempFile(fileName) {
    return this.tempFilesByOriginalFilename[fileName];
  }

  cleanupTempFiles() {
    for (const filePath of Object.values(this.tempFilesByOriginalFilename)) {
      try {
        fs.unlinkSync(filePath);
      } catch (e) {
        console.error(`Failed to delete temp file ${filePath}: ${e}`);
      }
    }
    // Delete also directories
    for (const dirPath of Object.values(this.tempFilesByOriginalFilename)) {
      if (fs.existsSync(dirPath)) {
        try {
          fs.rmdirSync(dirPath, {recursive: true});
        } catch (e) {
          console.error(`Failed to delete temp directory ${dirPath}: ${e}`);
        }
      }
    }
    this.tempFilesByOriginalFilename = {};
  }

  async importFromFile() {
    await this.insertGroupState();
    await this.insertGroup();
    await this.insertUser();
  }

  async insertGroupState() {
    const filePath = this.getTempFile('usergroupstate.csv');
    if (!filePath) return;

    const lines = fs.readFileSync(filePath, 'utf-8').split('\n').slice(1); // Skip header

    try {
      for (const line of lines) {
        if (line.trim() === '') continue;
        const [id, label] = line.split(',');
        const state = {
          id: parseInt(id),
          label: label,
        };
        await this.userGroupStateRepository.merge(state);
      }
    } catch (e) {
      console.error('Error inserting group states:', e);
      throw new Error(`Error inserting group states: ${e.message}`);
    }
  }

  async insertGroup() {
    const filePath = this.getTempFile('group.csv');
    if (!filePath) return;

    const lines = fs.readFileSync(filePath, 'utf-8').split('\n').slice(1); // Skip header

    try {
      for (const line of lines) {
        if (line.trim() === '') continue;
        const [
          id,
          name,
          contract_signed,
          contract_number,
          institute_name,
          institute_address_name,
          institute_address_number,
          institute_postal_code,
          province,
          city,
          country,
          vat,
          institute_phone,
          institute_email,
          state_id,
          priority,
          responsible_user_id
        ] = line.split(',');
        const group = {
          id: parseInt(id),
          name: name,
          contractSigned: new Date(contract_signed),
          contractNumber: parseInt(contract_number),
          instituteName: institute_name,
          instituteAddressName: institute_address_name,
          instituteAddressNumber: institute_address_number,
          institutePostalCode: institute_postal_code,
          province: province,
          city: city,
          country: country,
          vat: vat,
          institutePhone: institute_phone,
          instituteEmail: institute_email,
          stateId: parseInt(state_id),
          priority: parseFloat(priority),
        };
        if (id) {
          await this.groupRepository.merge(group);
        }
      }
    } catch (e) {
      console.error('Error inserting groups:', e);
      throw new Error(`Error inserting groups: ${e.message}`);
    }
  }

  async insertUser() {
    const filePath = this.getTempFile('user.csv');
    if (!filePath) return;

    const lines = fs.readFileSync(filePath, 'utf-8').split('\n').slice(1); // Skip header

    try {
      for (const line of lines) {
        if (line.trim() === '') continue;
        const [
          id,
          group_id,
          state_id,
          name,
          surname,
          login,
          passwd,
          email,
          phone,
          is_dsm_admin,
          is_group_admin,
          is_planner,
          is_support_tech,
          photo,
        ] = line.split(',');
        const user = {
          id: parseInt(id),
          groupId: parseInt(group_id),
          stateId: parseInt(state_id),
          name: name,
          surname: surname,
          login: login,
          passwd: passwd,
          email: email,
          phone: phone,
          isDsmAdmin: is_dsm_admin.toLowerCase() === 'true',
          isGroupAdmin: is_group_admin.toLowerCase() === 'true',
          isPlanner: is_planner.toLowerCase() === 'true',
          isSupportTech: is_support_tech.toLowerCase() === 'true',
          photo: photo,
        };
        if (id) {
          await this.userRepository.merge(user);
        }
      }
    } catch (e) {
      console.error('Error inserting users:', e);
      throw new Error(`Error inserting users: ${e.message}`);
    }
  }
}

module.exports = TestService;
