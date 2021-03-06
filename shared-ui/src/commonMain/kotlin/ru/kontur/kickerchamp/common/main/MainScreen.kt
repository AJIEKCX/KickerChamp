package ru.kontur.kickerchamp.common.main

import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import ru.kontur.kickerchamp.GameState
import ru.kontur.kickerchamp.MainScreenStore
import ru.kontur.kickerchamp.common.widgets.PlayerNameDialog
import ru.kontur.kickerchamp.common.widgets.PlayersWidget
import ru.kontur.kickerchamp.common.widgets.ScoreWidget
import ru.kontur.kickerchamp.common.widgets.StartGameWidget
import ru.kontur.kickerchamp.common.widgets.WinnerWidget

@Composable
fun MainScreen(store: MainScreenStore, onHighScoresClick: () -> Unit) {
    val state by store.state.collectAsState()

    if (state.dialogSate != null) {
        PlayerNameDialog(
            state = state.dialogSate!!,
            onDone = store::onPlayerNameChanged,
            onDismiss = store::onDialogDismiss
        )
    }

    PlayersWidget(
        players = state.players,
        onAddOrReplacePlayer = store::onAddPlayerClicked
    )

    when (val gameState = state.gameState) {
        is GameState.Started -> {
            ScoreWidget(
                blueScore = gameState.blueScore,
                redScore = gameState.redScore,
                onIncrementBlue = store::onIncrementBlue,
                onIncrementRed = store::onIncrementRed
            )
        }
        is GameState.NonStarted -> {
            StartGameWidget(
                isStartButtonEnabled = gameState.isStartButtonEnabled,
                onHighScoresClicked = onHighScoresClick,
                onStartGameClicked = store::onStartGameClicked
            )
        }
        is GameState.Finished -> {
            WinnerWidget(
                winnerTeam = gameState.winnerTeam,
                onRestartGameClicked = store::onRestartGameClicked,
                onRevengeClicked = store::onRevengeClicked,
                onHighScoresClicked = onHighScoresClick
            )
        }
    }
}