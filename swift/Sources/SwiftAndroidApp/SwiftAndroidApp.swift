import Foundation
import Android
import AndroidBluetooth
import Bluetooth
import GATT
import java_swift
import java_lang
import CJavaVM
import JavaCoder

public final class SwiftAndroidApp: SwiftApplication {

    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .full
        formatter.dateStyle = .full
        return formatter
    }()
    
    static var foundDevices = [String: BluetoothDevice]()
    
    public override func onCreate() {
        super.onCreate()
        
        didLaunch()
    }
    
    public func didLaunch() {
        NSLog("Launching Android app")
        
        let date = Date()
        NSLog("\(Self.formatter.string(from: date))")
        NSLog("\(UUID())")
        
        // Setup encoder
        JavaCoderConfig.RegisterBasicJavaTypes()
        
        // Request Bluetooth permissions
        
        Task {
            do {
                try await scan(context: AndroidContext(casting: self)!)
            }
            catch {
                NSLog("Error: \(error)")
            }
        }
        
        Task {
            
        }
    }
    
}

struct BluetoothDevice: Equatable, Hashable, Codable {
    
    let id: String
    
    let date: Foundation.Date
    
    let address: String
    
    let name: String?
    
    let company: String?
}

@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("\(#function)")
    fatalError()
}

@_silgen_name("SwiftAndroidMainApplication")
public func SwiftAndroidMainApplication() -> SwiftApplication.Type {
    NSLog("\(#function)")
    return SwiftAndroidApp.self
}

func greeting(name: String) -> String {
    var greeting = "Hello \(name)! ✋" + "\n"
    greeting += SwiftAndroidApp.formatter.string(from: Date()) + "\n"
    return greeting
}

@_silgen_name("Java_com_pureswift_swiftandroid_MainActivityKt_greetingNative")
public func java_greeting(
    _ __env: UnsafeMutablePointer<JNIEnv?>,
    _ __this: jobject?,
    _ __arg0: jobject?
) -> jvalue {
    assert(__arg0 != nil)
    let name = String(javaObject: __arg0)
    let string = greeting(name: name)
    var __locals = [jobject]()
    var __args = [jvalue]( repeating: jvalue(), count: 1 )
    __args[0] = JNIType.toJava( value: string, locals: &__locals )
    return __args[0]
}

func scan(context: Android.Content.Context) async throws {
    
    guard let hostController = Android.Bluetooth.Adapter.default else {
        throw AndroidCentralError.bluetoothDisabled
    }
    let central = AndroidCentral(
        hostController: hostController,
        context: context
    )
    central.log = { NSLog("Central: \($0)") }
    let stream = try await central.scan()
    for try await scanData in stream {
        NSLog("Found \(scanData.peripheral)")
        if let localName = scanData.advertisementData.localName {
            NSLog("\(localName)")
        }
        if let manufacturerData = scanData.advertisementData.manufacturerData {
            NSLog("\(manufacturerData.companyIdentifier)")
        }
        let device = BluetoothDevice(
            id: scanData.peripheral.description,
            date: scanData.date,
            address: scanData.peripheral.id.description,
            name: scanData.advertisementData.localName,
            company: scanData.advertisementData.manufacturerData?.companyIdentifier.name
        )
        SwiftAndroidApp.foundDevices[device.id] = device
    }
}

@_silgen_name("Java_com_pureswift_swiftandroid_MainActivity_devices")
public func java_devices(
    _ __env: UnsafeMutablePointer<JNIEnv?>,
    _ __this: jobject?
) -> jobject? {
    let encoder = JavaEncoder(forPackage: "com.pureswift.swiftandroid")
    do {
        let values = SwiftAndroidApp.foundDevices.values.sorted(by: { $0.id < $1.id })
        NSLog("Found \(values.count) devices")
        return try encoder.encode(values)
    }
    catch {
        NSLog("Unable to encode Java Object. \(error)")
        return nil
    }
}
