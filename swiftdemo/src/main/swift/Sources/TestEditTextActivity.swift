//
//  TestEditTextActivity.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 12/19/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("TestEditTextActivity bind \(#function)")
    return TestEditTextActivity.self
}

// Like AppDelegate in iOS
final class TestEditTextActivity: SwiftSupportAppCompatActivity {
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
    
        let metrics = AndroidDisplayMetrics()
        windowManager?.defaultDisplay?.getMetrics(outMetrics: metrics)
        
        let rootFrameLayout = AndroidWidgetFrameLayout.init(context: self)
        rootFrameLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)
        
        let dp200 = Int(200 * metrics.density)
        let dp40 = Int(40 * metrics.density)
        
        let listener = EditTextListener()
        
        let editText = AndroidEditText.init(context: self)
        editText.layoutParams = AndroidFrameLayoutLayoutParams(width: dp200, height: dp40)
        editText.hint = "Write something here"
        editText.addTextChangedListener(listener)
        rootFrameLayout.addView(editText)
        
        setContentView(view: rootFrameLayout)
    }
}

class EditTextListener: AndroidTextWatcher {
    
    override func afterTextChanged(s: AndroidEditableForward?) {
        
        log(": afterTextChanged - \(s?.toString())")
    }
    
    override func beforeTextChanged(s: String?, start: Int, count: Int, after: Int) {
        
        log(": beforeTextChanged - s: \(s) - start: \(start) - count: \(count) - after: \(after)")
    }
    
    override func onTextChanged(s: String?, start: Int, before: Int, count: Int) {
        
        log(": onTextChanged - \(s) - start: \(start) - before: \(before) - count: \(count)")
    }
}
