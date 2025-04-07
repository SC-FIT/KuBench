package com.example.repositories

import com.example.model.Group
import com.example.model.Groups
import com.example.model.Groups.toGroup
import com.example.plugins.DatabaseFactory
import com.example.plugins.DatabaseFactory.dbQuery
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.select
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction

class GroupRepository {
    suspend fun getById(id: Int): Group? = dbQuery {
        Groups.select { Groups.id eq id }
            .map { it.toGroup() }
            .singleOrNull()
    }

    suspend fun create(group: Group) = dbQuery{
        Groups.insert {
            it[id] = group.id
            it[name] = group.name
            it[contractSigned] = group.contractSigned
            it[contractNumber] = group.contractNumber
            it[instituteName] = group.instituteName
            it[instituteAddressName] = group.instituteAddressName
            it[instituteAddressNumber] = group.instituteAddressNumber
            it[institutePostalCode] = group.institutePostalCode
            it[province] = group.province
            it[city] = group.city
            it[country] = group.country
            it[vat] = group.vat
            it[institutePhone] = group.institutePhone
            it[instituteEmail] = group.instituteEmail
            it[stateId] = group.stateId
            it[priority] = group.priority
        }
    }

    suspend fun save(group: Group) = dbQuery {
        getById(group.id) ?: create(group)
    }
}
