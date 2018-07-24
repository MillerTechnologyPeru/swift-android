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
        
        NSLog("\(type(of: self)) \(#function) 1")
        
        guard bluetoothAdapter!.isEnabled()
            else { throw AndroidCentralError.BluetoothDisabled }
        
        NSLog("\(type(of: self)) \(#function) 2")
        self.log?("Scanning...")
        
        //let filters = [Android.Bluetooth.LE.ScanSettings]()
        
        let scanCallback = ScanCallback(filterDuplicates, foundDevice)
        
        NSLog("\(type(of: self)) \(#function) 3")
        
        bluetoothAdapter?.lowEnergyScanner?.startScan(callback: scanCallback)
        
        NSLog("\(type(of: self)) \(#function) 4")
        
        DispatchQueue.global(qos: .background).async {
            NSLog("background thread log starting")
            usleep(useconds_t(5*1000000))
            NSLog("background thread log finished")
            self.bluetoothAdapter?.lowEnergyScanner?.stopScan(callback: scanCallback)
            /*DispatchQueue.main.async {
                NSLog("main thread log")
                
            }*/
        }
        // sleep until scan finishes
        //while shouldContinueScanning() { usleep(200) }
        
        NSLog("\(type(of: self)) \(#function) 5")
        //FIXME: stop is not working
        
    }
    
    func connect(to peripheral: AndroidPeripheral, timeout: TimeInterval) throws {
        
        gattCallback = GattCallback(peripheral: peripheral)
        
        peripheral.device.connectGatt(context: SwiftDemoApplication.context!, autoConnect: false, callback: gattCallback!)
        fatalError("not implemented")
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
            NSLog("\(type(of: self)) \(#function)")
            self.filterDuplicates = filterDuplicates
            self.foundDevice = foundDevice
        }
        
        public func onScanResult(callbackType: Android.Bluetooth.LE.ScanCallbackType, result: Android.Bluetooth.LE.ScanResult) {
            NSLog("\(type(of: self)) \(#function) scanning")
            
            if(filterDuplicates){
                
                
            }else{
                
                let peripheral = AndroidPeripheral(identifier: result.device.address, device: result.device)
                
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
    
    public class GattCallback: Android.Bluetooth.GattCallback {

        private var peripheral: AndroidPeripheral
        
        init(peripheral: AndroidPeripheral) {
            self.peripheral = peripheral
        }
        
        public func onConnectionStateChange(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status, newState: AndroidBluetoothDevice.State) {
            
            NSLog("Status: \(status) - newState = \(newState)")
            
            if(status.rawValue != AndroidBluetoothGatt.Status.success.rawValue){
                 NSLog("Error: \(status.rawValue)")
                return
            }
            
            if(newState.rawValue == AndroidBluetoothDevice.State.connected.rawValue){
                
                peripheral.gatt = gatt
                NSLog("Got GATT")
            }
        }
        
        public func onServicesDiscovered(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
            
            NSLog("Status: \(status)")
            
            if(status.rawValue != AndroidBluetoothGatt.Status.success.rawValue){
                //Show error message on Android
                NSLog("Error: \(status)")
                return
            }
            
            /*
             gatt.getServices()?.withJavaObject{
             self.responder.showServices(services: JavaObject(javaObject: $0))
             }*/
            
            NSLog("Size: \(String(describing: gatt.getServices()?.size()))")
        }
        
        public func onCharacteristicChanged(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic) {
            
        }
        
        public func onCharacteristicRead(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
            
        }
        
        public func onCharacteristicWrite(gatt: Android.Bluetooth.Gatt, characteristic: Android.Bluetooth.GattCharacteristic, status: AndroidBluetoothGatt.Status) {
            
        }
        
        public func onDescriptorRead(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
            
        }
        
        public func onDescriptorWrite(gatt: Android.Bluetooth.Gatt, descriptor: Android.Bluetooth.GattDescriptor, status: AndroidBluetoothGatt.Status) {
            
        }
        
        public func onMtuChanged(gatt: Android.Bluetooth.Gatt, mtu: Int, status: AndroidBluetoothGatt.Status) {
            
        }
        
        public func onPhyRead(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
            
        }
        
        public func onPhyUpdate(gatt: Android.Bluetooth.Gatt, txPhy: AndroidBluetoothGatt.TxPhy, rxPhy: AndroidBluetoothGatt.RxPhy, status: AndroidBluetoothGatt.Status) {
            
        }
        
        public func onReadRemoteRssi(gatt: Android.Bluetooth.Gatt, rssi: Int, status: AndroidBluetoothGatt.Status) {
            
        }
        
        public func onReliableWriteCompleted(gatt: Android.Bluetooth.Gatt, status: AndroidBluetoothGatt.Status) {
            
        }
    }
    
}

//#endif
