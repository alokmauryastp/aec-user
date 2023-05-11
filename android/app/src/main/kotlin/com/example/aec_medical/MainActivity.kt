package com.aaragroups.aecuser

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel


import androidx.annotation.NonNull;

class MainActivity: FlutterActivity() {
    fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPluginBinding) {
        val methodChannel =
            MethodChannel(flutterPluginBinding.getBinaryMessenger(), "connectycube_flutter_call_kit.callEventChannel")
    }
}
