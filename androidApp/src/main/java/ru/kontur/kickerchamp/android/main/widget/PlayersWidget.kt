package ru.kontur.kickerchamp.android.main.widget

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import ru.kontur.kickerchamp.Player

@Composable
fun PlayersWidget(
    players: List<Player>,
    onAddOrReplacePlayer: (Player) -> Unit
) {
    val alignments = listOf(
        Alignment.TopStart,
        Alignment.BottomStart,
        Alignment.TopEnd,
        Alignment.BottomEnd
    )
    Box(Modifier.fillMaxSize()) {
        players.forEachIndexed { index, player ->
            PlayerCard(player, onAddOrReplacePlayer, Modifier.align(alignments[index]))
        }
    }
}