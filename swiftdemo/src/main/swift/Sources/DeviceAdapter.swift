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

class DeviceAdapter: Android.Widget.RecyclerView.Adapter {

    private var mainActivity: MainActivity?
    private var devices: [DeviceModel] = [DeviceModel]()
    
    convenience init(mainActivity: MainActivity) {
        
        self.init(javaObject: nil)
        bindNewJavaObject()
        
        self.mainActivity = mainActivity
    }
    
    func addDevice(newDevice: DeviceModel){
        
        var alreadyExists = false
        var indextExistingItem = -1
        
        for (index, deviceItem) in devices.enumerated() {
            print("Item \(index): \(deviceItem)")
            
            if(deviceItem.device?.getAddress() == newDevice.device?.getAddress()){
                alreadyExists = true
                indextExistingItem = index
                break
            }
        }
        
        if(!alreadyExists){
            devices.append(newDevice)
            notifyItemInserted(position: devices.count-1)
        } else {
            devices[indextExistingItem] = newDevice
            notifyItemChanged(position: indextExistingItem)
        }
    }
    
    public required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    public override func onCreateViewHolder(parent: Android.View.ViewGroup, viewType: Int?) -> AndroidWidgetRecyclerView.ViewHolder {
        
        let itemViewResource = mainActivity?.getIdentifier(name: "activity_devices_item", type: "layout")

        let itemView = Android.View.LayoutInflater.from(context: parent.context).inflate(resource: Android.R.Layout(rawValue: itemViewResource!), root: parent, attachToRoot: false)
        
        return DeviceViewHolder(itemView: itemView, mainActivity: mainActivity!)
    }
    
    public override func getItemCount() -> Int {
        return devices.count
    }
    
    public override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int) {
        NSLog("\(type(of: self)) \(#function)")
        
        let deviceViewHolder = DeviceViewHolder(casting: holder)
        
        let deviceModelItem = devices[position]
    
        deviceViewHolder?.bind(deviceModel: deviceModelItem)
    }
    
    class DeviceViewHolder: Android.Widget.RecyclerView.ViewHolder {
        
        fileprivate var tvName: Android.Widget.TextView?
        fileprivate var tvAddress: Android.Widget.TextView?
        fileprivate var tvRssi: Android.Widget.TextView?
        
        convenience init(itemView: Android.View.View, mainActivity: MainActivity) {
            NSLog("\(type(of: self)) \(#function) 1")
            
            self.init(javaObject: nil)
            
            super.bindNewJavaObject(itemView: itemView)
 
            let tvNameId = mainActivity.getIdentifier(name: "tvName", type: "id")
            let tvAddressId = mainActivity.getIdentifier(name: "tvAddress", type: "id")
            let tvRssiId = mainActivity.getIdentifier(name: "tvRssi", type: "id")
NSLog("\(type(of: self)) \(#function) 2")
            guard let tvNameObject = itemView.findViewById(tvNameId)
                else { fatalError("No view for \(tvNameId)") }
            
            guard let tvAddressObject = itemView.findViewById(tvAddressId)
                else { fatalError("No view for \(tvAddressId)") }
            
            guard let tvRssiObject = itemView.findViewById(tvRssiId)
                else { fatalError("No view for \(tvRssiId)") }
            NSLog("\(type(of: self)) \(#function) 3")
            tvName = Android.Widget.TextView(casting: tvNameObject)
            tvAddress = Android.Widget.TextView(casting: tvAddressObject)
            tvRssi = Android.Widget.TextView(casting: tvRssiObject)
            NSLog("\(type(of: self)) \(#function) 4")
        }
        
        required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        public func bind(deviceModel: DeviceModel) {

            tvName!.text = "Hello"
            
            guard let device = deviceModel.device
                else { fatalError("No device") }

            tvName?.text = "Hello"
            tvAddress?.text = device.getAddress()
            tvRssi?.text = "\(deviceModel.rssi!)"
        }
    }
}
