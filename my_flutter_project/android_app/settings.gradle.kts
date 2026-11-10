pluginManagement {
    repositories {
        google {
            content {
                includeGroupByRegex("com\\.android.*")
                includeGroupByRegex("com\\.google.*")
                includeGroupByRegex("androidx.*")
            }
        }
        mavenCentral()
        gradlePluginPortal()
    }
    // 添加 Flutter SDK 路径（从 local.properties 读取）
//    val localPropertiesFile = file("local.properties")
//    if (localPropertiesFile.exists()) {
//        val properties = java.util.Properties()
//        localPropertiesFile.inputStream().use { properties.load(it) }
//        val flutterSdkPath = properties.getProperty("flutter.sdk")
//        if (flutterSdkPath != null) {
//            includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")
//        }
//    }
}
dependencyResolutionManagement {
//    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositoriesMode.set(RepositoriesMode.PREFER_PROJECT) // 或 ALLOW
    repositories {
        maven(url = "https://maven.aliyun.com/repository/google")
        maven(url = "https://maven.aliyun.com/repository/central")
        google()
        mavenCentral()
        maven("https://storage.flutter-io.cn/download.flutter.io") // 国内镜像
        maven("https://storage.googleapis.com/download.flutter.io") // 官方
    }
}

rootProject.name = "android_app"
include(":app")


//引入 Flutter Module
val flutterModuleDir = File(settingsDir.parentFile, "flutter_module")
println("Flutter module path: ${flutterModuleDir.absolutePath}")
println("File exists: ${flutterModuleDir.exists()}")
println("Groovy exists: ${File(flutterModuleDir, ".android/include_flutter.groovy").exists()}")
apply(from = File(flutterModuleDir, ".android/include_flutter.groovy"))

