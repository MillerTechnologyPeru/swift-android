//
//  MySwiftScanCallback.swift
//  Android
//
//  Created by Marco Estrella on 7/6/18.
//

import Foundation
import Android

public struct MySwiftScanCallback: Android.Bluetooth.LE.ScanCallback {
    
    private var activity: MainActivity?
    
    init(mainActivity: MainActivity){
        activity = mainActivity
        
        NSLog("\(type(of: self)) \(#function)")
    }
    
    public func onScanResult(callbackType: Android.Bluetooth.LE.ScanCallbackType, result: Android.Bluetooth.LE.ScanResult) {
        
        NSLog("\(type(of: self)): \(#function)")
        
        let device = result.device
        let rssi = result.rssi
        
        NSLog("Address: \(device.address) - rssi: \(rssi)")
    }
    
    public func onBatchScanResults(results: [Android.Bluetooth.LE.ScanResult]) {
        
        NSLog("\(type(of: self)): \(#function)")
    }
    
    public func onScanFailed(error: AndroidBluetoothLowEnergyScanCallback.Error) {
        
        NSLog("\(type(of: self)): \(#function)")
    }
}
