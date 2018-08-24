//
//  UINavigationBarDelegate.swift
//  androiduikittarget
//
//  Created by Alsey Coleman Miller on 8/23/18.
//

public protocol UINavigationBarDelegate: class {
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool
    
    func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem)
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool
    
    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem)
}

public extension UINavigationBarDelegate {
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool  {
        
        return true
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
        
        
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        
        return true
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        
        
    }
}
