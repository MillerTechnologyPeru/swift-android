//
//  MainActivity.swift
//  Android
//
//  Created by Marco Estrella on 6/26/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android
import Bluetooth

/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("MainActivity bind \(#function)")
    return MainActivity.self
}

// Like AppDelegate in iOS
final class MainActivity: SwiftSupportAppCompatActivity {
    
    private let REQUEST_ENABLE_BT = 1000
    private let REQUEST_GPS_PERMISSION = 2000
    
    private var bluetoothChangeStateReceiver: BluetoothChangeStateReceiver?
    
    private let bluetoothAdapter = Android.Bluetooth.Adapter.default
    
    private var scanCallback: MySwiftScanCallback?
    
    private var gattCallback: MySwiftGattCallback?
    
    public var deviceAdapter: DeviceAdapter?
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        NSLog("\(type(of: self)) \(#function)")
        
        let viewId = getIdentifier(name: "activity_devices", type: "layout")
        
        NSLog("\(type(of: self)) viewId = \(viewId)")
        
        setContentView(layoutResID: viewId)
        
        bluetoothChangeStateReceiver = BluetoothChangeStateReceiver(mainActivity: self)
        
        scanCallback = MySwiftScanCallback(mainActivity: self)
        
        gattCallback = MySwiftGattCallback(mainActivity: self)
        
        deviceAdapter = DeviceAdapter(mainActivity: self)
        
        let context = Android.Content.Context(casting: self)
        let linearLayoutManager = Android.Widget.RecyclerView.LinearLayoutManager(context: context!)
        
        let rvId = getIdentifier(name: "rvDevices", type: "id")
        NSLog("\(type(of: self)) rvId = \(rvId)")

        let rvDevices = Android.Widget.RecyclerView(casting: findViewById(rvId)!)
        
        rvDevices?.adapter = deviceAdapter!
        
        rvDevices?.layoutManager = linearLayoutManager
    }
    
    override func onResume() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        let intentFilter = Android.Content.IntentFilter(action: Android.Bluetooth.Adapter.Action.stateChanged.rawValue)
        registerReceiver(receiver: bluetoothChangeStateReceiver!, filter: intentFilter)
        
        if(bluetoothAdapter!.isEnabled()){
            verifyGspPermission()
        } else {
            let enableBluetoothIntent = Android.Content.Intent(action: Android.Bluetooth.Adapter.Action.requestEnable.rawValue)
            startActivityForResult(intent: enableBluetoothIntent, requestCode: REQUEST_ENABLE_BT)
        }
    }
    
    override func onPause() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        unregisterReceiver(receiver: bluetoothChangeStateReceiver!)
    }
    
    override func onActivityResult(requestCode: Int, resultCode: Int, data: Android.Content.Intent?) {
        
        NSLog("\(type(of: self)) \(#function) - requestCode = \(requestCode) - resultCode = \(resultCode)")
        if(resultCode == REQUEST_ENABLE_BT && resultCode == SwiftSupportAppCompatActivity.RESULT_OK){
            
            verifyGspPermission()
        }
    }
    
    override func onRequestPermissionsResult(requestCode: Int, permissions: [String], grantResults: [Int]) {
        
        NSLog("\(type(of: self)) \(#function)")
        
        if(requestCode == REQUEST_GPS_PERMISSION){
            
            if(grantResults[0] == Android.Content.PM.PackageManager.Permission.granted.rawValue){
                
                startDiscovery()
            }else{
                NSLog(" \(type(of: self)) \(#function) GPS Permission is required")
            }
        }
    }
    
    private func verifyGspPermission() {
        NSLog("\(type(of: self)) \(#function)")
        
        if(Android.OS.Build.Version.Sdk.sdkInt.rawValue >= Android.OS.Build.VersionCodes.m.rawValue
            && checkSelfPermission(permission: Android.ManifestPermission.accessCoarseLocation.rawValue) != Android.Content.PM.PackageManager.Permission.granted.rawValue) {
            
            NSLog("\(type(of: self)) \(#function) request permission")
            
            let permissions = [Android.ManifestPermission.accessCoarseLocation.rawValue]
            
            requestPermissions(permissions: permissions, requestCode: REQUEST_GPS_PERMISSION)
        }else{
            
            NSLog("\(type(of: self)) \(#function) dont request permission")
            startDiscovery()
        }
    }
    
    public func startDiscovery() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        startScanning()
    }
    
    public func startScanning(){
        
        
        //bluetoothAdapter?.lowEnergyScanner?.startScan(callback: scanCallback!)
        
        
        NSLog("\(type(of: self)) \(#function)scanData.peripheral")
        
        DispatchQueue.global(qos: .background).async {
        
            do {
                let androidCentral = AndroidCentral()
                
                try androidCentral.scan(filterDuplicates: false, shouldContinueScanning: { true }, foundDevice: {
                    (scanData) in
                    
                    NSLog("\(scanData.peripheral.identifier.rawValue) - \(scanData.rssi)")
                    
                    let deviceModel = DeviceModel(device: scanData.peripheral.device, rssi: Int(scanData.rssi))
                    
                    self.deviceAdapter?.addDevice(newDevice: deviceModel)
                    
                    try? androidCentral.connect(to: scanData.peripheral, timeout: 3000)
                    
                    let uuid = [BluetoothUUID]()
                    
                    try androidCentral.discoverServices(uuid, for: scanData.peripheral, timeout: 3000)
                    
                    //androidCentral.disconnect(peripheral: scanData.peripheral)
                })
            } catch {
                NSLog("\(type(of: self)) \(#function) Scanning error")
                assertionFailure("Scanning error ")
                return
            }
        }
    }
    
    public func stopScanning(){
        
        bluetoothAdapter?.lowEnergyScanner?.stopScan(callback: scanCallback!)
    }
    
    public func showLog() {
        NSLog("\(type(of: self)) \(#function)")
    }
    
    deinit {
        
        NSLog("\(type(of: self)): \(#function)")
    }
}
