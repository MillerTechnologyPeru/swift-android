package com.jmarkstar.bledemo

import android.bluetooth.BluetoothAdapter
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.Toast
import com.jmarkstar.bledemo.broadcastreceivers.BluetoothChangeStateReceiver
import com.johnholdsworth.swiftbindings.DevicesActivityBinding
import kotlinx.android.synthetic.main.activity_devices.*

class DevicesActivity: AppCompatActivity(), DevicesActivityBinding.Responder {

    companion object {
        const val REQUEST_ENABLE_BT = 1000
        const val REQUEST_PERMISSION_GPS = 1200
    }

    external fun bind(self: DevicesActivityBinding.Responder) : DevicesActivityBinding.Listener

    private var listener: DevicesActivityBinding.Listener? = null

    private var bluetoothChangeStateReceiver : BluetoothChangeStateReceiver? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_devices)

        listener = bind(this)

        bluetoothChangeStateReceiver = BluetoothChangeStateReceiver(this)

        btnScanLeDevices.setOnClickListener {
            listener?.validateBluetooth()
        }
    }

    override fun onResume() {
        super.onResume()

        val intentFilter = IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED)
        registerReceiver(bluetoothChangeStateReceiver, intentFilter)
    }

    override fun onPause() {
        super.onPause()

        unregisterReceiver(bluetoothChangeStateReceiver)
    }

    override fun activateBluetooth() {
        val enableBluetoothIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
        startActivityForResult(enableBluetoothIntent, REQUEST_ENABLE_BT)
    }

    override fun verifyGpsPermission() {
        Toast.makeText(this, "Listo para verificar el permiso de gps", Toast.LENGTH_SHORT).show()
    }
}
