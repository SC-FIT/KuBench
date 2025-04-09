package com.example.plugins

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import kotlinx.coroutines.Dispatchers
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction

object DatabaseFactory {
    val dbHost = System.getenv("DB_HOST") ?: "localhost"
    val dbPort = System.getenv("DB_PORT") ?: "6543"
    val dbName = System.getenv("DB_NAME") ?: "experiment"
    val dbUser = System.getenv("DB_USERNAME") ?: "admin"
    val dbPassword = System.getenv("DB_PASSWORD") ?: "admin"

    fun init() {
        println("Initialization")
        Database.connect(hikari())
        println("Initialization done")
    }

    private val hikariDataSource: HikariDataSource by lazy {
        HikariConfig().apply {
            jdbcUrl = "jdbc:postgresql://$dbHost:$dbPort/$dbName"
            driverClassName = "org.postgresql.Driver"
            username = dbUser
            password = dbPassword
            maximumPoolSize = 2
            minimumIdle = 1
            isAutoCommit = false
            transactionIsolation = "TRANSACTION_REPEATABLE_READ"
            leakDetectionThreshold = 2000
            validate()
        }.let { HikariDataSource(it) }
    }

    fun hikari(): HikariDataSource = hikariDataSource

    suspend fun <T> dbQuery(block: suspend () -> T): T =
        newSuspendedTransaction(Dispatchers.IO) { block() }
}
