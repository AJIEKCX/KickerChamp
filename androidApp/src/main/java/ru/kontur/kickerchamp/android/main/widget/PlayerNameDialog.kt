package ru.kontur.kickerchamp.android.main.widget

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.material.Card
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Done
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import ru.kontur.kickerchamp.DialogState
import ru.kontur.kickerchamp.Player
import ru.kontur.kickerchamp.android.theme.AppTheme

@Composable
fun PlayerNameDialog(
    state: DialogState,
    onDone: (Player, String) -> Unit,
    onDismiss: () -> Unit
) {
    var name by remember { mutableStateOf(state.player.name) }

    Dialog(onDismissRequest = onDismiss) {
        PlayerNameDialogContent(
            name = name,
            onNameChange = { name = it },
            onDone = { onDone(state.player, name) }
        )
    }
}

@Composable
private fun PlayerNameDialogContent(
    name: String,
    onNameChange: (String) -> Unit,
    onDone: () -> Unit
) {
    Card(Modifier.size(200.dp)) {
        Column(Modifier.padding(16.dp)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text("Enter name", Modifier.weight(1f), style = MaterialTheme.typography.h6)
                IconButton(onClick = onDone) {
                    Icon(Icons.Default.Done, contentDescription = null)
                }
            }
            Spacer(Modifier.weight(1f))
            OutlinedTextField(
                value = name,
                onValueChange = onNameChange,
                singleLine = true,
                keyboardActions = KeyboardActions {
                    onDone()
                }
            )
            Spacer(Modifier.weight(1f))
        }
    }
}

@Preview
@Composable
fun PlayerNamePreview() {
    AppTheme {
        PlayerNameDialogContent("", {}, {})
    }
}