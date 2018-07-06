//
//  MySwiftGattCallback.swift
//  Android
//
//  Created by Marco Estrella on 7/6/18.
//

import Foundation
import Android

public struct MySwiftGattCallback: Android.Bluetooth.GattCallback {
    
    private var activity: MainActivity?
    
    init(mainActivity: MainActivity){
        activity = mainActivity
        
        NSLog("\(type(of: self)) \(#function)")
    }
    
    public func onConnectionStateChange(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status, newState: AndroidBluetoothDevice.State) {
        
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
    
    public func onServicesDiscovered(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
        
        NSLog("Status: \(status)")
        
        if(status.rawValue != AndroidBluetoothGatt.Status.success.rawValue){
            //Show error message on Android
            NSLog("Error: \(status)")
            return
        }
        
        /*
        gatt.getServices()?.withJavaObject{
            self.responder.showServices(services: JavaObject(javaObject: $0))
        }*/
        
        NSLog("Size: \(String(describing: gatt.getServices()?.size()))")
    }
    
    public func onCharacteristicChanged(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic) {
        
    }
    
    public func onCharacteristicRead(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public func onCharacteristicWrite(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public func onDescriptorRead(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public func onDescriptorWrite(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public func onMtuChanged(gatt: Android.Bluetooth.Gatt, mtu: Int, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public func onPhyRead(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public func onPhyUpdate(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public func onReadRemoteRssi(gatt: Android.Bluetooth.Gatt, rssi: Int, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public func onReliableWriteCompleted(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
        
    }
}
