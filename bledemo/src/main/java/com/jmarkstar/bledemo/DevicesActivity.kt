package com.jmarkstar.bledemo

import android.Manifest
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.View
import android.widget.Toast
import com.jmarkstar.bledemo.broadcastreceivers.BluetoothChangeStateReceiver
import com.jmarkstar.bledemo.le.DemoLeDevice
import com.johnholdsworth.swiftbindings.DevicesActivityBinding
import kotlinx.android.synthetic.main.activity_devices.*
import java.util.*

class DevicesActivity: AppCompatActivity(), DevicesActivityBinding.Responder {

    companion object {
        const val REQUEST_ENABLE_BT = 1000
        const val REQUEST_PERMISSION_GPS = 1200
    }

    external fun bind(self: DevicesActivityBinding.Responder) : DevicesActivityBinding.Listener

    private var listener: DevicesActivityBinding.Listener? = null

    private var bluetoothChangeStateReceiver : BluetoothChangeStateReceiver? = null

    private var isScanning = false

    private val bleDeviceAdapter = BleDeviceAdapter()

    private val handler = Handler()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_devices)

        bluetoothChangeStateReceiver = BluetoothChangeStateReceiver(this)

        btnScanLeDevices.setOnClickListener {

            //Call swift code
            listener?.validateBluetooth()
        }

        bleDeviceAdapter.onDeviceClick = {
            listener?.connectToDevice(this, it.data)
        }

        rvDevices.adapter = bleDeviceAdapter

        listener = bind(this)
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

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        Log.v("onActivityResult","onActivityResult()")
        Log.v("onActivityResult"," $requestCode and $resultCode")

        if(requestCode == REQUEST_ENABLE_BT && resultCode == Activity.RESULT_OK){

            verifyGpsPermission()
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if(requestCode == REQUEST_PERMISSION_GPS){
            if(grantResults[0] == PackageManager.PERMISSION_GRANTED){
                startDiscovery()
            }else{
                Toast.makeText(this, "GPS Permission is required", Toast.LENGTH_SHORT).show()
            }
        }
    }

    // #1 VERIFY IF BLUETOOTH IS ENABLED
    //This method is called from swift
    override fun activateBluetooth() {
        val enableBluetoothIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
        startActivityForResult(enableBluetoothIntent, REQUEST_ENABLE_BT)
    }

    // #2 VERIFY IF THE GPS PERMISSION IS ALLOWED
    //This method is called from swift
    override fun verifyGpsPermission() {
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
                && checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED){
            requestPermissions(arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION), 1200)
        }else{
            startDiscovery()
        }
    }

    override fun loadFoundDevice(device: Any, rssi: Int) {
        handler.post {

            val leDevice = device as BluetoothDevice
            bleDeviceAdapter.addDevice(DemoLeDevice(leDevice, rssi))
        }
    }

    override fun connectionFailure() {

    }

    //#3 SCAN THE DEVICES
    private fun startDiscovery() {

        if(isScanning){
            stopScan()
        }else{
            startScan()
        }
    }

    private fun startScan(){
        btnScanLeDevices.text = getString(R.string.scan_stop)
        pgScanning.visibility = View.VISIBLE

        listener?.startScan()
        isScanning = true
        bleDeviceAdapter.refresh()
    }

    private fun stopScan(){
        btnScanLeDevices.text = getString(R.string.scan_start)
        pgScanning.visibility = View.GONE

        listener?.stopScan()
        isScanning = false
    }
}
