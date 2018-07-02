//
//  MainApplication.swift
//  Android
//
//  Created by Marco Estrella on 7/1/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainApplication")
public func SwiftAndroidMainApplication() -> SwiftApplication.Type {
    NSLog("Swift \(#function)")
    return MainApplication.self
}

// Like AppDelegate in iOS
final class MainApplication: SwiftApplication {
    
    override func onCreate(){
        NSLog("Swift \(#function)")
        
    }
    
}
