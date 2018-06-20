//
//  DemoGattCallback.swift
//  Android
//
//  Created by Marco Estrella on 6/19/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

extension DevicesActivityBinding_ListenerImpl {
    
    struct DemoGattCallback: Android.Bluetooth.GattCallback {
        
        let responder: DevicesActivityBinding_ResponderForward
        
        init(responder: DevicesActivityBinding_ResponderForward){
            self.responder = responder
        }
        
        func onConnectionStateChange(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status, newState: AndroidBluetoothDevice.State) {
            NSLog("Status: \(status) - newState = \(newState)")
            if(status.rawValue != AndroidBluetoothGatt.Status.success.rawValue){
                //Show error message on Android
                NSLog("Error: \(status.rawValue)")
                return
            }
            if(newState.rawValue == AndroidBluetoothDevice.State.connected.rawValue){
                //connected
                gatt.discoverServices()
            }
        }
        
        func onServicesDiscovered(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
            
            NSLog("Status: \(status)")
            if(status.rawValue != AndroidBluetoothGatt.Status.success.rawValue){
                //Show error message on Android
                NSLog("Error: \(status)")
                return
            }
            
            gatt.getServices()?.withJavaObject{
                self.responder.showServices(services: JavaObject(javaObject: $0))
            }
            
            NSLog("Size: \(String(describing: gatt.getServices()?.size()))")
        }
        
        func onCharacteristicChanged(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic) {
            
        }
        
        func onCharacteristicRead(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
            
        }
        
        func onCharacteristicWrite(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
            
        }
        
        func onDescriptorRead(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
            
        }
        
        func onDescriptorWrite(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
            
        }
        
        func onMtuChanged(gatt: Android.Bluetooth.Gatt, mtu: Int, status: AndroidBluetoothGatt.Status) {
            
        }
        
        func onPhyRead(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
            
        }
        
        func onPhyUpdate(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
            
        }
        
        func onReadRemoteRssi(gatt: Android.Bluetooth.Gatt, rssi: Int, status: AndroidBluetoothGatt.Status) {
            
        }
        
        func onReliableWriteCompleted(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
            
        }
    }
}
