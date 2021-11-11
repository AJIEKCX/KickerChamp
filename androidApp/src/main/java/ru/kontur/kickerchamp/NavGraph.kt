package ru.kontur.kickerchamp

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import org.koin.androidx.compose.get
import ru.kontur.kickerchamp.MainDestinations.HIGH_SCORES_ROUTE
import ru.kontur.kickerchamp.MainDestinations.MAIN_ROUTE
import ru.kontur.kickerchamp.highscores.HighScoresScreen
import ru.kontur.kickerchamp.main.MainScreen

object MainDestinations {
    const val MAIN_ROUTE = "main"
    const val HIGH_SCORES_ROUTE = "high-scores"
}

@Composable
fun NavGraph(startDestination: String = MAIN_ROUTE) {
    val navController = rememberNavController()

    NavHost(
        navController = navController,
        startDestination = startDestination
    ) {
        composable(MAIN_ROUTE) {
            MainScreen(get(), onHighScoresClick = {
                navController.navigate(HIGH_SCORES_ROUTE)
            })
        }
        composable(HIGH_SCORES_ROUTE) {
            HighScoresScreen(get(), onBackClick = {
                navController.popBackStack()
            })
        }
    }
}