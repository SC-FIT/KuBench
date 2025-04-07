package com.example.services

import com.example.model.Group
import com.example.model.User
import com.example.model.UserGroupState
import com.example.plugins.DatabaseFactory
import com.example.repositories.GroupRepository
import com.example.repositories.UserGroupStateRepository
import com.example.repositories.UserRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction
import org.jetbrains.exposed.sql.transactions.transaction
import java.io.*
import java.nio.file.*
import java.text.SimpleDateFormat
import java.util.zip.ZipEntry
import java.util.zip.ZipInputStream

class TestService {
    private val userGroupStateRepository = UserGroupStateRepository()
    private val userRepository = UserRepository()
    private val groupRepository = GroupRepository()

    private val tempFilesByOriginalFileName = mutableMapOf<String, Path>()

    suspend fun handleFileUpload(fileBytes: ByteArray) {
        val tempZipFile = createTemporaryFile("uploaded")

        try {
            Files.write(tempZipFile, fileBytes)
            openZipFile(tempZipFile)
            importFromFile()
        } finally {
            Files.deleteIfExists(tempZipFile)
        }
    }

    /**
     * Opens a ZIP file and processes any CSV files within it.
     */
    private fun openZipFile(zipFilePath: Path) {
        ZipInputStream(Files.newInputStream(zipFilePath)).use { zis ->
            var entry: ZipEntry?
            while (zis.nextEntry.also { entry = it } != null) {
                entry?.let {
                    if (!it.isDirectory && it.name.endsWith(".csv")) {
                        val tempFile = createTemporaryFile(it.name)
                        Files.newOutputStream(tempFile).use { output ->
                            zis.copyTo(output)
                        }
                    }
                }
                zis.closeEntry()
            }
        }
    }


    private suspend fun importFromFile() {
        processUserGroupStateFile()
        processGroupFile()
        processUserFile()
    }

    private fun getCsvReader(filePath: Path): CSVParser {
        val reader = Files.newBufferedReader(filePath)
        return CSVParser(reader, CSVFormat.DEFAULT.builder().setHeader().build())
    }

    private suspend fun processUserGroupStateFile() = withContext(Dispatchers.IO) {
        try {
            val usergroupstate = tempFilesByOriginalFileName["usergroupstate.csv"]
            if (usergroupstate != null) {
                newSuspendedTransaction {
                    getCsvReader(usergroupstate).use { parser ->
                        parser.records.forEach { record ->
                            val userGroupState = UserGroupState(
                                record.get("id").toInt(),
                                record.get("label")
                            )
                            userGroupStateRepository.save(userGroupState)
                        }
                    }
                }
            }
        } catch (e: Exception) {
            println("Error: ${e.message}")
        }
    }

    private suspend fun processGroupFile() = withContext(Dispatchers.IO) {
        try {
            val groupFile = tempFilesByOriginalFileName["group.csv"]
            if (groupFile != null) {
                newSuspendedTransaction {
                    getCsvReader(groupFile).use { parser ->
                        parser.records.forEach { record ->
                            val group = Group (
                                record.get("id").toInt(),
                                record.get("name"),
                                    SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(record.get("contract_signed")).toInstant(),
                                record.get("contract_number").toInt(),
                                record.get("institute_name"),
                                record.get("institute_address_name"),
                                record.get("institute_address_number"),
                                record.get("institute_postal_code"),
                                record.get("province"),
                                record.get("city"),
                                record.get("country"),
                                record.get("vat"),
                                record.get("institute_phone"),
                                record.get("institute_email"),
                                record.get("state_id").toInt(),
                                record.get("priority").toFloat(),
                            )
                            groupRepository.save(group) // Save to the database
                        }
                    }
                }
            }
        } catch (e: Exception) {
            println("Error: ${e.message}")
        }
    }

    private suspend fun processUserFile() = withContext(Dispatchers.IO) {
        try {
                val userFile = tempFilesByOriginalFileName["user.csv"]
                if (userFile != null) {
                    newSuspendedTransaction {
                    getCsvReader(userFile).use { parser ->
                        parser.records.forEach { record ->
                            val user = User (
                                record.get("id").toInt(),
                                record.get("group_id").toInt(),
                                record.get("state_id").toInt(),
                                record.get("name"),
                                record.get("surname"),
                                record.get("login"),
                                record.get("passwd"),
                                record.get("email"),
                                record.get("phone"),
                                record.get("is_dsm_admin").toBoolean(),
                                record.get("is_group_admin").toBoolean(),
                                record.get("is_planner").toBoolean(),
                                record.get("is_support_tech").toBoolean(),
                                record.get("photo"),
                            )
                            userRepository.save(user)
                        }
                    }
                }
            }
        } catch (e: Exception) {
            println("Error: ${e.message}")
        }
    }

    private fun createTemporaryFile(fileName: String): Path {
        val tempFile = Files.createTempFile("tmp", fileName)
        tempFilesByOriginalFileName[fileName] = tempFile
        return tempFile
    }
}
