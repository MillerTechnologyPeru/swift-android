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

/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("MainActivity bind \(#function)")
    return MainActivity.self
}

// Like AppDelegate in iOS
final class MainActivity: SwiftSupportAppCompatActivity {
    
    private let REQUEST_ENABLE_BT = 1000
    
    private var bluetoothChangeStateReceiver: BluetoothChangeStateReceiver?
    
    private let bluetoothAdapter = Android.Bluetooth.Adapter.default
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        NSLog("MainActivity \(#function)")
        
        
        
        bluetoothChangeStateReceiver = BluetoothChangeStateReceiver(mainActivity: self)
        
    }
    
    override func onResume() {
        
        NSLog("MainActivity \(#function)")
        
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
        
        NSLog("MainActivity \(#function)")
        
        unregisterReceiver(receiver: bluetoothChangeStateReceiver!)
    }
    
    override func onActivityResult(requestCode: Int, resultCode: Int, data: Android.Content.Intent?) {
        
        NSLog("MainActivity \(#function) - requestCode = \(requestCode) - resultCode = \(resultCode)")
        NSLog("MainActivity \(#function) - \(REQUEST_ENABLE_BT) - \(SwiftSupportAppCompatActivity.RESULT_OK)")
        if(resultCode == REQUEST_ENABLE_BT && resultCode == SwiftSupportAppCompatActivity.RESULT_OK){
            
            verifyGspPermission()
        }
    }
    
    override func onRequestPermissionsResult(requestCode: Int, permissions: [String], grantResults: [Int]) {
        
        NSLog("MainActivity \(#function)")
    }
    
    private func verifyGspPermission() {
        NSLog("MainActivity \(#function)")
    }
    
    public func showLog() {
        NSLog("MainActivity \(#function)")
    }
}
