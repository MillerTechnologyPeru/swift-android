//
//  UINavigationItem.swift
//  androiduikittarget
//
//  Created by Alsey Coleman Miller on 8/23/18.
//

import Foundation

open class UINavigationItem: NSObject {
    
    public var title: String?
    
    public init(title: String) {
        super.init()
        
        self.title = title
    }
}
