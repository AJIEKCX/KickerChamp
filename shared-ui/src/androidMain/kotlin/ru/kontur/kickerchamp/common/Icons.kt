package ru.kontur.kickerchamp.common

import androidx.compose.material.Icon
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource

@Composable
internal actual fun IncrementIcon(modifier: Modifier) {
    Icon(
        painterResource(R.drawable.ic_increment),
        contentDescription = null,
        modifier = modifier
    )
}

@Composable
internal actual fun DefenderIcon() {
    Icon(
        painterResource(R.drawable.ic_defender),
        contentDescription = null
    )
}

@Composable
internal actual fun ForwardIcon() {
    Icon(
        painterResource(R.drawable.ic_forward),
        contentDescription = null
    )
}