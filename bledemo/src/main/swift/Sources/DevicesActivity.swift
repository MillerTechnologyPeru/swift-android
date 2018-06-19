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
        self.demoScanCallback = DemoScanCallback()
        //self.demoScanCallback?.addResponse(responder: responder)
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
        Android.Bluetooth.Adapter.default?.lowEnergyScanner?.startScan(callback: demoScanCallback!)
    }
    
    override func stopScan() {
        NSLog("\(type(of: self)): \(#function)")
        Android.Bluetooth.Adapter.default?.lowEnergyScanner?.stopScan(callback: demoScanCallback!)
    }
}
