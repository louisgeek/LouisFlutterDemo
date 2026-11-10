package com.louis.my_flutter_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(){
    private val CHANNEL = "com.louis.my_flutter_app/sign_secret"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getSignSecretKey" -> {
                        // 无参数
//                        val key = PwRtcNativeApi.getSignSecretKey()
                        val key = "XXXX"
                        result.success(key)
                    }
//                    "generateSignature" -> {
//                        // 获取参数
//                        val timestamp = call.argument<Long>("timestamp") ?: 0L
//                        val param = call.argument<String>("param") ?: ""
//                        val signature = generateSignature(timestamp, param)
//                        result.success(signature)
//                    }
                    else -> result.notImplemented()
                }
            }
    }
}
