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

public enum AndroidCentralError: Error {
    
    /// Bluetooth is disabled.
    case bluetoothDisabled
    
    /// Binder IPC failer
    case binderFailure
    
    /// Unexpected null value.
    case nullValue(AnyKeyPath)
}

public final class AndroidCentral: CentralProtocol {
    
    // MARK: - Properties
    
    public var log: ((String) -> ())?
    
    public let hostController: Android.Bluetooth.Adapter
    
    public let context: Android.Content.Context
    
    internal private(set) var internalState = InternalState()
    
    internal lazy var accessQueue: DispatchQueue = DispatchQueue(label: "\(type(of: self)) Access Queue", attributes: [])
    
    // MARK: - Intialization
    
    deinit {
        
        
    }
    
    public init(hostController: Android.Bluetooth.Adapter,
                context: Android.Content.Context) {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.hostController = hostController
        self.context = context
    }
    
    // MARK: - Methods
    
    public func scan(filterDuplicates: Bool = true,
              shouldContinueScanning: () -> (Bool),
              foundDevice: @escaping (ScanData<Peripheral, AdvertisementData>) -> ()) throws {
        
        NSLog("\(type(of: self)) \(#function)")
        
        guard hostController.isEnabled()
            else { throw AndroidCentralError.bluetoothDisabled }
        
        guard let scanner = hostController.lowEnergyScanner
            else { throw AndroidCentralError.nullValue(\Android.Bluetooth.Adapter.lowEnergyScanner) }
        
        self.log?("Scanning...")
        
        let scanCallback = ScanCallback()
        scanCallback.central = self
        
        scanner.startScan(callback: scanCallback)
        
        // wait until finish scanning
        while shouldContinueScanning() { sleep(1) }
        
        scanner.stopScan(callback: scanCallback)
    }
    
    public func connect(to peripheral: Peripheral, timeout: TimeInterval = .gattDefaultTimeout) throws {
        
        NSLog("\(type(of: self)) \(#function)")
        
        guard hostController.isEnabled()
            else { throw AndroidCentralError.bluetoothDisabled }
        
        // store semaphore
        let semaphore = Semaphore(timeout: timeout)
        accessQueue.sync { [unowned self] in self.internalState.connect.semaphore = semaphore }
        defer { accessQueue.sync { [unowned self] in self.internalState.connect.semaphore = nil } }
        
        // attempt to connect (does not timeout)
        try accessQueue.sync { [unowned self] in
            
            guard let cache = self.internalState.cache[peripheral]
                else { throw CentralError.unknownPeripheral }
            
            cache.gatt = cache.device.connectGatt(context: self.context, autoConnect: false, callback: cache.gattCallback)
        }
        
        // throw async error
        do { try semaphore.wait() }
            
        catch CentralError.timeout {
            
            // cancel connection if we timeout
            accessQueue.sync { [unowned self] in
                
                // Close, disconnect or cancel connection
                self.internalState.cache[peripheral]?.gatt?.disconnect()
            }
            
            throw CentralError.timeout
        }
        
        //NSLog("Connected = device address = \(cache.gatt.getDevice().address)")
        //NSLog("Connected = device name = \(cache.gatt.getDevice().getName())")
    }
    
    public func disconnect(peripheral: Peripheral) {
        
        NSLog("\(type(of: self)) \(#function)")
        
        accessQueue.sync { [unowned self] in
            self.internalState.cache[peripheral]?.gatt?.disconnect()
            self.internalState.cache[peripheral]?.gatt = nil
        }
    }
    
