//
//  AndroidPeripheral.swift
//  Android
//
//  Created by Marco Estrella on 7/24/18.
//

import Foundation
import GATT
import Android
import Bluetooth

/// Peripheral Peer
///
/// Represents a remote peripheral device that has been discovered.
public class AndroidPeripheral: Peer {
    
    public let identifier: Bluetooth.Address
    internal var device: Android.Bluetooth.Device
    internal var gatt: Android.Bluetooth.Gatt?
    
    internal init(identifier: Bluetooth.Address, device: Android.Bluetooth.Device) {
        
        self.identifier = identifier
        self.device = device
    }
}
