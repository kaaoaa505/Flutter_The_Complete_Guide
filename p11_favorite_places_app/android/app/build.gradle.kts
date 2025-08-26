import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.p11_favorite_places_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // keep fixed ndk version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    // Read values from local.properties (safe, ignored by Git)
    val localProps = gradle.rootProject.file("local.properties")
    val props = Properties()
    if (localProps.exists()) {
        props.load(localProps.inputStream())
    }

    val flutterVersionCode = props.getProperty("flutter.versionCode") ?: "1"
    val flutterVersionName = props.getProperty("flutter.versionName") ?: "1.0.0"
    val googleMapsKey = props.getProperty("GOOGLE_MAPS_API_KEY") ?: ""

    defaultConfig {
        applicationId = "com.example.p11_favorite_places_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName

        // Inject API Key into manifest
        manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = googleMapsKey
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Using debug signing so `flutter run --release` still works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
