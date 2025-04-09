package com.example.plugins

import io.ktor.http.content.MultiPartData
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.application.*
import io.ktor.server.plugins.contentnegotiation.*

fun Application.configureSerialization() {
    install(ContentNegotiation) {
        json() // Add support for JSON responses
    }
}
