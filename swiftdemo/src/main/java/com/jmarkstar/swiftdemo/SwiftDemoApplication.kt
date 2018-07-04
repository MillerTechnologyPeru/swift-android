package com.jmarkstar.swiftdemo

import org.pureswift.swiftandroidsupport.app.SwiftApplication

class SwiftDemoApplication: SwiftApplication() {

    companion object {

        init {
            System.loadLibrary("swiftdemo")
        }
    }
}