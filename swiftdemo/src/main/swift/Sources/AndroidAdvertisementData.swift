//
//  AndroidAdvertisementData.swift
//  Android
//
//  Created by Marco Estrella on 7/24/18.
//

import Foundation
import GATT

public struct AndroidAdvertisementData: AdvertisementDataProtocol {
    
    public var localName: String?
    
    public var manufacturerData: Data?
    
    public var isConnectable: Bool?
    
    
}
