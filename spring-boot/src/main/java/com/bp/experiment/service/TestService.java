package com.bp.experiment.service;

import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.bp.experiment.dao.model.Group;
import com.bp.experiment.dao.model.User;
import com.bp.experiment.dao.model.Usergroupstate;
import com.bp.experiment.dao.repository.GroupRepository;
import com.bp.experiment.dao.repository.UserRepository;
import com.bp.experiment.dao.repository.UsergroupstateRepository;
import com.opencsv.CSVParserBuilder;
import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;
import com.opencsv.exceptions.CsvValidationException;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TestService {


    private final EntityManager entityManager;
    private final UsergroupstateRepository usergroupstateRepository;
    private final GroupRepository groupRepository;
    private final UserRepository userRepository;

    @Getter
    private final Map<String, Path> tempFilesByOriginalFileName = new HashMap<>();

    public void handleFileUpload(MultipartFile file) throws CsvValidationException, IOException, ParseException {
        openZipFile(file);
        importFromFile();
    }

    @Transactional
    public void importFromFile() throws CsvValidationException, IOException, ParseException {
        insertGroupState();
        insertGroup();
        insertUser();
    }

    private void insertGroupState() throws CsvValidationException, IOException {
        try {
            InputStream file = new FileInputStream(getTempFile("usergroupstate.csv").toFile());
            CSVReader reader = buildRuianCsvReader(new InputStreamReader(file));
            // skip head
            String[] line = reader.readNext();
            while ((line = reader.readNext()) != null) {
                Usergroupstate usergroupstate = Usergroupstate.builder().id(Integer.parseInt(line[0])).label(line[1]).build();
                usergroupstateRepository.save(usergroupstate);
                entityManager.clear();
            }
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private void insertGroup() throws CsvValidationException, IOException, ParseException {
        try {
            InputStream file = new FileInputStream(getTempFile("group.csv").toFile());
            CSVReader reader = buildRuianCsvReader(new InputStreamReader(file));
            // skip head
            String[] line = reader.readNext();
            while ((line = reader.readNext()) != null) {
                Group group = Group.builder().id(Integer.parseInt(line[0])).name(line[1]).contractSigned(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(line[2]).toInstant()).contractNumber(Integer.parseInt(line[3])).instituteName(line[4]).instituteAddressName(line[5]).instituteAddressNumber(line[6]).institutePostalCode(line[7]).province(line[8]).city(line[9]).country(line[10]).vat(line[11]).institutePhone(line[12]).instituteEmail(line[13]).state(usergroupstateRepository.findById(Integer.parseInt(line[14])).get()).priority(Float.parseFloat(line[16])).build();
                groupRepository.save(group);
                entityManager.clear();
            }
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private void insertUser() {
        try {
            InputStream file = new FileInputStream(getTempFile("user.csv").toFile());
            CSVReader reader = buildRuianCsvReader(new InputStreamReader(file));
            // skip head
            String[] line = reader.readNext();
            while ((line = reader.readNext()) != null && line.length > 0) {
                User user = User.builder().id(Integer.parseInt(line[0])).group(groupRepository.findById(Integer.parseInt(line[1])).get()).state(usergroupstateRepository.findById(Integer.parseInt(line[2])).get()) // Assuming Usergroupstate has a constructor with id
                        .name(line[3]).surname(line[4]).login(line[5]).passwd(line[6]).email(line[7]).phone(line[8]).isDsmAdmin(Boolean.parseBoolean(line[9])).isGroupAdmin(Boolean.parseBoolean(line[10])).isPlanner(Boolean.parseBoolean(line[11])).isSupportTech(Boolean.parseBoolean(line[12])).photo(line[13]).build();
                userRepository.save(user);
                entityManager.clear();
            }
        } catch (IOException | CsvValidationException e) {
            throw new RuntimeException(e);
        }
    }

    private CSVReader buildRuianCsvReader(Reader reader) {
        return new CSVReaderBuilder(reader).withCSVParser(new CSVParserBuilder().withSeparator(',').build()).build();
    }

    private void openZipFile(MultipartFile file) {
        try (ZipInputStream zis = new ZipInputStream(file.getInputStream())) {
            ZipEntry entry;
            while ((entry = zis.getNextEntry()) != null) {
                if (!entry.isDirectory() && entry.getName().endsWith(".csv")) {
                    Path tempFile = createTempFile(entry.getName());
                    try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(tempFile.toFile()))) {
                        byte[] buffer = new byte[1024];
                        int len;
                        while ((len = zis.read(buffer)) > 0) {
                            bos.write(buffer, 0, len);
                        }
                    }
                }
                zis.closeEntry();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Path createTempFile(String fileName) {
        try {
            Path tempFile = Files.createTempFile("tmp", fileName);
            tempFilesByOriginalFileName.put(fileName, tempFile);
            return tempFile;
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    private Path getTempFile(String filePath) {
        return tempFilesByOriginalFileName.get(filePath);
    }

}
