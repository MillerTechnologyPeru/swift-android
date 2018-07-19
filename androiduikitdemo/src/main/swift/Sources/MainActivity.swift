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
    
    var view: UIView!
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        NSLog("\(type(of: self)) \(#function)")
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.MATCH_PARENT))
        
         let uiView1 = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
         uiView1.backgroundColor = UIColor.purple
        
         view.addSubview(uiView1)
         
         let uiView2 = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
         uiView2.backgroundColor = UIColor.orange
         view.addSubview(uiView2)

        setContentView(view: view.androidView)
    }
}

#endif


