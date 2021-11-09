plugins {
    id("com.android.application")
    kotlin("android")
    id("org.jetbrains.compose")
}

android {
    compileSdk = 31

    defaultConfig {
        minSdk = 23
        targetSdk = 31
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}

dependencies {
    implementation(project(":shared"))
    implementation(project(":shared-ui"))
    // AndroidX
    implementation(libs.androidCoreKtx)
    implementation(libs.androidActivityKtx)
    implementation(libs.androidLifecycleKtx)
    implementation(libs.androidViewModelKtx)
    implementation(libs.androidMaterial)

    // Jetpack Compose

    implementation(compose.material)
    implementation(compose.foundation)
    implementation(compose.ui)
    implementation(libs.composeToolingPreview)
    implementation(libs.composeActivity)
    implementation(libs.composeNavigation)
    implementation(libs.composeInsets)
    debugImplementation(libs.composeTooling)

    // Kotlin coroutines
    implementation(libs.kotlinCoroutines)
    implementation(libs.kotlinCoroutinesAndroid)

    // Koin DI
    implementation(libs.koin)
    implementation(libs.koinAndroid)
    implementation(libs.koinCompose)
}
