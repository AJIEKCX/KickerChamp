package ru.kontur.kickerchamp.android.main.widget

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import ru.kontur.kickerchamp.android.theme.AppTheme

@Composable
fun StartGameWidget(
    isStartButtonEnabled: Boolean,
    onStartGameClicked: () -> Unit
) {
    Box(Modifier.fillMaxSize()) {
        Button(
            modifier = Modifier.align(Alignment.Center),
            onClick = onStartGameClicked,
            enabled = isStartButtonEnabled
        ) {
            Text("Start game", Modifier.padding(vertical = 8.dp, horizontal = 32.dp))
        }
    }
}

@Preview
@Composable
fun StartGameWidgetPreview() {
    AppTheme {
        StartGameWidget(true) {}
    }
}