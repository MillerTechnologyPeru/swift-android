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
        
        let dialog = AndroidDialog(context: self)
        dialog.requestWindowFeature(featureId: AndroidWindow.FEATURE_NO_TITLE)
        dialog.setContentView(view: view)
        dialog.show()
        
        let layoutParams = AndroidWindowManagerLayoutParams()
        
        guard let dialogLayuotparams = dialog.window.attributes
            else { return }
        
        layoutParams.copyFrom(dialogLayuotparams)
        
        layoutParams.width = AndroidWindowManagerLayoutParams.MATCH_PARENT
        layoutParams.height = AndroidWindowManagerLayoutParams.MATCH_PARENT
        
        dialog.window.attributes = layoutParams
        
        let rvItemsId = getIdentifier(name: "rvItems", type: "id")
        let tvFolderNameId = getIdentifier(name: "tvFolderName", type: "id")
        let ivBackId = getIdentifier(name: "ivBack", type: "id")
        let ivAddFolderId = getIdentifier(name: "ivAddFolder", type: "id")
        
        let tvCurrentFolder = Android.Widget.TextView(casting: view.findViewById(tvFolderNameId)!)
        let rvItems = Android.Widget.RecyclerView(casting: view.findViewById(rvItemsId)!)
        let ivAddFolder = Android.Widget.ImageView(casting: view.findViewById(ivAddFolderId)!)
        let ivBack = Android.Widget.ImageView(casting: view.findViewById(ivBackId)!)
        
        // Files and Folder Name
        
        let adapter = ItemAdapter(activity: self)
        
        adapter.itemClick = { item in
            
            log("path: \(item.path)")
            
            let itemChildren = self.getItemsFromPath(path: item.path)
            
            self.currentFolder = "/\(item.name)/"
            self.navigation.append(Navigation(folderName: self.currentFolder, path: item.path, files: itemChildren))
            
            tvCurrentFolder?.text = self.currentFolder
            adapter.addItems(items: itemChildren)
            
            ivBack?.setVisibility(visibility: AndroidView.AndroidViewVisibility.visible.rawValue)
            ivAddFolder?.setVisibility(visibility: AndroidView.AndroidViewVisibility.visible.rawValue)
        }
        
        rvItems?.adapter = adapter
        
        let storages = getStorages()
        navigation.append(Navigation(folderName: currentFolder, path: "/", files: storages))
        
        tvCurrentFolder?.text = currentFolder
        adapter.addItems(items: storages)
        
        // Back Button
        
        ivBack?.setVisibility(visibility: AndroidView.AndroidViewVisibility.invisible.rawValue)
        
        ivBack?.setOnClickListener {
            
            guard self.navigation.count > 1
                else {  return }
            
            self.navigation.removeLast()
            
            if self.navigation.count == 1 {
                
                ivBack?.setVisibility(visibility: AndroidView.AndroidViewVisibility.invisible.rawValue)
                ivAddFolder?.setVisibility(visibility: AndroidView.AndroidViewVisibility.invisible.rawValue)
            }
            
            let navLastFolder = self.navigation.last
            
            guard let lastFolder = navLastFolder
                else { return }
            
            self.currentFolder = lastFolder.folderName
            tvCurrentFolder?.text = self.currentFolder
            adapter.addItems(items: lastFolder.files)
        }
        
        // New Folder Button
        
        ivAddFolder?.setVisibility(visibility: AndroidView.AndroidViewVisibility.invisible.rawValue)
        
        ivAddFolder?.setOnClickListener {
            
            let density = self.getDensity()
            
            let dp3 = Int(3 * density)
            let dp24 = Int(24 * density)
            
            let llParams = AndroidLinearLayoutLayoutParams(width: AndroidLinearLayoutLayoutParams.MATCH_PARENT, height: AndroidLinearLayoutLayoutParams.WRAP_CONTENT)
            
            let linearLayout = AndroidLinearLayout.init(context: self)
            linearLayout.layoutParams = llParams
            linearLayout.setPadding(left: dp24, top: dp3, right: dp24, bottom: dp3)
            linearLayout.orientation = AndroidLinearLayout.VERTICAL
            
            let editTextLayoutParams = AndroidLinearLayoutLayoutParams(width: AndroidLinearLayoutLayoutParams.MATCH_PARENT, height: AndroidLinearLayoutLayoutParams.WRAP_CONTENT)
            editTextLayoutParams.setMargins(left: 0, top: 0, right: 0, bottom: 0)
            
            let editText = AndroidEditText(context: self)
            editText.layoutParams = editTextLayoutParams
            editText.hint = "Enter name"
            
            linearLayout.addView(editText)
            
            let alertDialog = AndroidAlertDialog.Builder(context: self)
                .setTitle(title: "New Folder")
                .setView(view: linearLayout)
                .setNegativeButton(text: "Cancel", {dialog,_ in
                    
                    dialog?.dismiss()
                })
                .setPositiveButton(text: "Ok", { dialog,_ in
                    
                    guard let newFolderName = editText.getText()?.toString(), !newFolderName.isEmpty  else {
                        AndroidToast.makeText(context: self, text: "Folder Name is required", duration: AndroidToast.Dutation.short).show()
                        return
                    }
                    
                    guard var currentNavigation = self.navigation.last else {
                        AndroidToast.makeText(context: self, text: "Couldn't create the folder", duration: AndroidToast.Dutation.short).show()
                        return
                    }
                    
                    let currentFile = JavaFile(pathname: currentNavigation.path)
                    
                    if currentFile.isDirectory() {
                        
                        if JavaFile(pathname: "\(currentNavigation.path)/\(newFolderName)").mkdir() {
                            
                            let itemChildren = self.getItemsFromPath(path: currentNavigation.path)
                            
                            currentNavigation.updateFiles(newFiles: itemChildren)
                            self.navigation[self.navigation.count-1] = currentNavigation
    
                            adapter.addItems(items: itemChildren)
                        } else {
                            
                            AndroidToast.makeText(context: self, text: "Couldn't create the folder", duration: AndroidToast.Dutation.short).show()
                        }
                    }
                    
                    dialog?.dismiss()
                })
                .create()
            
            alertDialog.show()
        }
    }
    
    private var currentFolder = "Storages/"
    
    private var navigation = [Navigation]()
    
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
    
    private func getItemsFromPath(path: String) -> [Item] {
        
        let selectedFile = JavaFile.init(pathname: path)
        
        let children = selectedFile.listFiles()
        
        guard let files = children else {
            
            AndroidToast.makeText(context: self, text: "It does'nt content any file.", duration: AndroidToast.Dutation.short).show()
            return []
        }
        
        var itemChildren: [Item] = [Item]()
        
        files.forEach { file in
            
            let type = file.isDirectory() ? ItemType.Folder : ItemType.File
            itemChildren.append(Item.init(type: type, path: file.getPath(), name: file.getName()))
        }
        
        return itemChildren
    }
}

