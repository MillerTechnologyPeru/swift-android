package org.pureswift.swiftandroidsupport.content

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class SwiftBroadcastReceiver: BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        __onReceive(context, intent)
    }

    external fun __onReceive(context: Context?, intent: Intent?)
}