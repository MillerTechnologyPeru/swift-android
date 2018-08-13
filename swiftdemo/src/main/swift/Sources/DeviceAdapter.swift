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
    
    public required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    convenience init(mainActivity: MainActivity) {
        
        NSLog("\(type(of: self)) \(#function)")
        
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
    
    public override func onCreateViewHolder(parent: Android.View.ViewGroup, viewType: Int?) -> AndroidWidgetRecyclerView.ViewHolder {
        NSLog("\(type(of: self)) \(#function)")
        
        let itemViewResource = mainActivity?.getIdentifier(name: "activity_devices_item", type: "layout")
        
        let itemView = Android.View.LayoutInflater.from(context: parent.context!).inflate(resource: Android.R.Layout(rawValue: itemViewResource!), root: parent, attachToRoot: false)
        
        return DeviceViewHolder(itemView: itemView, mainActivity: mainActivity!)
    }
    
    public override func getItemCount() -> Int {
        return devices.count
    }
    
    public override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int) {
        NSLog("\(type(of: self)) \(#function)")
        
        let deviceViewHolder = holder as! DeviceViewHolder
        
        let deviceModelItem = devices[position]
        
        deviceViewHolder.bind(deviceModel: deviceModelItem)
    }
    
    /*
    class OnClickItemListener: Android.View.View.OnClickListener {
        
        private var mainActivity: MainActivity?
        
        convenience init(mainActivity: MainActivity) {
            
            self.init(javaObject: nil)
            
            bindNewJavaObject()
            
            self.mainActivity = mainActivity
        }
        
        required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        override func onClick() {
            NSLog("\(type(of: self)) \(#function) HELLO!!")
            
            //mainActivity?.androidCentral.connect(to: <#T##AndroidPeripheral#>, timeout: <#T##TimeInterval#>)
            let deviceDetailDialogFragment = DeviceDetailDialogFragment()
            deviceDetailDialogFragment.show(manager: (mainActivity?.supportFragmentManager)!, tag: "")
        }
    }
    */
    
    class DeviceViewHolder: Android.Widget.RecyclerView.ViewHolder {
        
        fileprivate var tvName: Android.Widget.TextView?
        fileprivate var tvAddress: Android.Widget.TextView?
        fileprivate var tvRssi: Android.Widget.TextView?
        
        convenience init(itemView: Android.View.View, mainActivity: MainActivity) {
            NSLog("\(type(of: self)) \(#function) 1")
            
            self.init(javaObject: nil)
            
            bindNewJavaObject(itemView: itemView)
 
            let tvNameId = mainActivity.getIdentifier(name: "tvName", type: "id")
            let tvAddressId = mainActivity.getIdentifier(name: "tvAddress", type: "id")
            let tvRssiId = mainActivity.getIdentifier(name: "tvRssi", type: "id")

            guard let tvNameObject = itemView.findViewById(tvNameId)
                else { fatalError("No view for \(tvNameId)") }
            
            guard let tvAddressObject = itemView.findViewById(tvAddressId)
                else { fatalError("No view for \(tvAddressId)") }
            
            guard let tvRssiObject = itemView.findViewById(tvRssiId)
                else { fatalError("No view for \(tvRssiId)") }
            
            self.tvName = Android.Widget.TextView(casting: tvNameObject)
            self.tvAddress = Android.Widget.TextView(casting: tvAddressObject)
            self.tvRssi = Android.Widget.TextView(casting: tvRssiObject)
            
            //let onclick = OnClickItemListener(mainActivity: mainActivity)
            
            //itemView.setOnClickListener(l: onclick)
        }
        
        required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        public func bind(deviceModel: DeviceModel) {

            //tvName!.text = "Hello"
            
            guard let device = deviceModel.device
                else { fatalError("No device") }
            
            tvName?.text = device.getName() ?? "No Name"
            tvAddress?.text = device.getAddress()
            tvRssi?.text = "\(deviceModel.rssi!)"
        }
        
        deinit {
            NSLog("\(type(of: self)) \(#function)")
        }
    }
    
    deinit {
        NSLog("\(type(of: self)) \(#function)")
    }
}
