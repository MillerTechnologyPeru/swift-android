//
//  MySwiftGattCallback.swift
//  Android
//
//  Created by Marco Estrella on 7/6/18.
//

import Foundation
import Android
import AndroidBluetooth
import java_swift

public class MySwiftGattCallback: Android.Bluetooth.GattCallback {
    
    private var activity: MainActivity?
    
    convenience init(mainActivity: MainActivity){
        
        self.init(javaObject: nil)
        bindNewJavaObject()
        
        activity = mainActivity
        
        NSLog("\(type(of: self)) \(#function)")
    }
    
    public required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    public override func onConnectionStateChange(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status, newState: AndroidBluetoothDevice.State) {
        
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
    
    public override func onServicesDiscovered(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
        
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
        
        //NSLog("Size: \(String(describing: gatt.getServices()?.size()))")
    }
    
    public override func onCharacteristicChanged(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic) {
        
    }
    
    public override func onCharacteristicRead(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public override func onCharacteristicWrite(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public override func onDescriptorRead(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public override func onDescriptorWrite(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public override func onMtuChanged(gatt: Android.Bluetooth.Gatt, mtu: Int, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public override func onPhyRead(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public override func onPhyUpdate(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public override func onReadRemoteRssi(gatt: Android.Bluetooth.Gatt, rssi: Int, status: AndroidBluetoothGatt.Status) {
        
    }
    
    public override func onReliableWriteCompleted(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
        
    }
}
