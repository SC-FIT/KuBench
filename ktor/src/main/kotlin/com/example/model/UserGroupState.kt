package com.example.model

import org.jetbrains.exposed.sql.ResultRow
import org.jetbrains.exposed.sql.Table

data class UserGroupState (
    val id: Int,
    val label: String
)

object UserGroupStates : Table("usergroupstate") {
    val id = integer("id").autoIncrement()
    val label = varchar("label", 255)

    override val primaryKey = PrimaryKey(id)

    fun ResultRow.toUserGroupState() = UserGroupState(
        id = this[id],
        label = this[label]
    )
}
