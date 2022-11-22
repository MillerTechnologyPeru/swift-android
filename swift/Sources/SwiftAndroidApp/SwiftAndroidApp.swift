import Foundation
import Android
import java_swift
import java_lang
import CJavaVM

public final class SwiftAndroidApp: SwiftApplication {

    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .full
        formatter.dateStyle = .full
        return formatter
    }()
    
    @_silgen_name("Java_com_pureswift_swiftandroid_Application_00024Companion_didLaunch")
    public static func didLaunch() {
        NSLog("Launching Android app")
        let date = Date()
        NSLog("\(formatter.string(from: date))")
        NSLog("\(UUID())")
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
