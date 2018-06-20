package com.jmarkstar.bledemo

import android.bluetooth.BluetoothDevice
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import kotlinx.android.synthetic.main.activity_device_detail.*
import java.util.ArrayList

class DeviceDetailActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_device_detail)

        val device = intent.getParcelableExtra<BluetoothDevice>("device")

        val gattInfoList : ArrayList<GattInfoItem> = intent.getParcelableArrayListExtra("services")

        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        title = device.name ?: "No Name"
        tvDeviceName.text = String.format(getString(R.string.device_name), device.name ?: "No Name")
        tvDeviceAddress.text = String.format(getString(R.string.device_address), device.address)

        val gattInfoAdapter = GattInfoAdapter(this, gattInfoList)
        rvGattInfo.adapter = gattInfoAdapter

        //nestedScrollView.fullScroll(View.FOCUS_UP)
        nestedScrollView.parent.requestChildFocus(nestedScrollView, nestedScrollView)
    }

    override fun onOptionsItemSelected(item: MenuItem?): Boolean {
        return when (item?.itemId) {
            android.R.id.home -> {
                finish()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }
}
