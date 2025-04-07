package com.example.model

import org.jetbrains.exposed.sql.ResultRow
import org.jetbrains.exposed.sql.Table

data class User(
    val id: Int,
    val groupId: Int,
    val stateId: Int,
    val name: String,
    val surname: String,
    val login: String,
    val passwd: String?,
    val email: String,
    val phone: String?,
    val isDsmAdmin: Boolean,
    val isGroupAdmin: Boolean,
    val isPlanner: Boolean,
    val isSupportTech: Boolean,
    val photo: String?
)

object Users : Table("\"user\"") { // Use "user" if that's your actual table name
    val id = integer("id").autoIncrement()
    val groupId = integer("group_id").references(Groups.id) // Foreign key to Groups
    val stateId = integer("state_id").references(UserGroupStates.id) // Foreign key to UserGroupStates
    val name = varchar("name", 255) // Adjust lengths as needed
    val surname = varchar("surname", 255)
    val login = varchar("login", 255)
    val passwd = varchar("passwd", 255).nullable()
    val email = varchar("email", 255)
    val phone = varchar("phone", 255).nullable()
    val isDsmAdmin = bool("is_dsm_admin")
    val isGroupAdmin = bool("is_group_admin")
    val isPlanner = bool("is_planner")
    val isSupportTech = bool("is_support_tech")
    val photo = varchar("photo", 255).nullable()

    override val primaryKey = PrimaryKey(id)

    public fun ResultRow.toUser() = User(
        id = this[Users.id],
        groupId = this[Users.groupId],
        stateId = this[Users.stateId],
        name = this[Users.name],
        surname = this[Users.surname],
        login = this[Users.login],
        passwd = this[Users.passwd],
        email = this[Users.email],
        phone = this[Users.phone],
        isDsmAdmin = this[Users.isDsmAdmin],
        isGroupAdmin = this[Users.isGroupAdmin],
        isPlanner = this[Users.isPlanner],
        isSupportTech = this[Users.isSupportTech],
        photo = this[Users.photo]
    )
}
