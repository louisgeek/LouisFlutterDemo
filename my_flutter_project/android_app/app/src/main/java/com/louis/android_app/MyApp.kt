package com.louis.android_app

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MyApp : Application() {

    companion object {
        const val ENGINE_ID = "main_engine"
    }

    override fun onCreate() {
        super.onCreate()
        warmUpFlutterEngine()
    }

    private fun warmUpFlutterEngine() {
        FlutterEngine(this).apply {
            dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )
            FlutterEngineCache.getInstance().put(ENGINE_ID, this)
        }
    }
}