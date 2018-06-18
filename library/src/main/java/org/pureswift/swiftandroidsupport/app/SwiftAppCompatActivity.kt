package org.pureswift.swiftandroidsupport.app

import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity

class SwiftAppCompatActivity: AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        __onCreate(savedInstanceState, persistentState)
    }

    override fun onResume() {
        super.onResume()
        __onResume()
    }

    override fun onPause() {
        super.onPause()
        __onPause()
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        __onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    external fun __onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?)

    external fun __onResume()

    external fun __onPause()

    external fun __onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray)

}