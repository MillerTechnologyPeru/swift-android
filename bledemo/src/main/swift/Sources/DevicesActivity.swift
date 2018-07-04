//
//  DevicesActivity.swift
//  Android
//
//  Created by Marco Estrella on 6/18/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android


/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainApplication")
public func SwiftAndroidMainApplication() -> SwiftApplication.Type {
    NSLog("SwiftDemoApplication bind \(#function)")
    return SwiftDemoApplication.self
}

// Like AppDelegate in iOS
final class SwiftDemoApplication: SwiftApplication {

    override func onCreate() {
         NSLog("SwiftDemoApplication \(#function)")
    }
}

/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("MainActivity bind \(#function)")
    return MainActivity.self
}

// Like AppDelegate in iOS
final class MainActivity: SwiftSupportAppCompatActivity {

    override func onCreate(savedInstanceState: Android.OS.Bundle?) {

        NSLog("MainActivity \(#function)")

    }
}

final class DevicesActivityBinding_ListenerImpl: DevicesActivityBinding_ListenerBase {
    
    @_silgen_name("Java_com_jmarkstar_bledemo_DevicesActivity_bind")
    public static func bind( __env: UnsafeMutablePointer<JNIEnv?>, __this: jobject?, __self: jobject? )-> jobject? {
        
        // This Swift instance forwards to Java through JNI
        let responder = DevicesActivityBinding_ResponderForward( javaObject: __self )
        
        // This Swift instance receives native calls from Java
        var locals = [jobject]()
        return DevicesActivityBinding_ListenerImpl(responder: responder).localJavaObject( &locals )
    }
    
    let responder: DevicesActivityBinding_ResponderForward
    
    let bluetoothAdapter = Android.Bluetooth.Adapter.default
    
    var demoScanCallback: DemoScanCallback? = nil
    
    init(responder: DevicesActivityBinding_ResponderForward) {
        
        NSLog("\(type(of: self)): \(#function)")
        
        self.responder = responder
        self.demoScanCallback = DemoScanCallback(responder: responder)
    }
    
    deinit {
        
        NSLog("\(type(of: self)): \(#function)")
    }
    
    override func validateBluetooth() {
        
        if(!bluetoothAdapter!.isEnabled()){
            NSLog("Bluetooth is not enabled")
            responder.activateBluetooth()
            return
        }
        responder.verifyGpsPermission()
    }
    
    override func startScan() {
        NSLog("\(type(of: self)): \(#function)")
        if(!bluetoothAdapter!.isEnabled()){
            let success = bluetoothAdapter!.enable()
            NSLog("\(type(of: self)): \(#function) - enable = \(success)")
        }
        if(bluetoothAdapter!.getState() == 12){
            bluetoothAdapter?.lowEnergyScanner?.startScan(callback: demoScanCallback!)
        }
    }
    
    override func stopScan() {
        NSLog("\(type(of: self)): \(#function)")
        bluetoothAdapter?.lowEnergyScanner?.stopScan(callback: demoScanCallback!)
        /*
        if(bluetoothAdapter!.isEnabled()){
            bluetoothAdapter?.lowEnergyScanner?.stopScan(callback: demoScanCallback!)
            let success = bluetoothAdapter!.disable()
            NSLog("\(type(of: self)): \(#function) - disable = \(success)")
        }*/
    }
    
    override func connectToDevice(context: JavaObject?, device: JavaObject?) {
        
        let gattCallback = DemoGattCallback(responder: responder)
        let contextSwift = Android.Content.Context.init(casting: context!)
        let deviceSwift = Android.Bluetooth.Device(casting: device!)
        
        let gatt = deviceSwift?.connectGatt(context: contextSwift!, autoConnect: false, callback: gattCallback)
    }
}
