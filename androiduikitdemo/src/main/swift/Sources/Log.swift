//
//  Log.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 12/13/18.
//

import Foundation

/// app logger function
func log(_ message: String) {
    
    #if os(Android)
    NSLog("AndroidUIKitDemo: \(message)")
    #else
    print("AndroidUIKitDemo: \(message)")
    #endif
}
