//
//  TestBottomNavViewActitivy.swift
//  Android
//
//  Created by Marco Estrella on 10/16/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

 /// Needs to be implemented by app.
 @_silgen_name("SwiftAndroidMainActivity")
 public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
 NSLog("TestBottomNavViewActitivy bind \(#function)")
 return TestBottomNavViewActitivy.self
 }

// Like AppDelegate in iOS
final class TestBottomNavViewActitivy: SwiftSupportAppCompatActivity {
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        NSLog("\(type(of: self)) \(#function)")
        
        let metrics = AndroidDisplayMetrics()
        windowManager?.defaultDisplay?.getMetrics(outMetrics: metrics)
        
        let rootFrameLayout = AndroidWidgetFrameLayout.init(context: self)
        rootFrameLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)
        rootFrameLayout.setBackgroundColor(color: AndroidGraphicsColor.MAGENTA)
        
        let bottomNavView = AndroidBottomNavigationView.init(context: self)
        
        let menu = bottomNavView.menu
        
        let menuItem2 = AndroidViewCompat.generateViewId()
        
        let breakfastId = getIdentifier(name: "ic_free_breakfast", type: "drawable")
        let restaurantId = getIdentifier(name: "ic_restaurant_menu", type: "drawable")
        let chatId = getIdentifier(name: "ic_chat", type: "drawable")
        
        menu.add(groupId: 1, itemId: AndroidViewCompat.generateViewId(), order: 1, title: "Breakfast").setIcon(resId: breakfastId)
        menu.add(groupId: 1, itemId: menuItem2, order: 2, title: "Restaurant").setIcon(resId: restaurantId)
        menu.add(groupId: 1, itemId: AndroidViewCompat.generateViewId(), order: 3, title: "Chat").setIcon(resId: chatId)
        
        bottomNavView.selectedItemId = menuItem2
        
        bottomNavView.setOnNavigationItemSelectedListener { menuItem in
            
            self.showMessage(menuItem.title!)
        }
        
        rootFrameLayout.addView(bottomNavView)
        
        setContentView(view: rootFrameLayout)
    }
    
    func showMessage(_ message: String){
        
        AndroidToast.makeText(context: self, text: message, duration: AndroidToast.Dutation.short).show()
    }
}
