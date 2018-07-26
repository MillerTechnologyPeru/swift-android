//
//  AndroidCentral.swift
//  Android
//
//  Created by Marco Estrella on 7/24/18.
//

import Foundation
import GATT
import Bluetooth

//#if os(android)

import Android
import java_swift

enum AndroidCentralError: Error {
    case BluetoothDisabled
    case ScanningError
}

class AndroidCentral: CentralProtocol {

    init() {
        NSLog("\(type(of: self)) \(#function)")
    }
    
    var log: ((String) -> ())?
    
    //I created my own peripheral because I got `Type alias 'Peripheral' references itself`
    typealias Peripheral = AndroidPeripheral
    
    typealias Advertisement = AndroidAdvertisementData
    
    private let bluetoothAdapter = Android.Bluetooth.Adapter.default
    
    private var gattCallback: Android.Bluetooth.GattCallback?
    
    func scan(filterDuplicates: Bool, shouldContinueScanning: () -> (Bool), foundDevice: @escaping (ScanData<AndroidPeripheral, AndroidAdvertisementData>) -> ()) throws {
        
        NSLog("\(type(of: self)) \(#function)")
        
        guard bluetoothAdapter!.isEnabled()
            else { throw AndroidCentralError.BluetoothDisabled }

        self.log?("Scanning...")
        
        //let filters = [Android.Bluetooth.LE.ScanSettings]()
        
        let scanCallback = ScanCallback(filterDuplicates, foundDevice)

        bluetoothAdapter?.lowEnergyScanner?.startScan(callback: scanCallback)
        
        // sleep until scan finishes
        DispatchQueue.global(qos: .background).async {
            usleep(useconds_t(10*1000000))
            
            NSLog("Stopping the scanning")
            self.bluetoothAdapter?.lowEnergyScanner?.stopScan(callback: scanCallback)
            /*DispatchQueue.main.async {
                
            }*/
        }
    }
    
    func connect(to peripheral: AndroidPeripheral, timeout: TimeInterval) throws {
        
        NSLog("\(type(of: self)) \(#function)")
        
        guard bluetoothAdapter!.isEnabled()
            else { throw AndroidCentralError.BluetoothDisabled }
        
        gattCallback = GattCallback(peripheral: peripheral)
        
        peripheral.gatt = peripheral.device.connectGatt(context: SwiftDemoApplication.context!, autoConnect: false, callback: gattCallback!)
        
    }
    
    func disconnect(peripheral: AndroidPeripheral) {
        NSLog("\(type(of: self)) \(#function)")
        
        peripheral.gatt?.disconnect()
    }
    
    func disconnectAll() {
        NSLog("\(type(of: self)) \(#function)")
        
    }
    
    func discoverServices(_ services: [BluetoothUUID], for peripheral: AndroidPeripheral, timeout: TimeInterval) throws -> [Service<AndroidPeripheral>] {
        NSLog("\(type(of: self)) \(#function)")
        
        fatalError("not implemented")
    }
    
    func discoverCharacteristics(_ characteristics: [BluetoothUUID], for service: Service<AndroidPeripheral>, timeout: TimeInterval) throws -> [Characteristic<AndroidPeripheral>] {
        NSLog("\(type(of: self)) \(#function)")
        
        fatalError("not implemented")
    }
    
    func readValue(for characteristic: Characteristic<AndroidPeripheral>, timeout: TimeInterval) throws -> Data {
        NSLog("\(type(of: self)) \(#function)")
        
        fatalError("not implemented")
    }
    
    func writeValue(_ data: Data, for characteristic: Characteristic<AndroidPeripheral>, withResponse: Bool, timeout: TimeInterval) throws {
        NSLog("\(type(of: self)) \(#function)")
        
    }
    
    func notify(_ notification: ((Data) -> ())?, for characteristic: Characteristic<AndroidPeripheral>, timeout: TimeInterval) throws {
        NSLog("\(type(of: self)) \(#function)")
        
    }
    
