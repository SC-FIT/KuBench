package controllers

import (
	"encoding/json"
	"experiment/repositories"
	"experiment/services"
	"math/rand"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

type TestController struct {
	UserRepository *repositories.UserRepository
	TestService    *services.TestService
}

// DEVICE_INFO is a constant JSON string with device details
const DEVICE_INFO = `{
    "deviceName": "My Awesome Device",
    "deviceModel": "Model 123",
    "deviceOS": "Android 13",
    "appVersion": "1.2.3",
    "deviceID": "unique_device_id",
    "screenResolution": "1080x1920",
    "carrierName": "Carrier X",
    "locale": "en_US",
    "timezone": "America/Los_Angeles"
}`

// TestDevice returns a fixed JSON response
func (tc *TestController) TestDevice(c *gin.Context) {
	var deviceInfo map[string]interface{}
	if err := json.Unmarshal([]byte(DEVICE_INFO), &deviceInfo); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse device info"})
		return
	}
	c.JSON(http.StatusOK, deviceInfo)
}

// TestComplexSelect This function uses goroutines to fetch data from the database
func (tc *TestController) TestComplexSelect(c *gin.Context) {
	resultChan := make(chan interface{})
	errChan := make(chan error)

	go func() {
		test, err := tc.UserRepository.ComplexSelectTest()
		if err != nil {
			errChan <- err
			return
		}
		resultChan <- test
	}()

	select {
	case result := <-resultChan:
		c.JSON(http.StatusOK, result)
	case err := <-errChan:
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	case <-time.After(10 * time.Second): // Optional timeout
		c.JSON(http.StatusRequestTimeout, gin.H{"error": "request timed out"})
	}
}

func (tc *TestController) TestRandomSleep(c *gin.Context) {
	min := 2000
	max := 5000
	delay := time.Duration(rand.Intn(max-min)+min) * time.Millisecond
	time.Sleep(delay)
	c.Status(http.StatusNoContent)
}

func (tc *TestController) TestFileUpload(c *gin.Context) {
	file, err := c.FormFile("file")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to retrieve file"})
		return
	}

	err = c.SaveUploadedFile(file, file.Filename)
	if err != nil {
		return
	}
	// Process the file
	if err := tc.TestService.HandleFileUpload(file.Filename); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.Status(http.StatusOK)
}
