//
//  DeviceAdapter.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 7/6/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

public class DeviceAdapter: Android.Widget.RecyclerView.Adapter {

    var mainActivity: MainActivity?
    
    func addActivity(mainActivity: MainActivity) {
        self.mainActivity = mainActivity
    }
    
    public required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    public override func onCreateViewHolder(parent: Android.View.ViewGroup, viewType: Int?) -> AndroidWidgetRecyclerView.ViewHolder {
        
    }
    
    public override func getItemCount() -> Int {
        
    }
    public override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int) {
        
    }
    
    class DeviceViewHolder: Android.Widget.RecyclerView.ViewHolder {
        
        required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        
    }
}
