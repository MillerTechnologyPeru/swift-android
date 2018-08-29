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
import GATT
/*
/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("MainActivity bind \(#function)")
    return MainActivity.self
}*/

// Like AppDelegate in iOS
final class MainActivity: SwiftSupportAppCompatActivity {
    
    private let REQUEST_ENABLE_BT = 1000
    private let REQUEST_GPS_PERMISSION = 2000
    
    private var bluetoothChangeStateReceiver: BluetoothChangeStateReceiver?
    
    private let bluetoothAdapter = Android.Bluetooth.Adapter.default
    
    private var scanCallback: MySwiftScanCallback?
    
    private var gattCallback: MySwiftGattCallback?
    
    public var peripheralAdapter: PeripheralAdapter?
    
    internal lazy var central = AndroidCentral(hostController: Android.Bluetooth.Adapter.default!,
                                               context: SwiftDemoApplication.context!,
                                               options: AndroidCentral.Options(maximumTransmissionUnit: ATTMaximumTransmissionUnit(rawValue: 200)!))
    
    internal lazy var scanQueue: DispatchQueue = DispatchQueue(label: "Scan Queue")
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        NSLog("\(type(of: self)) \(#function)")
        
        let viewId = getIdentifier(name: "activity_devices", type: "layout")
        
        NSLog("\(type(of: self)) viewId = \(viewId)")
        
        setContentView(layoutResID: viewId)
        
        bluetoothChangeStateReceiver = BluetoothChangeStateReceiver(mainActivity: self)
        
        scanCallback = MySwiftScanCallback(mainActivity: self)
        
        gattCallback = MySwiftGattCallback(mainActivity: self)
        
        peripheralAdapter = PeripheralAdapter(mainActivity: self)
        
        let context = Android.Content.Context(casting: self)
        let linearLayoutManager = Android.Widget.RecyclerView.LinearLayoutManager(context: context!)
        
        let rvId = getIdentifier(name: "rvDevices", type: "id")
        NSLog("\(type(of: self)) rvId = \(rvId)")

        let rvDevices = Android.Widget.RecyclerView(casting: findViewById(rvId)!)
        
        rvDevices?.adapter = peripheralAdapter!
        
        rvDevices?.layoutManager = linearLayoutManager
        
        peripheralAdapter?.onItemClick = { (device) in
            
            let peripheral = device.peripheral
            
            do {
                try self.central.connect(to: peripheral)
                NSLog("Peripheral UUID: \(peripheral.identifier)")
                let services = try self.central.discoverServices(for: peripheral)
                NSLog("services size \(services.count)")
                try services.forEach {
                    NSLog("///////////////////")
                    NSLog("Service: \($0.uuid.rawValue)")
                    let characteristics = try self.central.discoverCharacteristics(for: $0)
                    NSLog("Its characteristics are \(characteristics.count)")
                    characteristics.forEach{ char in
                        NSLog("char: \(char.uuid.rawValue)")
                        char.properties.forEach{
                            NSLog("property: \($0)")
                        }
                    }
                    NSLog("///////////////////")
                }

                self.central.disconnect(peripheral: peripheral)
                
            } catch {
                NSLog("\(type(of: self)) \(#function) Connection error")
                NSLog("Connection error ")
                return
            }
        }
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
        
        if(Android.OS.Build.Version.Sdk.sdkInt.rawValue >= Android.OS.Build.VersionCodes.M
            && checkSelfPermission(permission: Android.ManifestPermission.accessCoarseLocation.rawValue) != Android.Content.PM.PackageManager.Permission.granted.rawValue) {
            
            NSLog("\(type(of: self)) \(#function) request permission")
            
            let permissions = [Android.ManifestPermission.accessCoarseLocation.rawValue]
            
            requestPermissions(permissions: permissions, requestCode: REQUEST_GPS_PERMISSION)
        } else {
            
            NSLog("\(type(of: self)) \(#function) dont request permission")
            startDiscovery()
        }
    }
    
    public func startDiscovery() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        startScanning()
    }
    
    public func startScanning(){
        
        NSLog("\(type(of: self)) \(#function)")
        
        scanQueue.async { [weak self] in
            
            guard let central = self?.central else { return }
        
            do {
                
                let start = Date()
                let end = start + 10.0
                try central.scan(shouldContinueScanning: { Date() < end }, foundDevice: { (scanData) in
                    
                    self?.runOnMainThread {
                        self?.peripheralAdapter?.addPeripheral(scanData)
                    }
                })
                
                
            } catch {
                NSLog("\(type(of: self)) \(#function) Scanning error")
                NSLog("Scanning error: \(error)")
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
    /*
    class ShowPeripheralsTask: SwiftRunnable {
        
        var peripheralAdapter: PeripheralAdapter?
        var data: [ScanData<Peripheral, AdvertisementData>]?
        
        public convenience init(peripheralAdapter: PeripheralAdapter, data: [ScanData<Peripheral, AdvertisementData>]) {
            
            self.init(javaObject: nil)
            self.bindNewObject()
            
            self.peripheralAdapter = peripheralAdapter
            self.data = data
        }
        
        public required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        override func run() {
            NSLog("\(type(of: self)) \(#function)")
            data?.forEach {
                peripheralAdapter?.addPeripheral($0.peripheral)
            }
        }
    }*/
}
