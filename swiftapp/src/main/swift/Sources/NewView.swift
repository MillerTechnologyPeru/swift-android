//
//  NewView.swift
//  swiftapptarget
//
//  Created by Killian Greene on 7/24/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

class NewView: Android.View.View {
    required init(javaObject: jobject?) {
        NSLog("View initialized")
        super.init(javaObject: javaObject)
    }
}
