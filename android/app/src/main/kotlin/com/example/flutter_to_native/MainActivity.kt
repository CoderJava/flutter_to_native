package com.example.flutter_to_native

import android.os.Bundle
import android.util.Log
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    val channel = "flutter.native/helper"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, channel).setMethodCallHandler { call, result ->
            if (call.method == "greetingFromNativeCode") {
                val text = call.argument<String>("name") ?: "unknown"
                val greeting = "Greeting from Android Code $text"
                result.success(greeting)
            }
        }
    }
}
