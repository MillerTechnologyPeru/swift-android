//
//  FileManagerActivity.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 11/9/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

 /// Needs to be implemented by app.
 @_silgen_name("SwiftAndroidMainActivity")
 public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
 NSLog("FileManagerActivity bind \(#function)")
 return FileManagerActivity.self
 }

// Like AppDelegate in iOS
final class FileManagerActivity: SwiftSupportAppCompatActivity {
    
    private let REQUEST_WRITE_STORAGE_PERMISSION = 1001
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        let metrics = AndroidDisplayMetrics()
        windowManager?.defaultDisplay?.getMetrics(outMetrics: metrics)
        
        let rootFrameLayout = AndroidWidgetFrameLayout.init(context: self)
        rootFrameLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)

        let buttonWidth = Int(150 * metrics.density)
        let buttonHeight = Int(80 * metrics.density)
        
        let layoutparams = AndroidFrameLayoutLayoutParams(width: buttonWidth, height: buttonHeight)
        
        let margin = Int(16 * metrics.density)
        
        layoutparams.setMargins(left: margin, top: margin, right: margin, bottom: margin)
        
        let button1 = AndroidButton.init(context: self)
        button1.layoutParams = layoutparams
        button1.text = "Open File Explorer"
        
        rootFrameLayout.addView(button1)
        
        setContentView(view: rootFrameLayout)
        
        button1.setOnClickListener {
            
            self.checkPermission()
        }
    }
    
    private func checkPermission(){
        
        if(Android.OS.Build.Version.Sdk.sdkInt.rawValue >= Android.OS.Build.VersionCodes.M
            && checkSelfPermission(permission: Android.ManifestPermission.writeExternalStorage.rawValue) != Android.Content.PM.PackageManager.Permission.granted.rawValue) {
            
            log("\(type(of: self)) \(#function) request permission")
            
            let permissions = [Android.ManifestPermission.writeExternalStorage.rawValue]
            
            requestPermissions(permissions: permissions, requestCode: REQUEST_WRITE_STORAGE_PERMISSION)
        } else {
            
            log("\(type(of: self)) \(#function) dont request permission")
            showFileExplorer()
        }
    }
    
    override func onActivityResult(requestCode: Int, resultCode: Int, data: Android.Content.Intent?) {
        
        log("\(type(of: self)) \(#function) - requestCode = \(requestCode) - resultCode = \(resultCode)")
        if(resultCode == REQUEST_WRITE_STORAGE_PERMISSION && resultCode == SwiftSupportAppCompatActivity.RESULT_OK){
            
            showFileExplorer()
        }
    }
    
    override func onRequestPermissionsResult(requestCode: Int, permissions: [String], grantResults: [Int]) {
        
        log("\(type(of: self)) \(#function)")
        
        if(requestCode == REQUEST_WRITE_STORAGE_PERMISSION){
            
            if(grantResults[0] == Android.Content.PM.PackageManager.Permission.granted.rawValue){
                
                showFileExplorer()
            }else{
                log(" \(type(of: self)) \(#function) Write in Storage Permission is required")
                AndroidToast.makeText(context: self, text: "Write in Storage Permission is required", duration: AndroidToast.Dutation.short).show()
            }
        }
    }
    
    private func showFileExplorer() {
        
        log("\(type(of: self)) \(#function) show ")
    
        guard let resources = resources
            else { return }
        
        let themeResId = resources.getIdentifier(name: "Theme_Black_NoTitleBar_Fullscreen", type: "style", defPackage: "android")
        
        let alertDialog = AndroidAlertDialog.Builder.init(context: self, themeResId: themeResId)
        alertDialog.show()
    }
}
