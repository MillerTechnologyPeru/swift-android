package org.pureswift.swiftandroidsupport.app

import android.content.*
import android.os.Bundle
import android.support.v7.app.AppCompatActivity

open class SwiftAppCompatActivity: AppCompatActivity() {

    private var __swiftObject: Long = 0L

    init{
        __swiftObject = bind()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        onCreateNative(__swiftObject, savedInstanceState)
    }

    override fun onStart() {
        super.onStart()
        onStartNative(__swiftObject)
    }

    override fun onResume() {
        super.onResume()
        onResumeNative(__swiftObject)
    }

    override fun onPause() {
        super.onPause()
        onPauseNative(__swiftObject)
    }

    override fun onRestart() {
        super.onRestart()
        onRestartNative(__swiftObject)
    }

    override fun onStop() {
        super.onStop()
        onStopNative(__swiftObject)
    }

    override fun onDestroy() {
        super.onDestroy()
        onDestroyNative(__swiftObject)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        onActivityResultNative(__swiftObject, requestCode, resultCode, data)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        onRequestPermissionsResultNative(__swiftObject, requestCode, permissions, grantResults)
    }

    fun finalize() {
        finalizeNative(__swiftObject)
    }

    override fun registerReceiver(receiver: BroadcastReceiver?, filter: IntentFilter?): Intent {
        return super.registerReceiver(receiver, filter)
    }

    override fun unregisterReceiver(receiver: BroadcastReceiver?) {
        super.unregisterReceiver(receiver)
    }

    external fun bind(): Long

    external fun onCreateNative(__swiftObject: Long, savedInstanceState: Bundle?)

    external fun onStartNative(__swiftObject: Long)

    external fun onResumeNative(__swiftObject: Long)

    external fun onPauseNative(__swiftObject: Long)

    external fun onRestartNative(__swiftObject: Long)

    external fun onStopNative(__swiftObject: Long)

    external fun onDestroyNative(__swiftObject: Long)

    external fun onActivityResultNative(__swiftObject: Long, requestCode: Int, resultCode: Int, data: Intent?)

    external fun onRequestPermissionsResultNative(__swiftObject: Long, requestCode: Int, permissions: Array<out String>, grantResults: IntArray)

    external fun finalizeNative(__swiftObject: Long)

}