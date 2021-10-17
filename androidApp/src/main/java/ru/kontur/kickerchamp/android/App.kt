package ru.kontur.kickerchamp.android

import android.app.Application
import org.koin.core.context.startKoin
import org.koin.dsl.module
import ru.kontur.kickerchamp.MainScreenStore

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            modules(appModule)
        }
    }

    private val appModule = module {
        single { MainScreenStore() }
    }
}