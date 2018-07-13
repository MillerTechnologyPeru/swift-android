//
//  SwiftDemoApplication.swift
//  Android
//
//  Created by Marco Estrella on 7/4/18.
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
    
    public static var context: Android.Content.Context?
    
    override func onCreate() {
         NSLog("SwiftDemoApplication \(#function)")
        
        SwiftDemoApplication.context = Android.Content.Context.init(casting: self)
    }
}
