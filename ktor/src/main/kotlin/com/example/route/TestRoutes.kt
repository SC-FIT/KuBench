package com.example.route

import com.example.services.TestService
import com.example.services.UserService
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.coroutines.delay

fun Application.configureTestRoutes() {

    routing {
        route("/test") {
            val userService = UserService()
            val testService = TestService()

            get("/device") {
                val deviceInfo = """
            {
                "deviceName": "My Awesome Device",
                "deviceModel": "Model 123",
                "deviceOS": "Android 13",
                "appVersion": "1.2.3",
                "deviceID": "unique_device_id",
                "screenResolution": "1080x1920",
                "carrierName": "Carrier X",
                "locale": "en_US",
                "timezone": "America/Los_Angeles"
            }
            """.trimIndent()
                call.respondText(deviceInfo)
            }

            get("/complex-select") {
                val result = userService.complexSelect()
                call.respond(result)
            }

            get("/random-sleep") {
                val min = 2000
                val max = 5000
                val sleepTime = (min..max).random()
                delay(sleepTime.toLong())
                call.respond(HttpStatusCode.NoContent)
            }

            post("/file-upload") {
                val multipartData = call.receiveMultipart()
                var fileBytes: ByteArray? = null

                multipartData.forEachPart { part ->
                    if (part is PartData.FileItem) {
                        fileBytes = part.streamProvider().readBytes()
                    }
                    part.dispose()
                }

                fileBytes?.let {
                    testService.handleFileUpload(it)
                    call.respond(HttpStatusCode.OK, "File processed successfully")
                } ?: call.respond(HttpStatusCode.BadRequest, "No file uploaded")
            }
        }
    }
}