    public func disconnectAll() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        accessQueue.sync { [unowned self] in
            self.internalState.cache.values.forEach {
                $0.gatt?.disconnect()
                $0.gatt = nil
            }
        }
    }
    
    public func discoverServices(_ services: [BluetoothUUID] = [],
                                 for peripheral: Peripheral,
                                 timeout: TimeInterval = .gattDefaultTimeout) throws -> [Service<Peripheral>] {
        
        NSLog("\(type(of: self)) \(#function)")
        
        guard hostController.isEnabled()
            else { throw AndroidCentralError.bluetoothDisabled }
        
        // store semaphore
        let semaphore = Semaphore(timeout: timeout)
        accessQueue.sync { [unowned self] in self.internalState.connect.semaphore = semaphore }
        defer { accessQueue.sync { [unowned self] in self.internalState.connect.semaphore = nil } }
        
        try accessQueue.sync { [unowned self] in
            
            guard let cache = self.internalState.cache[peripheral]
                else { throw CentralError.unknownPeripheral }
            
            guard let gatt = cache.gatt
                else { throw CentralError.disconnected }
            
            guard gatt.discoverServices()
                else { throw AndroidCentralError.binderFailure }
        }
        
        // throw async error
        do { try semaphore.wait() }
        
        // get values from internal state
        return try accessQueue.sync { [unowned self] in
            
            guard let cache = self.internalState.cache[peripheral]
                else { throw CentralError.unknownPeripheral }
            
            return [Service<Peripheral>]() // FIXME: Get values from callback
        }
    }
    
    public func discoverCharacteristics(_ characteristics: [BluetoothUUID] = [],
                                        for service: Service<Peripheral>,
                                        timeout: TimeInterval = .gattDefaultTimeout) throws -> [Characteristic<Peripheral>] {
        NSLog("\(type(of: self)) \(#function)")
        
        fatalError("not implemented")
    }
    
    public func readValue(for characteristic: Characteristic<Peripheral>, timeout: TimeInterval) throws -> Data {
        NSLog("\(type(of: self)) \(#function)")
        
        fatalError("not implemented")
    }
    
    public func writeValue(_ data: Data, for characteristic: Characteristic<Peripheral>, withResponse: Bool, timeout: TimeInterval) throws {
        NSLog("\(type(of: self)) \(#function)")
        
    }
    
    public func notify(_ notification: ((Data) -> ())?, for characteristic: Characteristic<Peripheral>, timeout: TimeInterval) throws {
        NSLog("\(type(of: self)) \(#function)")
        
    }
    
    //MARK: Android
    
    private class ScanCallback: Android.Bluetooth.LE.ScanCallback {
        
        weak var central: AndroidCentral?
        
        public required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        convenience init() {
            
            self.init(javaObject: nil)
            bindNewJavaObject()
        }
        
        public override func onScanResult(callbackType: Android.Bluetooth.LE.ScanCallbackType,
                                          result: Android.Bluetooth.LE.ScanResult) {
            
            NSLog("\(type(of: self)) \(#function)")
            
            let peripheral = Peripheral(identifier: result.device.address)
            
            let advertisement = AdvertisementData(data: Data(result.scanRecord.bytes))
            
            let scanData = ScanData(peripheral: peripheral,
                                    rssi: Double(result.rssi),
                                    advertisementData: advertisement)
            
            central?.accessQueue.async { [weak self] in
                
                guard let central = self?.central
                    else { return }
                
                central.internalState.scan.foundDevice?(scanData)
                
                central.internalState.cache[peripheral] = Cache(device: result.device,
                                                                central: central)
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
        
        private weak var central: AndroidCentral?
        
        convenience init(central: AndroidCentral) {
            self.init(javaObject: nil)
            bindNewJavaObject()
            
            self.central = central
        }
        
        public required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        public func onConnectionStateChange(gatt: Android.Bluetooth.Gatt,
                                            status: AndroidBluetoothGatt.Status,
                                            newState: AndroidBluetoothDevice.State) {
            
            NSLog("\(type(of: self)): \(#function)")
            
            NSLog("Status: \(status) - newState = \(newState)")
            
            central?.accessQueue.async { [weak self] in
                
                guard let central = self?.central
                    else { return }
                                
                switch status {
                    
                case .success:
                    
                    central.internalState.connect.semaphore?.stopWaiting()
                    
                default:
                    
                    central.internalState.connect.semaphore?.stopWaiting(status) // throw `status` error
                }
            }
            
            if(status.rawValue != AndroidBluetoothGatt.Status.success){
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
            
             gatt.getServices()?.withJavaObject{
                
                let service = Android.Bluetooth.GattService.init(javaObject: $0)
                NSLog("Service \(service.getUuid().toString())")
             }
            
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

// MARK: - Supporting Types

internal extension AndroidCentral {
    
    struct InternalState {
        
        fileprivate init() { }
        
        var cache = [Peripheral: Cache]()
        
        var scan = Scan()
        
        struct Scan {
            
            //var peripherals = [Peripheral: (peripheral: CBPeripheral, scanResult: ScanData<Peripheral, AdvertisementData>)]()
            
            var foundDevice: ((ScanData<Peripheral, Advertisement>) -> ())?
        }
        
        var connect = Connect()
        
        struct Connect {
            
            var semaphore: Semaphore?
        }
        
        var discoverServices = DiscoverServices()
        
        struct DiscoverServices {
            
            var semaphore: Semaphore?
        }
        
        var discoverCharacteristics = DiscoverCharacteristics()
        
        struct DiscoverCharacteristics {
            
            var semaphore: Semaphore?
        }
        
        var readCharacteristic = ReadCharacteristic()
        
        struct ReadCharacteristic {
            
            var semaphore: Semaphore?
        }
        
        var writeCharacteristic = WriteCharacteristic()
        
        struct WriteCharacteristic {
            
            var semaphore: Semaphore?
        }
        
        var notify = Notify()
        
        struct Notify {
            
            var semaphore: Semaphore?
        }
    }
}

internal extension AndroidCentral {
    
    final class Cache {
        
        let device: Android.Bluetooth.Device
        
        fileprivate init(device: Android.Bluetooth.Device, central: AndroidCentral) {
            
            self.device = device
            self.gattCallback = GattCallback(central: central)
        }
        
        var gattCallback = GattCallback()
        
        var gatt: Android.Bluetooth.Gatt?
    }
}

internal extension AndroidCentral {
    
    final class Semaphore {
        
        let semaphore: DispatchSemaphore
        let timeout: TimeInterval
        var error: Swift.Error?
        
        init(timeout: TimeInterval) {
            
            self.timeout = timeout
            self.semaphore = DispatchSemaphore(value: 0)
            self.error = nil
        }
        
        func wait() throws {
            
            let dispatchTime: DispatchTime = .now() + timeout
            
            let success = semaphore.wait(timeout: dispatchTime) == .success
            
            if let error = self.error {
                
                throw error
            }
            
            guard success else { throw CentralError.timeout }
        }
        
        func stopWaiting(_ error: Swift.Error? = nil) {
            
            // store signal
            self.error = error
            
            // stop blocking
            semaphore.signal()
        }
    }
}

//#endif
