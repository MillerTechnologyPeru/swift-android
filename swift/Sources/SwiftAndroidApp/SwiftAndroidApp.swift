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
    
    static var foundDevices = [String: BluetoothDevice]()
    
    public override func onCreate() {
        super.onCreate()
        
        didLaunch()
    }
    
    private func didLaunch() {
        NSLog("Launching Android app")
        
        let date = Date()
        NSLog("\(Self.formatter.string(from: date))")
        NSLog("\(UUID())")
        
        // Setup encoder
        JavaCoderConfig.RegisterBasicJavaTypes()
        
        // TODO: Request Bluetooth permissions
        
        // Start scan
        Task {
            do {
                try? await Task.sleep(for: .seconds(3))
                try await scan(context: AndroidContext(casting: self)!)
            }
            catch {
                NSLog("Error: \(error)")
            }
        }
    }
    
    private func updateView(_ devices: [BluetoothDevice]) {
        
        let encoder = JavaEncoder(forPackage: "com.pureswift.swiftandroid")
        
        var __locals = [jobject]()
        var __args = [jvalue]( repeating: jvalue(), count: 1 )
        do {
            let values = Self.foundDevices.values.sorted(by: { $0.id < $1.id })
            __args[0] = try encoder.encode(values).value(locals: &__locals)
        }
        catch {
            NSLog("Unable to encode Java Object. \(error)")
            return
        }
        
        struct JNICache {
            struct MethodID {
                static var updateView: jmethodID?
            }
        }
        
        JNIMethod.CallVoidMethod(
            object: javaObject,
            methodName: "updateView",
            methodSig: "(Ljava/util/ArrayList;)V",
            methodCache: &JNICache.MethodID.updateView,
            args: &__args,
            locals: &__locals
        )
    }
    
    private func scan(context: Android.Content.Context) async throws {
        
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
            // update UI
            let values = SwiftAndroidApp.foundDevices.values.sorted(by: { $0.id < $1.id })
            self.updateView(values)
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
