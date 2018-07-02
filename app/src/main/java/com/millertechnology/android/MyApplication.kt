package com.millertechnology.android

import org.pureswift.swiftandroidsupport.app.SwiftApplication

class MyApplication : SwiftApplication() {

    companion object {

        init {
            //load native library
            System.loadLibrary("swiftandroidsimple")
        }
    }
}