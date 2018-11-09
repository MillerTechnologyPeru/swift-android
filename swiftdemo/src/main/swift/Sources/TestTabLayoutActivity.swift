//
//  TestTabLayoutActivity.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 10/19/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

/*
/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("TestTabLayoutActivity bind \(#function)")
    return TestTabLayoutActivity.self
}
*/

// Like AppDelegate in iOS
final class TestTabLayoutActivity: SwiftSupportAppCompatActivity {
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        let metrics = AndroidDisplayMetrics()
        windowManager?.defaultDisplay?.getMetrics(outMetrics: metrics)
        
        let rootFrameLayout = AndroidWidgetFrameLayout.init(context: self)
        rootFrameLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)
        rootFrameLayout.setBackgroundColor(color: AndroidGraphicsColor.CYAN)
        
        let tabLayout = AndroidTabLayout.init(context: self)
        
        tabLayout.layoutParams = AndroidWidgetFrameLayout.FLayoutParams.init(width: AndroidWidgetFrameLayout.FLayoutParams.MATCH_PARENT, height: AndroidWidgetFrameLayout.FLayoutParams.WRAP_CONTENT)
        
        let breakfastId = getIdentifier(name: "ic_free_breakfast", type: "drawable")
        let restaurantId = getIdentifier(name: "ic_restaurant_menu", type: "drawable")
        let chatId = getIdentifier(name: "ic_chat", type: "drawable")
        
        let tab1 = tabLayout.newTab()
        tab1.text = "Breakfast"
        tab1.setIcon(resId: breakfastId)
        
        let tab2 = tabLayout.newTab()
        tab2.text = "Restaurants"
        tab2.setIcon(resId: restaurantId)
        
        let tab3 = tabLayout.newTab()
        tab3.text = "Chat"
        tab3.setIcon(resId: chatId)
        
        tabLayout.addTab(tab1)
        tabLayout.addTab(tab2)
        tabLayout.addTab(tab3)
        
        rootFrameLayout.addView(tabLayout)
        
        tabLayout.addOnTabSelectedListener(MyOnTabSelectedListener())
        
        setContentView(view: rootFrameLayout)
    }
}

class MyOnTabSelectedListener : AndroidTabLayout.OnTabSelectedListener {
    
    override func onTabSelected(tab: AndroidTab) {
        NSLog(" \(type(of: self)) \(#function) - \(tab.text)")
    }
    
    override func onTabReselected(tab: AndroidTab) {
        NSLog(" \(type(of: self)) \(#function) - \(tab.text)")
    }
    
    override func onTabUnselected(tab: AndroidTab) {
        NSLog(" \(type(of: self)) \(#function) - \(tab.text)")
    }
}
