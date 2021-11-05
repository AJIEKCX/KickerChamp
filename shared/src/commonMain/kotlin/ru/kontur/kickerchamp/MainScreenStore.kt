package ru.kontur.kickerchamp

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import ru.kontur.kickerchamp.db.Database

class MainScreenStore(
    private val database: Database
) {
    private val coroutineScope = CoroutineScope(SupervisorJob() + Dispatchers.Main)

    private val _state = MutableStateFlow(MainScreenState())
    val state = _state.asStateFlow()

    fun onIncrementRed() {
        val gameState = state.value.gameState
        if (gameState is GameState.Started) {
            onSetScoreRed(gameState.redScore + 1)
        }
    }

    fun onDecrementRed() {
        val gameState = state.value.gameState
        if (gameState is GameState.Started) {
            onSetScoreRed(gameState.redScore - 1)
        }
    }

    fun onSetScoreRed(score: Int) {
        if (score <= 0 || score > WIN_SCORE) return
        val gameState = state.value.gameState
        if (gameState is GameState.Started) {
            val newGameState = gameState.copy(redScore = score)
            _state.value = state.value.copy(gameState = newGameState)
            checkGameEnded(newGameState)
        }
    }

    fun onIncrementBlue() {
        val gameState = state.value.gameState
        if (gameState is GameState.Started) {
            onSetScoreBlue(gameState.blueScore + 1)
        }
    }

    fun onDecrementBlue() {
        val gameState = state.value.gameState
        if (gameState is GameState.Started) {
            onSetScoreBlue(gameState.blueScore - 1)
        }
    }

    fun onSetScoreBlue(score: Int) {
        if (score <= 0 || score > WIN_SCORE) return
        val gameState = state.value.gameState
        if (gameState is GameState.Started) {
            val newGameState = gameState.copy(blueScore = score)
            _state.value = state.value.copy(gameState = newGameState)
            checkGameEnded(newGameState)
        }
    }

    fun onRevengeClicked() {
        if (state.value.gameState is GameState.Finished) {
            _state.value = state.value.copy(gameState = GameState.Started())
        }
    }

    fun onRestartGameClicked() {
        if (state.value.gameState is GameState.Finished) {
            _state.value = MainScreenState()
        }
    }

    fun onStartGameClicked() {
        if (state.value.gameState is GameState.NonStarted) {
            _state.value = state.value.copy(gameState = GameState.Started())
        }
    }

    fun onPlayerNameChanged(player: Player, name: String) {
        if (state.value.gameState !is GameState.NonStarted) return
        if (validatePlayerName(name).not()) return

        when (player) {
            is BlueDefender -> _state.value = state.value.copy(blueDefender = BlueDefender(name), dialogSate = null)
            is BlueForward -> _state.value = state.value.copy(blueForward = BlueForward(name), dialogSate = null)
            is RedDefender -> _state.value = state.value.copy(redDefender = RedDefender(name), dialogSate = null)
            is RedForward -> _state.value = state.value.copy(redForward = RedForward(name), dialogSate = null)
        }
        checkStartButtonEnabled()
    }

    fun onAddPlayerClicked(player: Player) {
        _state.value = state.value.copy(dialogSate = DialogState(player))
    }

    fun onDialogDismiss() {
        _state.value = state.value.copy(dialogSate = null)
    }

    private fun checkGameEnded(gameState: GameState.Started) {
        if (gameState.blueScore == WIN_SCORE) {
            saveScores(listOf(state.value.blueDefender, state.value.blueForward), WIN_SCORE - gameState.redScore)
            _state.value = state.value.copy(
                gameState = GameState.Finished(
                    winnerTeam = BlueTeam,
                    winner = "Blue wins"
                )
            )
        }

        if (gameState.redScore == WIN_SCORE) {
            saveScores(listOf(state.value.redDefender, state.value.redForward), WIN_SCORE - gameState.blueScore)
            _state.value = state.value.copy(
                gameState = GameState.Finished(
                    winnerTeam = RedTeam,
                    winner = "Red wins"
                )
            )
        }
    }

    private fun saveScores(
        winnerPlayers: List<Player>,
        goalsDiff: Int
    ) {
        coroutineScope.launch {
            val playerScores = database.getPlayerScores()
            val newPlayerScores = state.value.players.map { player ->
                val previousScore = playerScores.find { it.name == player.name }
                val previousWins = previousScore?.wins ?: 0
                val previousGoalsDiff = previousScore?.goalsDiff ?: 0
                PlayerScore(
                    name = player.name,
                    wins = if (player in winnerPlayers) previousWins + 1 else previousWins,
                    goalsDiff = if (player in winnerPlayers) previousGoalsDiff + goalsDiff else previousGoalsDiff - goalsDiff
                )
            }
            database.savePlayerScores(newPlayerScores)
        }
    }

    private fun validatePlayerName(name: String): Boolean {
        if (name.isBlank()) return false

        return state.value.players.none { it.name.equals(name, ignoreCase = true) }
    }

    private fun checkStartButtonEnabled() {
        val isEnabled = state.value.players.all { it.name.isNotEmpty() }
        _state.value = state.value.copy(gameState = GameState.NonStarted(isEnabled))
    }

    companion object {
        const val WIN_SCORE = 10
    }
}