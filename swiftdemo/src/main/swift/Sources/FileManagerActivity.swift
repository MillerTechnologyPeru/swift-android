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

/*
 /// Needs to be implemented by app.
 @_silgen_name("SwiftAndroidMainActivity")
 public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
 NSLog("FileManagerActivity bind \(#function)")
 return FileManagerActivity.self
 }*/

// Like AppDelegate in iOS
final class FileManagerActivity: SwiftSupportAppCompatActivity, AndroidFileManagerDelegate {
    
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
        
        let androidFileManager = AndroidFileManager.init(context: self)
        androidFileManager.delegate = self
        androidFileManager.show()
    }
    
    func fileManagerResult(path: String) {
        
        AndroidToast.makeText(context: self, text: "path: \(path)", duration: AndroidToast.Dutation.short).show()
    }
}
        
        /*
        log("\(type(of: self)) \(#function) show ")
        var selectedFile: Item?
        
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
        let btnCancelId = getIdentifier(name: "btnCancel", type: "id")
        let btnOkId = getIdentifier(name: "btnOk", type: "id")
        
        let tvCurrentFolder = Android.Widget.TextView(casting: view.findViewById(tvFolderNameId)!)
        let rvItems = Android.Widget.RecyclerView(casting: view.findViewById(rvItemsId)!)
        let ivAddFolder = Android.Widget.ImageView(casting: view.findViewById(ivAddFolderId)!)
        let ivBack = Android.Widget.ImageView(casting: view.findViewById(ivBackId)!)
        let btnCancel = Android.Widget.Button(casting: view.findViewById(btnCancelId)!)
        let btnOk = Android.Widget.Button(casting: view.findViewById(btnOkId)!)
        
        // Files and Folder Name
        
        let adapter = ItemAdapter(activity: self)
        
        adapter.checkItem = { isChecked, item in
            
            log("Checkbox checked \(isChecked): \(item.name).")
            
            if isChecked {
                
                selectedFile = item
                btnOk?.text = "SELECT FILE"
            } else {
                
                selectedFile = nil
                btnOk?.text = "SELECT FOLDER"
            }
        }
        
        adapter.itemClick = { item in
            
            log("path: \(item.path)")
            btnOk?.text = "SELECT FOLDER"
            btnOk?.setEnabled(enabled: true)
            
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
        
        currentFolder = "Storages list"
        tvCurrentFolder?.text = currentFolder
        adapter.addItems(items: storages)
        
        // Back Button
        
        ivBack?.setVisibility(visibility: AndroidView.AndroidViewVisibility.invisible.rawValue)
        
        ivBack?.setOnClickListener {
            
            guard self.navigation.count > 1
                else {  return }
            
            self.navigation.removeLast()
            
            let navLastFolder = self.navigation.last
            
            guard let lastFolder = navLastFolder
                else { return }
            
            if self.navigation.count == 1 {
                
                ivBack?.setVisibility(visibility: AndroidView.AndroidViewVisibility.invisible.rawValue)
                ivAddFolder?.setVisibility(visibility: AndroidView.AndroidViewVisibility.invisible.rawValue)
                self.currentFolder = "Storages list"
                
                btnOk?.setEnabled(enabled: false)
                btnOk?.text = "SELECT FOLDER"
            } else {
                self.currentFolder = lastFolder.folderName
            }
            
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
                    
                    guard let currentNavigation = self.navigation.last else {
                        AndroidToast.makeText(context: self, text: "Couldn't create the folder", duration: AndroidToast.Dutation.short).show()
                        return
                    }
                    
                    let currentFile = JavaFile(pathname: currentNavigation.path)
                    
                    if currentFile.isDirectory() {
                        
                        if JavaFile(pathname: "\(currentNavigation.path)/\(newFolderName)").mkdir() {
                            
                            let itemChildren = self.getItemsFromPath(path: currentNavigation.path)
                            
                            currentNavigation.files = itemChildren
    
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
        
        //Buttons
        
        btnCancel?.setOnClickListener {
            
            dialog.dismiss()
        }
        
        btnOk?.setOnClickListener {
            
            let path: String?
            
            if selectedFile != nil {
                
                path = selectedFile?.path
            } else {
                
                path = self.navigation.last?.path
            }
            
            AndroidToast.makeText(context: self, text: "path: \(path!)", duration: AndroidToast.Dutation.short).show()
            
            dialog.dismiss()
        }
    }
    
    private var currentFolder = ""
    
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
        
        itemChildren.sort { (lhs, rhs) in
            
            return rhs.type != ItemType.Folder
        }
        
        return itemChildren
    }*/
