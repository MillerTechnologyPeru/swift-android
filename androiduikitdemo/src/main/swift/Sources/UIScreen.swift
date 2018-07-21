//
//  UIScreen.swift
//  androiduikittarget
//
//  Created by Alsey Coleman Miller on 7/20/18.
//

import Foundation
import Android
import java_swift

public final class AndroidUIKitMainActivity: SwiftSupportAppCompatActivity {
    
    public required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
        
        // initialize
        let _ = self.screen
        
        // load app
        let app = UIApplication.shared
        
        guard let delegate = app.delegate
            else { assertionFailure("Missing UIApplicationDelegate"); return }
        
        // Tells the delegate that the launch process has begun but that state restoration has not yet occurred.
        if delegate.application(app, willFinishLaunchingWithOptions: nil) == false {
            
            
        }
        
        if delegate.application(app, didFinishLaunchingWithOptions: nil) == false {
            
            
        }
    }
    
    public lazy var screen: UIScreen = UIScreen.mainScreen(for: AndroidContext(casting: self))
}

public final class UIScreen {
    
    // MARK: - Initialization
    
    // FIXME: Change to Window
    internal let activity: SwiftSupport.App.AppCompatActivity
    
    fileprivate init(activity: SwiftSupport.App.AppCompatActivity) {
        
        self.activity = activity
        
        assert(activity.javaObject != nil, "Java object not initialized")
    }
    
    fileprivate static func mainScreen(for activity: SwiftSupport.App.AppCompatActivity) -> UIScreen  {
        
        assert(_main == nil, "Main screen is already initialized")
        
        let screen = UIScreen(activity: activity)
        
        _main = screen
        
        return screen
    }
    
    public static var screens: [UIScreen] { return [UIScreen.main] }
    
    public static var main: UIScreen {
        
        guard let mainScreen = _main
            else { fatalError("No main screen configured") }
        
        return mainScreen
    }
    
    internal static var _main: UIScreen?

    // MARK: - Properties
    
    public var mirrored: UIScreen? { return nil }
    
    // FIXME: Get size from window
    public var bounds: CGRect { return CGRect(origin: .zero, size: .zero) }
    
    public var nativeBounds: CGRect { return CGRect(origin: .zero, size: .zero) }
    
    public var scale: CGFloat { return 1 }
    
    public var nativeScale: CGFloat { return scale }
    
    public var maximumFramesPerSecond: Int {
        
        return 60
    }
    
    internal var needsLayout: Bool = true
    internal var needsDisplay: Bool = true
    
    /// Children windows
    private var _windows = WeakArray<UIWindow>()
    internal var windows: [UIWindow] { return _windows.values() }
    
    internal private(set) weak var keyWindow: UIWindow?
    
    // MARK: - Methods
    
    internal func addWindow(_ window: UIWindow) {
        
        _windows.append(window)
        
        // add view in Android
        activity.setContentView(view: window.androidView)
    }
    
    internal func setKeyWindow(_ window: UIWindow) {
        
        guard UIScreen.main.keyWindow !== self
            else { return }
        
        if windows.contains(where: { $0 === window }) == false {
            
            addWindow(window)
        }
        
        keyWindow?.resignKey()
        keyWindow = window
        keyWindow?.becomeKey()
    }
}