public enum ItemType: Int {
    case Storage
    case Folder
    case File
}

public struct Navigation {
    
    public let folderName: String
    public let path: String
    public var files: [Item]
    
    mutating func updateFiles( newFiles: [Item] ) {
        self.files = newFiles
    }
}

public struct Item {
    
    public let type: ItemType
    public let path: String
    public let name: String
}

class ItemAdapter: Android.Widget.RecyclerView.Adapter {
    
    private var activity: SwiftSupportAppCompatActivity?
    private var items = [Item]()
    public var itemClick: ((Item) -> ())?
    
    public required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    convenience init(activity: SwiftSupportAppCompatActivity) {
        
        log("\(type(of: self)) \(#function)")
        
        self.init(javaObject: nil)
        bindNewJavaObject()
        
        self.activity = activity
    }
    
    public func addItems(items: [Item]){
        
        self.items.removeAll()
        
        self.items = items
        
        notifyDataSetChanged()
    }
    
    override func getItemCount() -> Int {
        return items.count
    }
    
    override func onCreateViewHolder(parent: Android.View.ViewGroup, viewType: Int?) -> AndroidWidgetRecyclerView.ViewHolder {
        
        NSLog("\(type(of: self)) \(#function)")
        
        let itemViewResource = activity?.getIdentifier(name: "file_manager_layout_item", type: "layout")
        
        let itemView = Android.View.LayoutInflater.from(context: parent.context!).inflate(resource: Android.R.Layout(rawValue: itemViewResource!), root: parent, attachToRoot: false)
        
        return ItemViewHolder(itemView: itemView, activity: activity!)
    }
    
