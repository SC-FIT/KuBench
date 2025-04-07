package com.bp.experiment.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;
import java.util.Map;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.bp.experiment.dao.repository.UserRepository;
import com.bp.experiment.service.TestService;
import com.opencsv.exceptions.CsvValidationException;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class TestController {

    private final TestService testService;

    private final String DEVICE_INFO = """
            {
                "deviceName": "My Awesome Device1",
                "deviceModel": "Model 123",
                "deviceOS": "Android 13",
                "appVersion": "1.2.3",
                "deviceID": "unique_device_id",
                "screenResolution": "1080x1920",
                "carrierName": "Carrier X",
                "locale": "en_US",
                "timezone": "America/Los_Angeles"
            }
            """;
    private final UserRepository userRepository;

    @GetMapping("/test/device")
    public ResponseEntity<String> testDevice() {
        return ResponseEntity.ok(DEVICE_INFO);
    }

    @GetMapping("/test/complex-select")
    public ResponseEntity<List<Map<String, Object>>> testComplexSelect() {
        return ResponseEntity.ok(userRepository.complexSelectTest());
    }

    @GetMapping("/test/random-sleep")
    public ResponseEntity<Void> testRandomSleep() {
        int min = 2000;
        int max = 5000;
        try {
            Thread.sleep((int) ((Math.random() * (max - min)) + min));
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/test/file-upload")
    public ResponseEntity testFileUpload(@RequestParam("file") MultipartFile file) {
        try {
            testService.handleFileUpload(file);
        } catch (CsvValidationException | IOException | ParseException e) {
            ResponseEntity.internalServerError().body(e.getMessage());
        }
        return ResponseEntity.ok().build();
    }

}
