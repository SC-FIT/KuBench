package com.example.repositories

import com.example.model.UserGroupState
import com.example.model.UserGroupStates
import com.example.model.UserGroupStates.toUserGroupState
import com.example.plugins.DatabaseFactory
import com.example.plugins.DatabaseFactory.dbQuery
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction
import org.ktorm.dsl.eq

class UserGroupStateRepository {

    suspend fun getAll(): List<UserGroupState> = dbQuery {
        UserGroupStates.selectAll().map { it.toUserGroupState() }
    }

    suspend fun getById(id: Int): UserGroupState? = dbQuery {
        UserGroupStates.select { UserGroupStates.id eq id }
            .map { it.toUserGroupState() }
            .singleOrNull()
    }

    suspend fun create(userGroupState: UserGroupState) = dbQuery {
        UserGroupStates.insert {
            it[id] = userGroupState.id
            it[label] = userGroupState.label
        }
    }

    suspend fun save(userGroupState: UserGroupState) = dbQuery {
        getById(userGroupState.id) ?: create(userGroupState)
    }
}
