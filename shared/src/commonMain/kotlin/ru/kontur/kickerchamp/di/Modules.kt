package ru.kontur.kickerchamp.di

import org.koin.dsl.module
import ru.kontur.kickerchamp.HighScoreStore
import ru.kontur.kickerchamp.MainScreenStore

val sharedModule = module {
    single { MainScreenStore(get()) }
    single { HighScoreStore(get()) }
}