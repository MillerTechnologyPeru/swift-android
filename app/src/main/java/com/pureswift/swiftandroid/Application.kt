package com.pureswift.swiftandroid

//import org.pureswift.swiftandroidsupport.app.SwiftApplication
//class Application: SwiftApplication() {

import android.app.Application
class Application: android.app.Application() {

    companion object {

        init {
            loadNativeLibrary()
            didLaunch()
        }

        private fun loadNativeLibrary() {
            System.loadLibrary("icuuc")
            System.loadLibrary("icui18n")
            System.loadLibrary("Foundation")
            System.loadLibrary("SwiftAndroidApp")
        }

        private external fun didLaunch()
    }
}