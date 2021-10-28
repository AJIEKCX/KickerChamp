package ru.kontur.kickerchamp.android

import android.app.Application
import org.koin.core.context.startKoin
import org.koin.dsl.module
import ru.kontur.kickerchamp.HighScoreStore
import ru.kontur.kickerchamp.MainScreenStore
import ru.kontur.kickerchamp.db.Database
import ru.kontur.kickerchamp.db.DatabaseDriverFactory

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            modules(appModule)
        }
    }

    private val appModule = module {
        single<Application> { this@App }
        single { Database(DatabaseDriverFactory(get<Application>())) }
        single { MainScreenStore(get()) }
        single { HighScoreStore(get()) }
    }
}