package com.example.services

import com.example.repositories.UserRepository


class UserService() {

    private val userRepository = UserRepository()

    suspend fun complexSelect() : List<Map<String, String>> {
        return userRepository.getFastRawResult()
    }
}
