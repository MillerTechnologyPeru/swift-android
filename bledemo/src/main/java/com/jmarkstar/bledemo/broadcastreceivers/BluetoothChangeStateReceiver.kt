package com.jmarkstar.bledemo.broadcastreceivers

import android.bluetooth.BluetoothAdapter
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.jmarkstar.bledemo.DevicesActivity

class BluetoothChangeStateReceiver(private val activity: DevicesActivity): BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {

        val state = intent?.getIntExtra(BluetoothAdapter.EXTRA_STATE, BluetoothAdapter.ERROR)
        val previousState = intent?.getIntExtra(BluetoothAdapter.EXTRA_PREVIOUS_STATE, -1)

        Log.v("BroadcastReceiver", "$previousState - $state")

        if(state == BluetoothAdapter.STATE_ON){
            activity.verifyGpsPermission()
        }
    }
}