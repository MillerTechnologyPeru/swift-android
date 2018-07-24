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
public struct AndroidPeripheral: Peer {
    
    public let identifier: Bluetooth.Address
    
    internal init(identifier: Bluetooth.Address) {
        
        self.identifier = identifier
    }
}
