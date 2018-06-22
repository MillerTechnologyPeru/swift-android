package org.pureswift.swiftandroidsupport.app

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log

open class SwiftAppCompatActivity: AppCompatActivity() {

    private var __swiftObject: Long = 0L

    init{
        __swiftObject = bind()
        Log.v("SwiftAppCompatActivity", "__swiftObject = $__swiftObject")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.v("SwiftAppCompatActivity", "onCreate() $savedInstanceState")
        if(savedInstanceState != null){
            onCreateNative(__swiftObject, savedInstanceState)
        }else{
            onCreateNotSavedInstanceStateNative(__swiftObject)
        }
    }

    override fun onResume() {
        super.onResume()
        //__onResume(__swiftObject)
        Log.v("SwiftAppCompatActivity", "onResume()")
    }

    override fun onPause() {
        super.onPause()
       // __onPause(__swiftObject)
        Log.v("SwiftAppCompatActivity", "onPause()")
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        //__onRequestPermissionsResult(__swiftObject, requestCode, permissions, grantResults)
        Log.v("SwiftAppCompatActivity", "onRequestPermissionsResult()")
    }

    fun finalize() {
        finalizeNative(__swiftObject)
    }

    external fun bind(): Long

    external fun onCreateNative(__swiftObject: Long, savedInstanceState: Bundle?)

    external fun onCreateNotSavedInstanceStateNative(__swiftObject: Long)

    external fun __onResume(__swiftObject: Long)

    external fun __onPause(__swiftObject: Long)

    external fun __onRequestPermissionsResult(__swiftObject: Long, requestCode: Int, permissions: Array<out String>, grantResults: IntArray)

    external fun finalizeNative(__swiftObject: Long)

}