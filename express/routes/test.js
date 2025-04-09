const express = require('express');
const router = express.Router();
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });
const userService = require('../services/userService');
const TestService = require("../services/testService");

router.get('/device', async function(req, res) {
  const device = {
    deviceName: 'My Awesome Device',
    deviceModel: 'Model 123',
    deviceOS: 'Android 13',
    appVersion: '1.2.3',
    deviceID: 'unique_device_id',
    screenResolution: '1080x1920',
    carrierName: 'Carrier X',
    locale: 'en_US',
    timezone: 'America/Los_Angeles',
  };

  res.json(device);
});

router.get('/random-sleep', async function(req, res) {
    const min = 2000;
    const max = 5000;
    const sleepTime = Math.floor(Math.random() * (max - min + 1)) + min;

    await new Promise(resolve => setTimeout(resolve, sleepTime));

    res.status(204).send();
});

router.get('/complex-select', async function(req, res) {
  try {
    const userView = await userService.complexSelect();
    res.json(userView);
  } catch (error) {
    console.error(error);
    res.status(500).send();
  }
});

router.post('/file-upload', upload.single('file'), async (req, res) => {
  try {
    const testService = new TestService();
    console.log('File uploaded:', req.file);
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }

    await testService.handleFileUpload(req.file);

    res.status(200).json({ message: 'File processed successfully' });
  } catch (error) {
    console.error('Error during file upload:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
