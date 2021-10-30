package ru.kontur.kickerchamp

import android.app.Application
import org.koin.core.context.startKoin
import org.koin.dsl.module
import ru.kontur.kickerchamp.db.Database
import ru.kontur.kickerchamp.db.DatabaseDriverFactory
import ru.kontur.kickerchamp.di.sharedModule

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            modules(androidModule, sharedModule)
        }
    }

    private val androidModule = module {
        single<Application> { this@App }
        single { Database(DatabaseDriverFactory(get<Application>())) }
    }
}