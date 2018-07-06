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
    var devices: [DeviceModel]?
    
    func addActivity(mainActivity: MainActivity) {
        self.mainActivity = mainActivity
    }
    
    func addDeviceList(devices: [DeviceModel]){
        self.devices = devices
    }
    
    public required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    /*
    public override func onCreateViewHolder(parent: Android.View.ViewGroup, viewType: Int?) -> AndroidWidgetRecyclerView.ViewHolder {
        
        let itemViewResource = mainActivity?.getIdentifier(name: "activity_devices_item", type: "layout")
        
        
    }*/
    
    public override func getItemCount() -> Int {
        return devices != nil ? devices!.count : 0
    }
    public override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int) {
        
    }
    
    class DeviceViewHolder: Android.Widget.RecyclerView.ViewHolder {
        
        required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
            
            
        }
        
        
    }
}
