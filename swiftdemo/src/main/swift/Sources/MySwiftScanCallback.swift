//
//  MySwiftScanCallback.swift
//  Android
//
//  Created by Marco Estrella on 7/6/18.
//

import Foundation
import Android
import AndroidBluetooth
import java_swift

public class MySwiftScanCallback: Android.Bluetooth.LE.ScanCallback {
    
    private var activity: MainActivity?
    
    init(mainActivity: MainActivity){
        
        super.init(javaObject: nil)
        bindNewJavaObject()
        
        activity = mainActivity
        
        NSLog("\(type(of: self)) \(#function)")
    }
    
    required public init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    public override func onScanResult(callbackType: Android.Bluetooth.LE.ScanCallbackType, result: Android.Bluetooth.LE.ScanResult) {
        
        let device = result.device
        let rssi = result.rssi
        
        let deviceModel = DeviceModel(device: device, rssi: rssi)

        //activity?.deviceAdapter?.addDevice(newDevice: deviceModel)
    }
    
    public override func onBatchScanResults(results: [Android.Bluetooth.LE.ScanResult]) {
        
        NSLog("\(type(of: self)): \(#function)")
    }
    
    public override func onScanFailed(error: AndroidBluetoothLowEnergyScanCallback.Error) {
        
        NSLog("\(type(of: self)): \(#function)")
        
        NSLog("Scan failed \(error)")
    }
}
