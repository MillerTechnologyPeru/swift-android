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

    class ServiceListener(private val __swiftObject: Long): BluetoothProfile.ServiceListener {

        override fun onServiceDisconnected(profile: Int) {
            __on_service_disconnected(__swiftObject, profile)
        }

        override fun onServiceConnected(profile: Int, proxy: BluetoothProfile?) {
            __on_service_connected(__swiftObject, profile, proxy)
        }

        fun finalize() {
            __finalize(__swiftObject)
        }

        external fun __finalize(__swiftObject: Long)

        external fun __on_service_disconnected(__swiftObject: Long, profile: Int)

        external fun __on_service_connected(__swiftObject: Long, profile: Int, proxy: BluetoothProfile?)
    }
}