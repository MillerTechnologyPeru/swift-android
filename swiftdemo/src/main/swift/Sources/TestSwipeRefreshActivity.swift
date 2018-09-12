//
//  TestSwipeRefreshActivity.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 9/12/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("TestSwipeRefreshActivity bind \(#function)")
    return TestSwipeRefreshActivity.self
}

// Like AppDelegate in iOS
final class TestSwipeRefreshActivity: SwiftSupportAppCompatActivity {
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        let metrics = AndroidDisplayMetrics()
        windowManager?.defaultDisplay?.getMetrics(outMetrics: metrics)
        
        let swipeRefreshLayout = AndroidSwipeRefreshLayout(context: self)
        swipeRefreshLayout.setY(y: 200)
        swipeRefreshLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)
        swipeRefreshLayout.setColorSchemeColors(colors: AndroidGraphicsColor.GREEN)
        
        let rootFrameLayout = AndroidWidgetFrameLayout.init(context: self)
        rootFrameLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)
        rootFrameLayout.setBackgroundColor(color: AndroidGraphicsColor.GREEN)
        
        swipeRefreshLayout.addView(rootFrameLayout)
        
        let buttonWidth = Int(150 * metrics.density)
        let buttonHeight = Int(80 * metrics.density)
        
        let margin = Int(16 * metrics.density)
        let layoutparams = AndroidFrameLayoutLayoutParams(width: buttonWidth, height: buttonHeight)
        layoutparams.setMargins(left: margin, top: margin, right: margin, bottom: margin)
        
        let button1 = AndroidButton.init(context: self)
        button1.layoutParams = layoutparams
        button1.text = "Start"
        
        let button2 = AndroidButton.init(context: self)
        button2.layoutParams = layoutparams
        button2.text = "End"
        button2.setY(y: 100 * metrics.density)
        
        rootFrameLayout.addView(button1)
        rootFrameLayout.addView(button2)
        
        setContentView(view: swipeRefreshLayout)
        
        button1.setOnClickListener {
            
            swipeRefreshLayout.isRefreshing = true
        }
        
        button2.setOnClickListener {
            
            swipeRefreshLayout.isRefreshing = false
        }
        
        swipeRefreshLayout.setOnRefreshListener {
            
            AndroidToast.makeText(context: self, text: "SwipeRefreshLayout working", duration: AndroidToast.Dutation.short).show()
        }
    }
}
