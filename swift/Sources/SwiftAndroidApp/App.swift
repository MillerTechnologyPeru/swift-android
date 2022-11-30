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
public final class SwiftAndroidApp: SwiftApplication {

    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .full
        formatter.dateStyle = .full
        return formatter
    }()
        
    let launchDate = Date()
    
    public override class var runtimeConfiguration: RuntimeConfiguration {
        var configuration = RuntimeConfiguration.default
        configuration.componentActivity = MainActivity.self
        return configuration
    }
    
    public override func onCreate() {
        super.onCreate()
        
        didLaunch()
    }
    
    private func didLaunch() {
        NSLog("Launching Android app")
        
        NSLog("\(Self.formatter.string(from: launchDate))")
        NSLog("\(UUID())")
        
        // Setup encoder
        JavaCoderConfig.RegisterBasicJavaTypes()
    }
}

@_silgen_name("SwiftAndroidMainApplication")
public func SwiftAndroidMainApplication() -> SwiftApplication.Type {
    NSLog("\(#function)")
    return SwiftAndroidApp.self
}
