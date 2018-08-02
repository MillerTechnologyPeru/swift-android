//
//  DeviceDetailDialogFragment.swift
//  Android
//
//  Created by Marco Estrella on 8/2/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

class DeviceDetailDialogFragment: AndroidFullScreenDialogFragment {
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        NSLog("\(type(of: self)) \(#function)")
    }
    
    override func onCreateView(inflater: Android.View.LayoutInflater, container: Android.View.ViewGroup?, savedInstanceState: Android.OS.Bundle?) -> Android.View.View {
        NSLog("\(type(of: self)) \(#function) 1")
        let view = Android.Widget.FrameLayout(context: context!)
        view.layoutParams = Android.Widget.FrameLayout.FLayoutParams(width: 200, height: 200)
        //view.background = AndroidGraphicsDrawableColorDrawable.init(color: AndroidGraphicsColor.BLUE)
        NSLog("\(type(of: self)) \(#function) 2")
        return view
    }
    
    override func onViewCreated(view: Android.View.View, savedInstanceState: Android.OS.Bundle?) {
        NSLog("\(type(of: self)) \(#function)")
    }
    
    override func onResume() {
        NSLog("\(type(of: self)) \(#function)")
    }
    
    override func onDestroyView() {
        NSLog("\(type(of: self)) \(#function)")
    }
    
    override func onDestroy() {
        NSLog("\(type(of: self)) \(#function)")
    }
}
