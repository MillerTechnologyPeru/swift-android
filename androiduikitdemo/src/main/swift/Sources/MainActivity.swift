//
//  MsinActivity.swift
//  AndroidUIKit
//
//  Created by Carlos Duclos on 7/13/18.
//

#if os(iOS)

import UIKit

class MainViewController: UIViewController {
    
}

#else

import Foundation
import java_swift
import java_lang
import java_util
import Android

// Like AppDelegate in iOS
final class MainActivity: SwiftSupportAppCompatActivity {
    
    var rootView: Android.Widget.FrameLayout!
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        NSLog("\(type(of: self)) \(#function)")
        
        rootView = Android.Widget.FrameLayout(context: UIApplication.context!)
        rootView.layoutParams = Android.View.ViewGroup.LayoutParams(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.MATCH_PARENT)
        
         let uiView1 = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
         uiView1.backgroundColor = UIColor.blue
        
         rootView.addView(uiView1.androidView)
         
         let uiView2 = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
         uiView2.backgroundColor = UIColor.red
         rootView.addView(uiView2.androidView)

        setContentView(view: rootView)
    }
}

#endif


