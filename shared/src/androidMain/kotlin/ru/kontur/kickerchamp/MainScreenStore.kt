package ru.kontur.kickerchamp

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow

class MainScreenStore {
    private val _state = MutableStateFlow(MainScreenState())
    val state = _state.asStateFlow()

    fun onIncrementRed() {
        val gameState = state.value.gameState
        if (gameState is GameState.Started) {
            val newGameState = gameState.copy(redScore = gameState.redScore + 1)
            _state.value = state.value.copy(gameState = newGameState)
            checkGameEnded(newGameState)
        }
    }

    fun onIncrementBlue() {
        val gameState = state.value.gameState
        if (gameState is GameState.Started) {
            val newGameState = gameState.copy(blueScore = gameState.blueScore + 1)
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
            _state.value = state.value.copy(
                gameState = GameState.Finished(
                    winnerTeam = BlueTeam,
                    winner = "Blue wins"
                )
            )
        }

        if (gameState.redScore == WIN_SCORE) {
            _state.value = state.value.copy(
                gameState = GameState.Finished(
                    winnerTeam = RedTeam,
                    winner = "Red wins"
                )
            )
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
        private const val WIN_SCORE = 10
    }
}