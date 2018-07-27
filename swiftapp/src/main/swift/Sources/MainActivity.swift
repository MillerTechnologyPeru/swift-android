//
//  MainActivity.swift
//  Android
//
//  Created by Killian Greene on 7/18/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("MainActivity bind \(#function)")
    return MainActivity.self
}

// Like AppDelegate in iOS
final class MainActivity: SwiftSupportAppCompatActivity {
    var rootView: Android.Widget.FrameLayout!
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        NSLog("\(type(of: self)) \(#function)")
        
        rootView = Android.Widget.FrameLayout(context: UIApplication.context!)
        //rootView.layoutParams = Android.View.ViewGroup.LayoutParams(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.MATCH_PARENT)
        //rootView.layoutParams = Android.Widget.FrameLayout.FLayoutParams(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.MATCH_PARENT, gravity: 80)
        
        // Fill: 119
        // Center: 17
        // Bottom: 80
        // Top: 48
        // Left: 3
        // Right: 5
        
        // Create a frame layout with width, height 800, and gravity is at center
        rootView.layoutParams = Android.Widget.FrameLayout.FLayoutParams(width: 1000, height: 1000, gravity: 17)
        rootView.background = Android.Graphics.Drawable.ColorDrawable.init(color: AndroidGraphicsColor.BLACK)

        // Created view
        let view1 = Android.View.View.init(context: UIApplication.context!)
        view1.layoutParams = Android.View.ViewGroup.LayoutParams(width: 100, height: 100)
        view1.background = Android.Graphics.Drawable.ColorDrawable.init(color: AndroidGraphicsColor.CYAN)
        //view1.setX(x: 200.0)
        //view1.setY(y: 800.0)
        
        // Custom view
        let myView: NewView = NewView(context: UIApplication.context!)
        myView.setClickable(clickable: true)
        myView.background = Android.Graphics.Drawable.ColorDrawable.init(color: AndroidGraphicsColor.RED)
        myView.layoutParams = Android.View.ViewGroup.LayoutParams(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: 200)
        
        // TextView
        let viewResource = self.getIdentifier(name: "activity_main", type: "layout")
        let mainView = Android.View.LayoutInflater.from(context: UIApplication.context!).inflate(resource:
            Android.R.Layout(rawValue: viewResource), root: rootView, attachToRoot: false)
        let tvId = self.getIdentifier(name: "textview1", type: "id")
        guard let textviewObject = mainView.findViewById(tvId)
            else { fatalError("No view for \(tvId)") }
        let textview: Android.Widget.TextView? = Android.Widget.TextView(casting: textviewObject)
        textview!.text = "Swift App testing"
        textview!.setBackgroundColor(color: 50)
        // Width and height must be "match parent in order to use gravity
        textview!.setGravity(80)
        NSLog("Text: \(textview!.text)")
        
        
        
        // Views to add to NewViewGroup
        let addedView1 = Android.View.View.init(context: UIApplication.context!)
        addedView1.layoutParams = Android.View.ViewGroup.LayoutParams(width: 100, height: 100)
        addedView1.background = Android.Graphics.Drawable.ColorDrawable.init(color: 0x0000CC)
        let addedView2 = Android.View.View.init(context: UIApplication.context!)
        addedView2.layoutParams = Android.View.ViewGroup.LayoutParams(width: 100, height: 100)
        addedView2.background = Android.Graphics.Drawable.ColorDrawable.init(color: 0x000033)
        let addedView3 = Android.View.View.init(context: UIApplication.context!)
        addedView3.layoutParams = Android.View.ViewGroup.LayoutParams(width: 100, height: 100)
        addedView3.background = Android.Graphics.Drawable.ColorDrawable.init(color: 0x000088)
        let addedView4 = Android.View.View.init(context: UIApplication.context!)
        addedView4.layoutParams = Android.View.ViewGroup.LayoutParams(width: 100, height: 100)
        addedView4.background = Android.Graphics.Drawable.ColorDrawable.init(color: 0x0000FF)
        let addedView5 = Android.View.View.init(context: UIApplication.context!)
        addedView5.layoutParams = Android.View.ViewGroup.LayoutParams(width: 100, height: 100)
        addedView5.background = Android.Graphics.Drawable.ColorDrawable.init(color: 0x000022)
        
        // NewViewGroup
        let newViewGroup: NewViewGroup = NewViewGroup(context: UIApplication.context!)
        
        newViewGroup.addView(addedView1)
        newViewGroup.addView(addedView2)
        newViewGroup.addView(addedView3)
        newViewGroup.addView(addedView4)
        newViewGroup.addView(addedView5)
        
        NSLog("Adding views...")
        rootView.addView(myView)
        rootView.addView(view1)
        rootView.addView(mainView)
        rootView.addView(textview!)
        //rootView.addView(newViewGroup)
        
        setContentView(view: rootView)
    }
}




