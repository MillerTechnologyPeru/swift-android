package org.pureswift.swiftandroidsupport.content

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class SwiftBroadcastReceiver(private val __swiftObject: Long): BroadcastReceiver() {

    init {
        Log.v("SwiftBroadcastReceiver", "init")
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        Log.v("SwiftBroadcastReceiver", "onReceive")
        __onReceive(__swiftObject, context, intent)
    }

    fun finalize() {
        __finalize(__swiftObject)
    }

    private external fun __onReceive(__swiftObject: Long, context: Context?, intent: Intent?)

    private external fun __finalize(__swiftObject: Long)
}