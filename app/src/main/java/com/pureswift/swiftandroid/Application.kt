package com.pureswift.swiftandroid

import android.app.Application
//import org.pureswift.swiftandroidsupport.app.SwiftApplication

class Application: android.app.Application() { //: SwiftApplication() {

    companion object {

        init {
            loadNativeLibrary()
            didLaunch()
        }

        fun loadNativeLibrary() {
            System.loadLibrary("icuuc")
            System.loadLibrary("icui18n")
            System.loadLibrary("Foundation")
            System.loadLibrary("SwiftAndroidApp")
        }

        private external fun didLaunch()
    }
}