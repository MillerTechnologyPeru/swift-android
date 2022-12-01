//
//  MainActivity.swift
//  
//
//  Created by Alsey Coleman Miller on 11/30/22.
//

import Foundation
import Android
import AndroidBluetooth
import Bluetooth
import GATT
import JavaCoder
import JNI
import java_swift
import java_lang
import CJavaVM

@available(macOS 13.0, *)
@MainActor
final class MainActivity: SwiftComponentActivity {
        
    override nonisolated func onCreate(savedInstanceState: Android.OS.Bundle?) {
        super.onCreate(savedInstanceState: savedInstanceState)
        
        drainMainQueue()
    }
    
    private nonisolated func drainMainQueue() {
        // drain main queue
        Task { [weak self] in
            while let self = self {
                try? await Task.sleep(for: .milliseconds(100))
                self.runOnMainThread {
                    RunLoop.main.run(until: Date() + 0.01)
                }
            }
        }
    }
}