/*
public enum ItemType: Int {
    case Storage
    case Folder
    case File
}

public class Navigation {
    
    public let folderName: String
    public let path: String
    public var files: [Item]
    
    init(folderName: String, path: String, files: [Item]) {
        
        self.folderName = folderName
        self.path = path
        self.files = files
    }
}

public class Item {
    
    public let type: ItemType
    public let path: String
    public let name: String
    public var selected: Bool
    
    init(type: ItemType, path: String, name: String) {
        self.type = type
        self.path = path
        self.name = name
        self.selected = false
    }
}

class ItemAdapter: Android.Widget.RecyclerView.Adapter {
    
    private var activity: SwiftSupportAppCompatActivity?
    private var items = [Item]()
    public var itemClick: ((Item) -> ())?
    public var checkItem: ((Bool, Item) -> ())?
    
    private var lastCheckedPosition = -1
    
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
        
        guard let activity = activity
            else { fatalError("Activity is null") }
        
        let cbSelectId = AndroidViewCompat.generateViewId()
        let ivItemTypeId = AndroidViewCompat.generateViewId()
        let tvItemNameId = AndroidViewCompat.generateViewId()
        
        let density = activity.getDensity()
        
        let dp4 = Int(4 * density)
        let dp6 = Int(6 * density)
        
        let llParams = AndroidLinearLayoutLayoutParams(width: AndroidLinearLayoutLayoutParams.MATCH_PARENT, height: AndroidLinearLayoutLayoutParams.WRAP_CONTENT)
        
        let linearLayout = AndroidLinearLayout(context: activity)
        linearLayout.layoutParams = llParams
        linearLayout.setPadding(left: dp4, top: dp4, right: dp4, bottom: dp4)
        linearLayout.orientation = AndroidLinearLayout.HORIZONTAL
        
        let cbSelect = AndroidCheckBox(context: activity)
        cbSelect.setId(cbSelectId)
        cbSelect.layoutParams = AndroidLinearLayoutLayoutParams(width: AndroidLinearLayoutLayoutParams.WRAP_CONTENT, height: AndroidLinearLayoutLayoutParams.WRAP_CONTENT)
        
        let ivItemType = AndroidImageView(context: activity)
        ivItemType.setId(ivItemTypeId)
        let ivItemTypeParams = AndroidLinearLayoutLayoutParams(width: AndroidLinearLayoutLayoutParams.WRAP_CONTENT, height: AndroidLinearLayoutLayoutParams.MATCH_PARENT)
        ivItemTypeParams.marginStart = dp4
        ivItemType.layoutParams = ivItemTypeParams
        
        let tvItemName = AndroidTextView(context: activity)
        tvItemName.setId(tvItemNameId)
        let tvItemNameParams = AndroidLinearLayoutLayoutParams(width: AndroidLinearLayoutLayoutParams.MATCH_PARENT, height: AndroidLinearLayoutLayoutParams.WRAP_CONTENT)
        tvItemNameParams.marginStart = dp6
        tvItemName.layoutParams = tvItemNameParams
        tvItemName.setTextSize(size: 16)
        tvItemName.setMaxLines(maxLines: 1)
        tvItemName.setHorizontallyScrolling(true)
        tvItemName.setEllipsize(where: AndroidTextUtilsTruncateAt.END)
        
        linearLayout.addView(cbSelect)
        linearLayout.addView(ivItemType)
        linearLayout.addView(tvItemName)
        
        return ItemViewHolder(itemView: linearLayout, activity: activity, ids: [cbSelectId, ivItemTypeId, tvItemNameId])
    }
    
    override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int) {
        
        let itemViewHolder = holder as! ItemViewHolder
        
        let item = items[position]
        itemViewHolder.bind(item)
        
        itemViewHolder.cbSelect?.setOnCheckedChangeListener { buttonView, isChecked in
            
            item.selected = isChecked
            self.checkItem?(isChecked, item)
            
            if self.lastCheckedPosition != -1 && self.lastCheckedPosition != position {

                self.items[self.lastCheckedPosition].selected = false
                self.notifyItemChanged(position: self.lastCheckedPosition)
            }
            
            self.lastCheckedPosition = position
        }
        
        if item.type == ItemType.File {
            
            itemViewHolder.tvItemName?.setOnClickListener(nil)
            return
        }
        
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
        
        convenience init(itemView: Android.View.View, activity: SwiftSupportAppCompatActivity, ids: [Int]) {
            NSLog("\(type(of: self)) \(#function)")
            
            self.init(javaObject: nil)
            
            bindNewJavaObject(itemView: itemView)
            
            guard let cbSelectObject = itemView.findViewById(ids[0])
                else { fatalError("No view for cbSelect: \(ids[0])") }
            
            guard let ivItemTypeObject = itemView.findViewById(ids[1])
                else { fatalError("No view for ivItemType: \(ids[1])") }
            
            guard let tvItemNameObject = itemView.findViewById(ids[2])
                else { fatalError("No view for tvItemName: \(ids[2])") }
            
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
                
                self.cbSelect?.setVisibility(visibility: AndroidView.AndroidViewVisibility.gone.rawValue)
                _imageId = activity?.getIdentifier(name: "ic_folder", type: "drawable")
            case .File:
                
                let fileExtension = item.path.split(separator: ".")[1]
                
                if fileExtension == "json" || fileExtension == "climateconfig" {
                    
                    self.cbSelect?.setChecked(item.selected)
                    self.cbSelect?.setVisibility(visibility: AndroidView.AndroidViewVisibility.visible.rawValue)
                } else {
                    
                    self.cbSelect?.setVisibility(visibility: AndroidView.AndroidViewVisibility.gone.rawValue)
                }
                
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
*/
