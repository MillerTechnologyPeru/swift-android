package com.pureswift.swiftandroid

import android.os.Bundle
import org.pureswift.swiftandroidsupport.app.SwiftComponentActivity

class MainActivity : SwiftComponentActivity() {

    lateinit var composableContent: ComposableContent

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        android.util.Log.i("Activity", "Loading Main Activity")

        composableContent = ComposableContent(this)
        composableContent.setContent()
    }
}
