package com.Softgenix.seguridad_flutter

import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.Softgenix.seguridad_flutter/security"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "isUsbDebuggingEnabled") {
                val adbEnabled = Settings.Secure.getInt(contentResolver, Settings.Secure.ADB_ENABLED, 0) == 1
                result.success(adbEnabled)
            } else {
                result.notImplemented()
            }
        }
    }
}
