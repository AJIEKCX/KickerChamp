package ru.kontur.kickerchamp

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn
import ru.kontur.kickerchamp.db.Database

class HighScoreStore(database: Database) {
    private val coroutineScope = CoroutineScope(SupervisorJob() + Dispatchers.Main)

    val state = database.observePlayerScores()
        .map { HighScoreState(createOrderedPlayerScores(it)) }
        .stateIn(coroutineScope, SharingStarted.WhileSubscribed(), HighScoreState())

    private fun createOrderedPlayerScores(scores: List<PlayerScore>): List<OrderedPlayerScores> {
        return scores.mapIndexed { index: Int, item: PlayerScore ->
            OrderedPlayerScores(
                position = index + 1,
                name = item.name,
                wins = item.wins,
                goalsDiff = item.goalsDiff
            )
        }
    }
}