    //MARK: Android
    
    private class ScanCallback: Android.Bluetooth.LE.ScanCallback {
        
        private var filterDuplicates: Bool?
        private var foundDevice: ((ScanData<AndroidPeripheral, AndroidAdvertisementData>) -> ())?
        
        public required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        convenience init(_ filterDuplicates: Bool, _ foundDevice: @escaping (ScanData<AndroidPeripheral, AndroidAdvertisementData>) -> ()) {

            self.init(javaObject: nil)
            bindNewJavaObject()
            
            NSLog("\(type(of: self)) \(#function)")
            self.filterDuplicates = filterDuplicates
            self.foundDevice = foundDevice
        }
        
        public override func onScanResult(callbackType: Android.Bluetooth.LE.ScanCallbackType, result: Android.Bluetooth.LE.ScanResult) {
            NSLog("\(type(of: self)) \(#function)")
            
            if(filterDuplicates!){
                
                
            }else{
                
                let peripheral = AndroidPeripheral(identifier: result.device.address, device: result.device)
                
                let advertisement = AndroidAdvertisementData.init(localName: result.device.getName(), manufacturerData: nil, isConnectable: true)
                
                let scandata = ScanData<AndroidPeripheral, AndroidAdvertisementData>(peripheral: peripheral, rssi: Double(result.rssi), advertisementData: advertisement);
                
                foundDevice!(scandata)
            }
        }
        
        public override func onBatchScanResults(results: [Android.Bluetooth.LE.ScanResult]) {
            
            NSLog("\(type(of: self)): \(#function)")
        }
        
        public override func onScanFailed(error: AndroidBluetoothLowEnergyScanCallback.Error) {
 
            NSLog("\(type(of: self)): \(#function)")
        }
    }
    
    public class GattCallback: Android.Bluetooth.GattCallback {

        private var peripheral: AndroidPeripheral?
        
        convenience init(peripheral: AndroidPeripheral) {
            self.init(javaObject: nil)
            bindNewJavaObject()
            
            self.peripheral = peripheral
        }
        
        public required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        public func onConnectionStateChange(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status, newState: AndroidBluetoothDevice.State) {
            NSLog("\(type(of: self)): \(#function)")
            
            NSLog("Status: \(status) - newState = \(newState)")
            
            if(status.rawValue != AndroidBluetoothGatt.Status.success.rawValue){
                peripheral?.gatt = nil
                return
            }
            
            if(newState.rawValue == AndroidBluetoothDevice.State.connected.rawValue){
                
                peripheral?.gatt = gatt
                NSLog("GATT Connected")
            } else if(newState.rawValue == AndroidBluetoothDevice.State.disconnected.rawValue){
                peripheral?.gatt = nil
                NSLog("GATT Disconnected")
            }
        }
        
        public func onServicesDiscovered(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
            NSLog("Status: \(status)")
            
            if(status.rawValue != AndroidBluetoothGatt.Status.success.rawValue){
                //Show error message on Android
                NSLog("Error: \(status)")
                return
            }
            
            peripheral?.gatt = gatt
            /*
             gatt.getServices()?.withJavaObject{
             self.responder.showServices(services: JavaObject(javaObject: $0))
             }*/
            
            NSLog("Size: \(String(describing: gatt.getServices()?.size()))")
        }
        
        public func onCharacteristicChanged(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
        
        public func onCharacteristicRead(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
        
        public func onCharacteristicWrite(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
        
        public func onDescriptorRead(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
        
        public func onDescriptorWrite(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
        
        public func onMtuChanged(gatt: Android.Bluetooth.Gatt, mtu: Int, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
        
        public func onPhyRead(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
        
        public func onPhyUpdate(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
        
        public func onReadRemoteRssi(gatt: Android.Bluetooth.Gatt, rssi: Int, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
        
        public func onReliableWriteCompleted(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
            NSLog("\(type(of: self)): \(#function)")
            
        }
    }
    
}

//#endif
