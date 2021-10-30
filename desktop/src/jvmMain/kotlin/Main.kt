import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.window.Window
import androidx.compose.ui.window.application
import org.koin.core.context.startKoin
import org.koin.dsl.module
import ru.kontur.kickerchamp.common.highscores.HighScoresScreen
import ru.kontur.kickerchamp.common.main.MainScreen
import ru.kontur.kickerchamp.common.theme.AppTheme
import ru.kontur.kickerchamp.db.Database
import ru.kontur.kickerchamp.db.DatabaseDriverFactory
import ru.kontur.kickerchamp.di.sharedModule

object MainDestinations {
    const val MAIN_ROUTE = "main"
    const val HIGH_SCORES_ROUTE = "high-scores"
}

fun main() {
    val koin = startKoin { modules(sharedModule, desktopModule) }.koin

    application {
        var currentScreen by remember { mutableStateOf(MainDestinations.MAIN_ROUTE) }

        Window(
            onCloseRequest = ::exitApplication,
            title = "Kicker Champ"
        ) {
            AppTheme {
                when (currentScreen) {
                    MainDestinations.MAIN_ROUTE -> {
                        MainScreen(koin.get()) {
                            currentScreen = MainDestinations.HIGH_SCORES_ROUTE
                        }
                    }
                    MainDestinations.HIGH_SCORES_ROUTE -> {
                        HighScoresScreen(koin.get()) {
                            currentScreen = MainDestinations.MAIN_ROUTE
                        }
                    }
                }
            }
        }
    }
}

private val desktopModule = module {
    single { Database(DatabaseDriverFactory()) }
}