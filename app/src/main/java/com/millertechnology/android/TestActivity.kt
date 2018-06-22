package com.millertechnology.android

import android.os.Bundle
import kotlinx.android.synthetic.main.activity_test.*
import org.pureswift.swiftandroidsupport.app.SwiftAppCompatActivity

class TestActivity : SwiftAppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_test)

        btnKill.setOnClickListener {
            finish()
        }
    }

    override fun onStart() {
        super.onStart()

    }

    override fun onResume() {
        super.onResume()

    }

    override fun onRestart() {
        super.onRestart()
    }

    override fun onPause() {
        super.onPause()
    }

    override fun onStop() {
        super.onStop()

    }

    override fun onDestroy() {
        super.onDestroy()
    }
}
