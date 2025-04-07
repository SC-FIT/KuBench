package main

import (
	"experiment/common"
	"experiment/controllers"
	"experiment/repositories"
	"experiment/services"
	"github.com/gin-gonic/gin"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"runtime"
	"time"
)

var (
	cpuUsageGauge = prometheus.NewGaugeVec(
		prometheus.GaugeOpts{
			Name: "go_app_cpu_usage_seconds_total",
			Help: "Total CPU time used by the application.",
		},
		[]string{"type"},
	)
	memStatsGauge = prometheus.NewGaugeVec(
		prometheus.GaugeOpts{
			Name: "go_app_memory_bytes",
			Help: "Memory usage of the application.",
		},
		[]string{"type"},
	)
)

func init() {
	// Register custom metrics with Prometheus
	prometheus.MustRegister(cpuUsageGauge)
	prometheus.MustRegister(memStatsGauge)
	common.ConnectDatabase()
}

func recordMetrics() {
	var memStats runtime.MemStats

	go func() {
		for {
			// Get memory stats
			runtime.ReadMemStats(&memStats)

			// Record memory usage
			memStatsGauge.WithLabelValues("heap_alloc").Set(float64(memStats.HeapAlloc))
			memStatsGauge.WithLabelValues("total_alloc").Set(float64(memStats.TotalAlloc))
			memStatsGauge.WithLabelValues("stack_inuse").Set(float64(memStats.StackInuse))
			memStatsGauge.WithLabelValues("sys").Set(float64(memStats.Sys))

			// Record CPU usage
			cpuUsageGauge.WithLabelValues("goroutines").Set(float64(runtime.NumGoroutine()))

			// Sleep for a short interval
			time.Sleep(5 * time.Second)
		}
	}()
}

func registerRoutes() *gin.Engine {

	usergroupRepository := &repositories.UsergroupstateRepository{Db: common.Db}
	groupRepository := &repositories.GroupRepository{Db: common.Db}
	userRepository := &repositories.UserRepository{Db: common.Db}
	testService := &services.TestService{
		UserRepository:           userRepository,
		GroupRepository:          groupRepository,
		UsergroupstateRepository: usergroupRepository,
	}

	testController := &controllers.TestController{
		UserRepository: userRepository,
		TestService:    testService,
	}

	router := gin.Default()

	router.GET("/test/device", testController.TestDevice)

	router.GET("/test/random-sleep", testController.TestRandomSleep)

	router.GET("/test/complex-select", testController.TestComplexSelect)

	router.POST("/test/file-upload", testController.TestFileUpload)

	router.GET("/metrics", gin.WrapH(promhttp.Handler()))

	return router
}

func main() {

	recordMetrics()

	err := registerRoutes().Run()
	if err != nil {
		return
	}
}
