package org.pureswift.swiftandroidsupport.bluetooth

import android.annotation.SuppressLint
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothProfile

@SuppressWarnings("JniMissingFunction")
@SuppressLint("MissingPermission")
class SwiftBluetoothProfile(private val __swiftObject: Long): BluetoothProfile {

    override fun getDevicesMatchingConnectionStates(states: IntArray?): MutableList<BluetoothDevice> {
        return __get_devices_matching_connection_states(__swiftObject, states)
    }

    override fun getConnectionState(device: BluetoothDevice?): Int {
        return __get_connection_state(__swiftObject, device)
    }

    override fun getConnectedDevices(): MutableList<BluetoothDevice> {
        return __get_connected_devices(__swiftObject)
    }

    fun finalize() {
        __finalize(__swiftObject)
    }

    //Native Methods

    external fun __get_devices_matching_connection_states(swiftObject: Long, states: IntArray?): MutableList<BluetoothDevice>

    external fun __get_connection_state(swiftObject: Long, device: BluetoothDevice?): Int

    external  fun __get_connected_devices(swiftObject: Long): MutableList<BluetoothDevice>

    external fun __finalize(__swiftObject: Long)
}