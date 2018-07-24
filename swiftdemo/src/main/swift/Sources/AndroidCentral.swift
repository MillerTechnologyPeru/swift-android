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

enum AndroidCentralError: Error {
    case BluetoothDisabled
    case ScanningError
}

class AndroidCentral: CentralProtocol {

    var log: ((String) -> ())?
    
    //I created my own peripheral because I got `Type alias 'Peripheral' references itself`
    typealias Peripheral = AndroidPeripheral
    
    typealias Advertisement = AndroidAdvertisementData
    
    private let bluetoothAdapter = Android.Bluetooth.Adapter.default
    
    func scan(filterDuplicates: Bool, shouldContinueScanning: () -> (Bool), foundDevice: @escaping (ScanData<AndroidPeripheral, AndroidAdvertisementData>) -> ()) throws {
        
        guard bluetoothAdapter!.isEnabled()
            else { throw AndroidCentralError.BluetoothDisabled }
        
        self.log?("Scanning...")
        
        //let filters = [Android.Bluetooth.LE.ScanSettings]()
        
        let scanCallback = ScanCallback(filterDuplicates, foundDevice)
        
        bluetoothAdapter?.lowEnergyScanner?.startScan(callback: scanCallback)
        
        // sleep until scan finishes
        while shouldContinueScanning() { usleep(200) }
        
        bluetoothAdapter?.lowEnergyScanner?.stopScan(callback: scanCallback)
    }
    
    func connect(to peripheral: AndroidPeripheral, timeout: TimeInterval) throws {
        
    }
    
    func disconnect(peripheral: AndroidPeripheral) {
        
    }
    
    func disconnectAll() {
        
    }
    
    func discoverServices(_ services: [BluetoothUUID], for peripheral: AndroidPeripheral, timeout: TimeInterval) throws -> [Service<AndroidPeripheral>] {
        fatalError("not implemented")
    }
    
    func discoverCharacteristics(_ characteristics: [BluetoothUUID], for service: Service<AndroidPeripheral>, timeout: TimeInterval) throws -> [Characteristic<AndroidPeripheral>] {
        fatalError("not implemented")
    }
    
    func readValue(for characteristic: Characteristic<AndroidPeripheral>, timeout: TimeInterval) throws -> Data {
        
        fatalError("not implemented")
    }
    
    func writeValue(_ data: Data, for characteristic: Characteristic<AndroidPeripheral>, withResponse: Bool, timeout: TimeInterval) throws {
        
    }
    
    func notify(_ notification: ((Data) -> ())?, for characteristic: Characteristic<AndroidPeripheral>, timeout: TimeInterval) throws {
        
    }
    
    //MARK: Android
    
    private struct ScanCallback: Android.Bluetooth.LE.ScanCallback {
        
        private let filterDuplicates: Bool
        private let foundDevice: (ScanData<AndroidPeripheral, AndroidAdvertisementData>) -> ()
        
        init(_ filterDuplicates: Bool, _ foundDevice: @escaping (ScanData<AndroidPeripheral, AndroidAdvertisementData>) -> ()) {
            self.filterDuplicates = filterDuplicates
            self.foundDevice = foundDevice
        }
        
        public func onScanResult(callbackType: Android.Bluetooth.LE.ScanCallbackType, result: Android.Bluetooth.LE.ScanResult) {
            NSLog("\(type(of: self)) \(#function) scanning")
            
            if(filterDuplicates){
                
                
            }else{
                
                let peripheral = AndroidPeripheral(identifier: result.device.address)
                
                let advertisement = AndroidAdvertisementData.init(localName: result.device.getName(), manufacturerData: nil, isConnectable: true)
                
                let scandata = ScanData<AndroidPeripheral, AndroidAdvertisementData>(peripheral: peripheral, rssi: Double(result.rssi), advertisementData: advertisement);
                
                foundDevice(scandata)
            }
        }
        
        public func onBatchScanResults(results: [Android.Bluetooth.LE.ScanResult]) {
            
            NSLog("\(type(of: self)): \(#function)")
        }
        
        public func onScanFailed(error: AndroidBluetoothLowEnergyScanCallback.Error) {
            
            NSLog("\(type(of: self)): \(#function)")
            
            NSLog("Scan failed \(error)")
        }
    }
    
    
}

//#endif
