package ru.kontur.kickerchamp.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material.Text
import ru.kontur.kickerchamp.Greeting
import ru.kontur.kickerchamp.android.theme.AppTheme

fun greet(): String {
    return Greeting().greeting()
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            AppTheme {
                Text(greet())
            }
        }
    }
}
