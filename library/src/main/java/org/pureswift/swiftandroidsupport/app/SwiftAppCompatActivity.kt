package org.pureswift.swiftandroidsupport.app

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log

open class SwiftAppCompatActivity: AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        __onCreate(savedInstanceState)
        Log.v("SwiftAppCompatActivity", "onCreate()")
    }

    override fun onResume() {
        super.onResume()
        __onResume()
        Log.v("SwiftAppCompatActivity", "onResume()")
    }

    override fun onPause() {
        super.onPause()
        __onPause()
        Log.v("SwiftAppCompatActivity", "onPause()")
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        __onRequestPermissionsResult(requestCode, permissions, grantResults)
        Log.v("SwiftAppCompatActivity", "onRequestPermissionsResult()")
    }

    fun finalize() {
        //__finalize()
    }

    external fun __onCreate(savedInstanceState: Bundle?)

    external fun __onResume()

    external fun __onPause()

    external fun __onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray)

}