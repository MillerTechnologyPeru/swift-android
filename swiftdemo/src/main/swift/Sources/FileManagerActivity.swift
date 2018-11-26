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
        
        let viewId = getIdentifier(name: "file_manager_layout", type: "layout")
        
        let view = AndroidLayoutInflater.from(context: self).inflate(resource: Android.R.Layout(rawValue: viewId), root: nil)
        
        AndroidAlertDialog.Builder.init(context: self)
            .setTitle(title: "Current path")
            .setView(view: view)
            .show()
        
        let storages = getStorages()
        
        navigations[indexNavigation] = storages
    }
    
    private var indexNavigation = 0
    
    private var navigations = [Int: [Item]]()
    
    private func getStorages() -> [Item] {
        
        var storages = [Item]()
        
        if(AndroidEnvironment.getExternalStorageDirectory() != nil){
            
            guard let internalStorage = AndroidEnvironment.getExternalStorageDirectory()
                else { return [] }
            
            let path = internalStorage.getPath()
            
            storages.append(Item(type: ItemType.Storage, path: path, name: "Internal storage"))
        }
        
        let _extStorages = self.getExternalFilesDirs(type: nil)
        
        guard var extStorages = _extStorages else {
            log("Not Ext Storages")
            return storages
        }
        
        extStorages.remove(at: 0)
        
        let secondaryStoragePath = System.getenv("SECONDARY_STORAGE") ?? ""
        
        extStorages.forEach { storage in
            
            let path = storage.getPath().components(separatedBy: "Android/")[0]
            
            if( AndroidEnvironment.isExternalStorageRemovable(path: storage) || secondaryStoragePath.contains(path)){
                
                storages.append(Item(type: ItemType.Storage, path: path, name: "SD Card"))
                log("SD Card: \(path)")
            }
        }
        
        return storages
    }
}

public enum ItemType: Int {
    case Storage
    case Folder
    case File
}

public struct Item {
    
    public let type: ItemType
    public let path: String
    public let name: String
}
