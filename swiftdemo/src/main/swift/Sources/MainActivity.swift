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
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity {
    NSLog("Swift \(#function)")
    return MainActivity()
}

// Like AppDelegate in iOS
final class MainActivity: SwiftSupportAppCompatActivity {
    
    func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        NSLog("Swift \(#function)")
    }
    
    func onResume() {
        
        NSLog("Swift \(#function)")
    }
    
    func onPause() {
        
        NSLog("Swift \(#function)")
    }
    
    func onRequestPermissionsResult(requestCode: Int, permissions: [String], grantResults: [Int]) {
        
        NSLog("Swift \(#function)")
    }
}
