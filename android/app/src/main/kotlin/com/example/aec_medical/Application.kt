package com.aaragroups.aecuser

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService


class Application : FlutterApplication(), PluginRegistrantCallback {
    // ...
    override fun onCreate() {
        super.onCreate()
//        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
//        GeneratedPluginRegistrant.registerWith(registry)
    } // ...
}

//class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
//
//    override fun onCreate() {
//        super.onCreate()
//        FlutterFirebaseMessagingService.setPluginRegistrant(this)
//
//    }
//    override fun registerWith(registry: PluginRegistry?) {
//        if (registry != null) {
//            FlutterLocalNotificationPluginRegistrant.registerWith(registry)
//            FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
//
//        }
//    }
//}

//class FirebaseCloudMessagingPluginRegistrant {
//    companion object {
//        fun registerWith(registry: PluginRegistry) {
//            if (alreadyRegisteredWith(registry)) {
//                return;
//            }
//            FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
//        }
//
//        private fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {
//            val key = FirebaseCloudMessagingPluginRegistrant::class.java.name
//            if (registry.hasPlugin(key)) {
//                return true
//            }
//            registry.registrarFor(key)
//            return false
//        }
//    }
//}