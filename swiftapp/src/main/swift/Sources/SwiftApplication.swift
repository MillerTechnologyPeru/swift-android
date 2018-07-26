//
//  SwiftDemoApplication.swift
//  Android
//
//  Created by Killian Greene on 7/18/18.
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
    return UIApplication.self
}

// Like AppDelegate in iOS
final class UIApplication: SwiftApplication {
    
    public static var context: Android.Content.Context?
    
    override func onCreate() {
        NSLog("SwiftDemoApplication \(#function)")
        
        UIApplication.context = Android.Content.Context.init(casting: self)
    }
}
