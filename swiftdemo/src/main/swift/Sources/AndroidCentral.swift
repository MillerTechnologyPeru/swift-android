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

class AndroidCentral: CentralProtocol {

    var log: ((String) -> ())?
    
    //I created my own peripheral because I got `Type alias 'Peripheral' references itself`
    typealias Peripheral = AndroidPeripheral
    
    typealias Advertisement = AndroidAdvertisementData
    
    private let bluetoothAdapter = Android.Bluetooth.Adapter.default
    
    func scan(duration: TimeInterval, filterDuplicates: Bool) throws -> [ScanData<AndroidCentral.Peripheral, AndroidCentral.Advertisement>] {
        
        let filters = [Android.Bluetooth.LE.ScanSettings]()
        
        let scanCallback = ScanCallback()
        
        bluetoothAdapter?.lowEnergyScanner?.startScan(callback: scanCallback)
        
        fatalError("not implemented")
    }
    
    func scan(filterDuplicates: Bool, shouldContinueScanning: () -> (Bool), foundDevice: @escaping (ScanData<AndroidPeripheral, AndroidAdvertisementData>) -> ()) throws {
        
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
        
        public func onScanResult(callbackType: Android.Bluetooth.LE.ScanCallbackType, result: Android.Bluetooth.LE.ScanResult) {
            
            let device = result.device
            let rssi = result.rssi
            
            let deviceModel = DeviceModel(device: device, rssi: rssi)
            
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
