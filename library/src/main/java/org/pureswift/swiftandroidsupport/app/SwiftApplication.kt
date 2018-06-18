package org.pureswift.swiftandroidsupport.app

import android.app.Application

class SwiftApplication: Application() {

    companion object {
        fun loadNativeDependencies(libName: String = "swiftandroid"){
            System.loadLibrary(libName)
        }

        init {
            loadNativeDependencies()
        }
    }

    override fun onCreate() {
        super.onCreate()

        loadNativeDependencies()
    }
}