    override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int) {
        
        let itemViewHolder = holder as! ItemViewHolder
        
        let item = items[position]
        
        itemViewHolder.bind(item)
        
        itemViewHolder.tvItemName?.setOnClickListener {
            self.itemClick?(item)
        }
    }
    
    class ItemViewHolder: Android.Widget.RecyclerView.ViewHolder {
        
        private var activity: SwiftSupportAppCompatActivity?
        fileprivate var itemView: Android.View.View?
        fileprivate var tvItemName: Android.Widget.TextView?
        fileprivate var cbSelect: Android.Widget.CheckBox?
        fileprivate var ivItemType: Android.Widget.ImageView?
        
        convenience init(itemView: Android.View.View, activity: SwiftSupportAppCompatActivity) {
            NSLog("\(type(of: self)) \(#function)")
            
            self.init(javaObject: nil)
            
            bindNewJavaObject(itemView: itemView)
            
            let cbSelectId = activity.getIdentifier(name: "cbSelect", type: "id")
            let ivItemTypeId = activity.getIdentifier(name: "ivItemType", type: "id")
            let tvItemNameId = activity.getIdentifier(name: "tvItemName", type: "id")
            
            guard let cbSelectObject = itemView.findViewById(cbSelectId)
                else { fatalError("No view for \(cbSelectId)") }
            
            guard let ivItemTypeObject = itemView.findViewById(ivItemTypeId)
                else { fatalError("No view for \(ivItemTypeId)") }
            
            guard let tvItemNameObject = itemView.findViewById(tvItemNameId)
                else { fatalError("No view for \(tvItemNameId)") }
            
            self.itemView = itemView
            self.activity = activity
            
            self.cbSelect = Android.Widget.CheckBox(casting: cbSelectObject)
            self.ivItemType = Android.Widget.ImageView(casting: ivItemTypeObject)
            self.tvItemName = Android.Widget.TextView(casting: tvItemNameObject)
        }
        
        public required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        deinit {
            log("\(type(of: self)) \(#function)")
        }
        
        public func bind(_ item: Item) {
            
            self.tvItemName?.text = item.name
            
            var _imageId: Int? = 0
            
            switch item.type {
            case .Storage:
                self.cbSelect?.setVisibility(visibility: AndroidView.AndroidViewVisibility.gone.rawValue)
                _imageId = activity?.getIdentifier(name: "ic_sd_storage", type: "drawable")
            case .Folder:
                self.cbSelect?.setVisibility(visibility: AndroidView.AndroidViewVisibility.visible.rawValue)
                _imageId = activity?.getIdentifier(name: "ic_folder", type: "drawable")
            case .File:
                self.cbSelect?.setVisibility(visibility: AndroidView.AndroidViewVisibility.visible.rawValue)
                _imageId = activity?.getIdentifier(name: "ic_file", type: "drawable")
            }
            
            guard let imageId = _imageId
                else { return }
            
            if imageId != 0 {
                
                self.ivItemType?.setImageResource(imageId)
            }
        }
    }
    
    deinit {
        log("\(type(of: self)) \(#function)")
    }
}
