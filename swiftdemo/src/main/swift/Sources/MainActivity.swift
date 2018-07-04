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
    
    private var bluetoothChangeStateReceiver: BluetoothChangeStateReceiver?
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        NSLog("MainActivity \(#function)")
        
        bluetoothChangeStateReceiver = BluetoothChangeStateReceiver(mainActivity: self)
    }
    
    override func onResume() {
        
        NSLog("MainActivity \(#function)")
        
        let intentFilter = Android.Content.IntentFilter(action: Android.Bluetooth.Adapter.ACTION_STATE_CHANGED)
        registerReceiver(receiver: bluetoothChangeStateReceiver!, filter: intentFilter)
    }
    
    override func onPause() {
        
        NSLog("MainActivity \(#function)")
        
        unregisterReceiver(receiver: bluetoothChangeStateReceiver!)
    }
    
    override func onRequestPermissionsResult(requestCode: Int, permissions: [String], grantResults: [Int]) {
        
        NSLog("MainActivity \(#function)")
    }
    
    public func showLog(){
        NSLog("MainActivity \(#function)")
    }
}
