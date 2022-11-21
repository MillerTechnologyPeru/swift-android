package com.pureswift.swiftandroid

import android.app.Application
//import org.pureswift.swiftandroidsupport.app.SwiftApplication

class Application: android.app.Application() { //: SwiftApplication() {

    companion object {

        init {
            System.loadLibrary("SwiftAndroidApp")
            didLaunch()
        }

        private external fun didLaunch()
    }
}