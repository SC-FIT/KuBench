package com.example.repositories

import com.example.model.*
import com.example.model.Users.toUser
import com.example.plugins.DatabaseFactory.dbQuery
import com.example.plugins.DatabaseFactory.hikari
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.jetbrains.exposed.sql.ResultRow
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.select
import org.jetbrains.exposed.sql.selectAll
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction

class UserRepository {

    val sql = """
            SELECT u.id AS user_id,
                   g.name AS group_name,
                   g.contract_number,
                   g.institute_name,
                   g.institute_address_name,
                   g.city,
                   u.name,
                   u.surname,
                   u.login,
                   u.email,
                   u.phone,
                   s.label AS status_name,
                   u.is_dsm_admin,
                   u.is_group_admin,
                   u.is_planner,
                   u.is_support_tech,
                   u.photo
              FROM public."user" u
              JOIN public.usergroupstate s ON u.state_id = s.id
              JOIN public."group" g ON u.group_id = g.id
        """.trimIndent()

    suspend fun getAll(): List<User> = dbQuery {
        Users.selectAll().map { it.toUser() }
    }

    suspend fun getById(id: Int): User? = dbQuery {
        Users.select { Users.id eq id }
            .map { it.toUser() }
            .firstOrNull()
    }

    suspend fun addUser(user: User): Unit = dbQuery {
        Users.insert { row ->
            row[id] = user.id
            row[groupId] = user.groupId
            row[stateId] = user.stateId
            row[name] = user.name
            row[surname] = user.surname
            row[login] = user.login
            row[passwd] = user.passwd
            row[email] = user.email
            row[phone] = user.phone
            row[isDsmAdmin] = user.isDsmAdmin
            row[isGroupAdmin] = user.isGroupAdmin
            row[isPlanner] = user.isPlanner
            row[isSupportTech] = user.isSupportTech
            row[photo] = user.photo
        }
    }

    suspend fun save(user: User) {
        getById(user.id) ?: addUser(user);
    }

    suspend fun getFastRawResult(): List<Map<String, String>> = withContext(Dispatchers.IO) {
        hikari().connection.use { connection ->
            val statement = connection.prepareStatement(sql)
            val resultSet = statement.executeQuery()

            val results = mutableListOf<Map<String, String>>()

            while (resultSet.next()) {
                val metaData = resultSet.metaData
                val columnCount = metaData.columnCount
                val row = (1..columnCount).associate { index ->
                    metaData.getColumnName(index) to (resultSet.getObject(index)?.toString() ?: "null")
                }
                results.add(row)
            }

            results
        }
    }
}
