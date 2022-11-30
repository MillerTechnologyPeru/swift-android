package com.pureswift.swiftandroid

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.layout.R
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.platform.LocalInspectionMode
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import com.pureswift.swiftandroid.ui.theme.SwiftAndroidTheme
import java.util.*
import kotlin.concurrent.schedule

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

        Timer().schedule(3000) {
            val devices = devices()
            android.util.Log.i("Swift", "Load devices $devices")
            setContent {
                if (devices.isEmpty()) {
                    Column {
                        Greeting("Android")
                        Text(text = "No Bluetooth devices")
                    }
                } else {
                    LazyColumn {
                        devices.map {
                            item(key = it.id) {
                                BluetoothScanResultView(it)
                            }
                        }
                    }
                }
            }
        }
    }

    private external fun devices(): ArrayList<BluetoothDevice>
}

data class BluetoothDevice(
    val id: String,
    val date: Date,
    val address: String,
    val name: String? = null,
    val company: String? = null
)

@Composable
fun Greeting(name: String) {
    Text(text = greeting(name))
}

@Composable
fun BluetoothScanResultView(scanData: BluetoothDevice) {
    Column(modifier = Modifier.padding(bottom = 4.dp)) {
        Text("${scanData.address}")
        Text("${scanData.date.toString()}")
        if (scanData.name != null) {
            Text("${scanData.name}")
        }
        if (scanData.company != null) {
            Text("${scanData.company}")
        }
    }
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