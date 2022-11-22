package com.pureswift.swiftandroid

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.platform.LocalInspectionMode
import com.pureswift.swiftandroid.ui.theme.SwiftAndroidTheme

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        println("MainActivity")
        android.util.Log.i("Activity", "Loading Main Activity")

        setContent {
            SwiftAndroidTheme {
                // A surface container using the 'background' color from the theme
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colors.background) {
                    Greeting("Android")
                }
            }
        }
    }
}

@Composable
fun Greeting(name: String) {
    Text(text = greeting(name))
}

@Composable
fun greeting(name: String): String {
    if (LocalInspectionMode.current) {
        return greetingMock(name)
    } else {
        return greetingNative(name)
    }
}

external fun greetingNative(name: String): String

fun greetingMock(name: String): String {
    return "Hello $name"
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    SwiftAndroidTheme {
        Greeting("Android")
    }
}