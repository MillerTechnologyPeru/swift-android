//
//  BluetoothChangeStateReceiver.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 7/4/18.
//

import Foundation
import java_swift
import Android

class BluetoothChangeStateReceiver: Android.Content.BroadcastReceiver {
    
    private var activity: MainActivity?
    
    init(mainActivity: MainActivity){
        super.init(javaObject: nil)
        super.bindNewJavaObject()
        
        activity = mainActivity
        
        NSLog("\(type(of: self)) \(#function)")
    }
    
    required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    override func onReceive(context: Android.Content.Context?, intent: Android.Content.Intent?) {
        NSLog("\(type(of: self)) \(#function)")
        
        activity?.showLog()
    }
}
