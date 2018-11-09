//
//  PeriperalAdapter.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 8/10/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android
import AndroidBluetooth
import GATT
/*
class PeripheralAdapter: Android.Widget.RecyclerView.Adapter {
    
    typealias Device = ScanData<Peripheral, AdvertisementData>
    
    private var mainActivity: MainActivity?
    private var peripherals = [Device]()
    public var onItemClick: ((Device) -> ())?
    
    public required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    convenience init(mainActivity: MainActivity) {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.init(javaObject: nil)
        bindNewJavaObject()
        
        self.mainActivity = mainActivity
    }
    
    func addPeripheral(_ newPeripheral: Device) {
        
        NSLog("\(type(of: self)) \(#function) \(newPeripheral)")
        
        var alreadyExists = false
        var indextExistingItem = -1
        
        for (index, peripheralItem) in peripherals.enumerated() {
            NSLog("Item \(index): \(peripheralItem)")
            
            if (peripheralItem.peripheral.identifier == newPeripheral.peripheral.identifier) {
                alreadyExists = true
                indextExistingItem = index
                break
            }
        }
        
        if(!alreadyExists){
            peripherals.append(newPeripheral)
            notifyItemInserted(position: peripherals.count-1)
        } /*else {
            peripherals[indextExistingItem] = newPeripheral
            notifyItemChanged(position: indextExistingItem)
        }*/
    }
    
    public override func onCreateViewHolder(parent: Android.View.ViewGroup, viewType: Int?) -> AndroidWidgetRecyclerView.ViewHolder {
        NSLog("\(type(of: self)) \(#function)")
        
        let itemViewResource = mainActivity?.getIdentifier(name: "activity_devices_item", type: "layout")
        
        let itemView = Android.View.LayoutInflater.from(context: parent.context!).inflate(resource: Android.R.Layout(rawValue: itemViewResource!), root: parent, attachToRoot: false)
        
        return PeripheralViewHolder(itemView: itemView, mainActivity: mainActivity!)
    }
    
    public override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int) {
        let peripheralViewHolder = holder as! PeripheralViewHolder
        
        let peripheralItem = peripherals[position]
        
        peripheralViewHolder.bind(peripheralItem)
        
        peripheralViewHolder.itemView?.setOnClickListener{
            guard let onClick = self.onItemClick else {
                return
            }
            
            onClick(peripheralItem)
        }
    }
    /*
    public override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int, payloads: [JavaObject]) {
        
        let peripheralViewHolder = holder as! PeripheralViewHolder
        
        let peripheralItem = peripherals[position]
        
        peripheralViewHolder.bind(peripheralItem)
        
        peripheralViewHolder.itemView?.setOnClickListener{
            guard let onClick = self.onItemClick else {
                return
            }
            
            onClick(peripheralItem)
        }
    }*/
    
    public override func getItemCount() -> Int {
        return peripherals.count
    }
    
    class PeripheralViewHolder: Android.Widget.RecyclerView.ViewHolder {
        
        typealias Device = ScanData<Peripheral, AdvertisementData>
        
        fileprivate var tvName: Android.Widget.TextView?
        fileprivate var tvAddress: Android.Widget.TextView?
        fileprivate var tvRssi: Android.Widget.TextView?
        fileprivate var itemView: Android.View.View?
        
        convenience init(itemView: Android.View.View, mainActivity: MainActivity) {
            NSLog("\(type(of: self)) \(#function)")
            
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
            
            self.itemView = itemView
            self.tvName = Android.Widget.TextView(casting: tvNameObject)
            self.tvAddress = Android.Widget.TextView(casting: tvAddressObject)
            self.tvRssi = Android.Widget.TextView(casting: tvRssiObject)
            
            //let onclick = OnClickItemListener(mainActivity: mainActivity)
            
            //itemView.setOnClickListener(l: onclick)
        }
        
        required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        public func bind(_ device: Device) {
            
            tvName?.text = device.peripheral.identifier.rawValue
            tvAddress?.text = device.advertisementData.localName ?? ""
            tvRssi?.text = "\(device.rssi)"
        }
        
        deinit {
            NSLog("\(type(of: self)) \(#function)")
        }
    }
    
    deinit {
        NSLog("\(type(of: self)) \(#function)")
    }
}*/
