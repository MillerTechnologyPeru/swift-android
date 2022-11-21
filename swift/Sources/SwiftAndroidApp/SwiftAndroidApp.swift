import Foundation
import Android

public final class SwiftAndroidApp: SwiftApplication {
    
    @_silgen_name("Java_com_pureswift_swiftandroid_Application_00024Companion_didLaunch")
    public static func didLaunch() {
        NSLog("Launching Android app")
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
