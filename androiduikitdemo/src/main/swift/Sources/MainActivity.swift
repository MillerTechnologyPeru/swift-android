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
    
    var rootView: Android.Widget.FragmentLayout!
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        NSLog("\(type(of: self)) \(#function)")
        
        rootView = Android.Widget.FragmentLayout(context: UIApplication.context!)
        rootView.layoutParams = Android.Widget.FragmentLayout.FLayoutParams(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.MATCH_PARENT)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        rootView.addView(child: view.androidView)
        
        let view2 = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        rootView.addView(child: view2.androidView)
        
        setContentView(view: rootView)
    }
    
}

#endif


