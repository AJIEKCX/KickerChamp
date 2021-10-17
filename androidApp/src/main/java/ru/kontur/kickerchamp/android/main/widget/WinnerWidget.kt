package ru.kontur.kickerchamp.android.main.widget

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import ru.kontur.kickerchamp.android.theme.AppTheme

@Composable
fun WinnerWidget(
    winner: String,
    color: Color,
    onRestartGameClicked: () -> Unit,
    onRevengeClicked: () -> Unit,
) {
    Box(Modifier.fillMaxSize()) {
        Column(
            Modifier.align(Alignment.Center),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                winner,
                style = MaterialTheme.typography.h3,
                color = color,
            )
            Spacer(Modifier.height(16.dp))
            Button(onClick = onRestartGameClicked) {
                Text("Start new game", Modifier.padding(vertical = 8.dp, horizontal = 32.dp))
            }
            Spacer(Modifier.height(16.dp))
            Button(onClick = onRevengeClicked) {
                Text("Revenge", Modifier.padding(vertical = 8.dp, horizontal = 32.dp))
            }
        }
    }
}

@Preview
@Composable
fun WinnerWidgetPreview() {
    AppTheme {
        WinnerWidget("Red wins", Color.Red, {}, {})
    }
}