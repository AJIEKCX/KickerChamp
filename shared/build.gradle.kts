import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget
import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    kotlin("multiplatform")
    id("com.android.library")
    id("com.squareup.sqldelight")
}

kotlin {
    val xcf = XCFramework()

    jvm("desktop")
    android()

    ios {
        binaries {
            framework {
                baseName = "shared"
                xcf.add(this)
            }
        }
    }

    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation(libs.sqlDelightRuntime)
                implementation(libs.sqlDelightCoroutinesExtensions)
//                implementation(libs.kotlinCoroutines)
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.5.0-native-mt")
                implementation(libs.koin)
            }
        }
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test-common"))
                implementation(kotlin("test-annotations-common"))
            }
        }
        val androidMain by getting {
            dependencies {
                implementation(libs.sqlDelightAndroid)
            }
        }
        val androidTest by getting {
            dependencies {
                implementation(kotlin("test-junit"))
                implementation("junit:junit:4.13.2")
            }
        }
        val iosMain by getting {
            dependencies {
                implementation(libs.sqlDelightNative)
            }
        }
        val desktopMain by getting {
            dependencies {
                implementation("com.squareup.sqldelight:sqlite-driver:1.5.2")
            }
        }
        val iosTest by getting
    }
}

android {
    compileSdk = 31

    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")

    defaultConfig {
        minSdk = 23
        targetSdk = 31
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}

sqldelight {
    database("AppDatabase") {
        packageName = "ru.kontur.kickerchamp.db"
    }
}