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
import org.pureswift.swiftandroidsupport.app.SwiftComponentActivity
import java.util.*
import kotlin.concurrent.schedule

class MainActivity : SwiftComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        android.util.Log.i("Activity", "Loading Main Activity")

        setContent {
            SwiftAndroidTheme {
                // A surface container using the 'background' color from the theme
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colors.background) {
                    Text("Loading...")
                }
            }
        }
    }

    fun updateView(devices: ArrayList<BluetoothDevice>) {
        setContent {
            if (devices.isEmpty()) {
                Column {
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

data class BluetoothDevice(
    val id: String,
    val date: Date,
    val address: String,
    val name: String? = null,
    val company: String? = null
)

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
