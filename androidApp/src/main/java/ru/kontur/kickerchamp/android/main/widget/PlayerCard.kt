package ru.kontur.kickerchamp.android.main.widget

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Card
import androidx.compose.material.Icon
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import ru.kontur.kickerchamp.BlueDefender
import ru.kontur.kickerchamp.BlueForward
import ru.kontur.kickerchamp.BlueTeam
import ru.kontur.kickerchamp.Defender
import ru.kontur.kickerchamp.Forward
import ru.kontur.kickerchamp.Player
import ru.kontur.kickerchamp.RedDefender
import ru.kontur.kickerchamp.RedForward
import ru.kontur.kickerchamp.RedTeam
import ru.kontur.kickerchamp.Team
import ru.kontur.kickerchamp.android.R
import ru.kontur.kickerchamp.android.theme.AppTheme

@Composable
fun PlayerCard(
    player: Player,
    onAddOrReplacePlayer: (Player) -> Unit,
    modifier: Modifier = Modifier
) {
    val shape = when (player) {
        is BlueDefender -> RoundedCornerShape(topEnd = 100.dp)
        is BlueForward -> RoundedCornerShape(bottomEnd = 100.dp)
        is RedDefender -> RoundedCornerShape(topStart = 100.dp)
        is RedForward -> RoundedCornerShape(bottomStart = 100.dp)
    }

    val playerButtonColor = when (player as Team) {
        is BlueTeam -> MaterialTheme.colors.primary
        is RedTeam -> MaterialTheme.colors.secondary
    }

    Card(
        modifier = modifier,
        shape = shape,
    ) {
        Column(
            Modifier
                .padding(vertical = 8.dp)
                .size(150.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            if (player is Forward) {
                PlayerRoleTitle(title = "Forward", R.drawable.ic_forward)
            }
            Spacer(Modifier.weight(1f))
            AddOrReplacePlayerButton(player, playerButtonColor, onAddOrReplacePlayer)
            Spacer(Modifier.weight(1f))
            if (player is Defender) {
                PlayerRoleTitle(title = "Defender", R.drawable.ic_defender)
            }
        }
    }
}

@Composable
private fun PlayerRoleTitle(title: String, iconRes: Int) {
    Row(verticalAlignment = Alignment.CenterVertically) {
        Text(title, style = MaterialTheme.typography.h6)
        Spacer(Modifier.width(8.dp))
        Icon(
            painterResource(iconRes),
            contentDescription = null
        )
    }
}

@Composable
private fun AddOrReplacePlayerButton(
    player: Player,
    color: Color,
    onClick: (Player) -> Unit
) {
    if (player.name.isNotEmpty()) {
        Text(
            player.name,
            modifier = Modifier
                .clickable { onClick(player) }
                .padding(horizontal = 16.dp),
            style = MaterialTheme.typography.h5,
            color = color,
            overflow = TextOverflow.Ellipsis,
            maxLines = 1
        )
    } else {
        Button(
            onClick = { onClick(player) },
            modifier = Modifier.size(64.dp),
            shape = CircleShape,
            colors = ButtonDefaults.buttonColors(backgroundColor = color)
        ) {
            Icon(Icons.Default.Add, contentDescription = null)
        }
    }
}

@Preview(showBackground = true)
@Composable
private fun PlayerCardBlueForwardPreview() {
    AppTheme {
        PlayerCard(BlueForward(), {})
    }
}

@Preview(showBackground = true)
@Composable
private fun PlayerCardBlueDefenderPreview() {
    AppTheme {
        PlayerCard(BlueDefender(), {})
    }
}

@Preview(showBackground = true)
@Composable
private fun PlayerCardRedForwardPreview() {
    AppTheme {
        PlayerCard(RedForward(), {})
    }
}

@Preview(showBackground = true)
@Composable
private fun PlayerCardRedDefenderPreview() {
    AppTheme {
        PlayerCard(RedDefender(), {})
    }
}