import Foundation
import Android

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
