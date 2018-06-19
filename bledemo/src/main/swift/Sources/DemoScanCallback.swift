//
//  DemoScanCallback.swift
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
    
    struct DemoScanCallback: Android.Bluetooth.LE.ScanCallback{
        
        let responder: DevicesActivityBinding_ResponderForward
        
        init(responder: DevicesActivityBinding_ResponderForward){
            self.responder = responder
        }
        
        func onScanResult(callbackType: Android.Bluetooth.LE.ScanCallbackType, result: Android.Bluetooth.LE.ScanResult) {
            
            let device = result.device
            let rssi = result.rssi
            
            NSLog("Address: \(device.address) - rssi: \(rssi)")
            responder.loadFoundDevice(device, java_lang.Integer(value: rssi))
        }
        
        func onBatchScanResults(results: [Android.Bluetooth.LE.ScanResult]) {
            NSLog("\(type(of: self)): \(#function)")
        }
        
        func onScanFailed(error: AndroidBluetoothLowEnergyScanCallback.Error) {
            NSLog("\(type(of: self)): \(#function)")
        }
    }
}
