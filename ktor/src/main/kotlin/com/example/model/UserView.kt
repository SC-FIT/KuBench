package com.example.model

import kotlinx.serialization.Serializable

@Serializable
data class UserView(
    val userId: Int,
    val groupName: String,
    val contractNumber: Int?,
    val instituteName: String?,
    val instituteAddressName: String,
    val city: String,
    val name: String,
    val surname: String,
    val login: String,
    val email: String,
    val phone: String?,
    val statusName: String,
    val isDsmAdmin: Boolean,
    val isGroupAdmin: Boolean,
    val isPlanner: Boolean,
    val isSupportTech: Boolean,
    val photo: String?
)

