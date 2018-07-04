package com.jmarkstar.bledemo

import org.pureswift.swiftandroidsupport.app.SwiftApplication

class BleDemoApplication: SwiftApplication() {

    companion object {

        init {
            //load native library
            System.loadLibrary("bledemoswift")
        }
    }
}