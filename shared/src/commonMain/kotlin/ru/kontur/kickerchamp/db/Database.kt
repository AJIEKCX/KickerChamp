package ru.kontur.kickerchamp.db

import com.squareup.sqldelight.runtime.coroutines.asFlow
import com.squareup.sqldelight.runtime.coroutines.mapToList
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.withContext
import ru.kontur.kickerchamp.PlayerScore

class Database(databaseDriverFactory: DatabaseDriverFactory) {
    private val database = AppDatabase(databaseDriverFactory.createDriver())
    private val dbQuery = database.appDatabaseQueries

    fun observePlayerScores(): Flow<List<PlayerScore>> {
        return dbQuery.selectAllByRating().asFlow().mapToList()
    }

    suspend fun getPlayerScores(): List<PlayerScore> {
        return withContext(Dispatchers.Default) {
            dbQuery.selectAll().executeAsList()
        }
    }

    suspend fun savePlayerScores(list: List<PlayerScore>) {
        withContext(Dispatchers.Default) {
            dbQuery.transaction {
                list.forEach { dbQuery.insert(it) }
            }
        }
    }
}