package com.example.androiduikitdemo

import org.pureswift.swiftandroidsupport.app.SwiftApplication

class AndroidUIKitDemoApplication: SwiftApplication() {

    companion object {

        init {
            System.loadLibrary("androiduikitdemo")
        }
    }
}
