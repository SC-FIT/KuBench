package com.example.model

import org.jetbrains.exposed.sql.ResultRow
import org.jetbrains.exposed.sql.javatime.timestamp
import org.jetbrains.exposed.sql.Table
import java.time.Instant

data class Group(
    val id: Int,
    val name: String,
    val contractSigned: Instant,
    val contractNumber: Int?,
    val instituteName: String?,
    val instituteAddressName: String,
    val instituteAddressNumber: String?,
    val institutePostalCode: String,
    val province: String?,
    val city: String,
    val country: String,
    val vat: String?,
    val institutePhone: String,
    val instituteEmail: String,
    val stateId: Int,  // Store the foreign key to UserGroupState
    val priority: Float
    // val responsibleUserId: Int? // If you add the responsibleUser relationship
)

object Groups : Table("group") {
    val id = integer("id").autoIncrement()
    val name = varchar("name", 255) // Adjust length as needed
    val contractSigned = timestamp("contract_signed")
    val contractNumber = integer("contract_number").nullable()
    val instituteName = varchar("institute_name", 255).nullable()
    val instituteAddressName = varchar("institute_address_name", 255)
    val instituteAddressNumber = varchar("institute_address_number", 255).nullable()
    val institutePostalCode = varchar("institute_postal_code", 255)
    val province = varchar("province", 255).nullable()
    val city = varchar("city", 255)
    val country = varchar("country", 255)
    val vat = varchar("vat", 255).nullable()
    val institutePhone = varchar("institute_phone", 255)
    val instituteEmail = varchar("institute_email", 255)
    val stateId = integer("state_id").references(UserGroupStates.id)
    val priority = float("priority")
    // val responsibleUserId = integer("responsible_user_id").references(Users.id).nullable() // If needed

    override val primaryKey = PrimaryKey(id)

    fun ResultRow.toGroup() = Group(
        id = this[Groups.id],
        name = this[Groups.name],
        contractSigned = this[Groups.contractSigned],
        contractNumber = this[Groups.contractNumber],
        instituteName = this[Groups.instituteName],
        instituteAddressName = this[Groups.instituteAddressName],
        instituteAddressNumber = this[Groups.instituteAddressNumber],
        institutePostalCode = this[Groups.institutePostalCode],
        province = this[Groups.province],
        city = this[Groups.city],
        country = this[Groups.country],
        vat = this[Groups.vat],
        institutePhone = this[Groups.institutePhone],
        instituteEmail = this[Groups.instituteEmail],
        stateId = this[Groups.stateId],
        priority = this[Groups.priority]
        // responsibleUserId = this.getOrNull(Groups.responsibleUserId) // If you have responsibleUser
    )
}
