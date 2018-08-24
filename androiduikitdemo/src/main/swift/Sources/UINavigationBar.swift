//
//  UINavigationBar.swift
//  androiduikittarget
//
//  Created by Alsey Coleman Miller on 8/23/18.
//

import Foundation

open class UINavigationBar: UIView {
    
    public weak var delegate: UINavigationBarDelegate?
    
    public var items: [UINavigationItem]? {
        
        get { return _items }
        
        set { setItems(newValue, animated: false) }
    }
    
    private var _items: [UINavigationItem]?
    
    public var isTranslucent: Bool = true
    
    public var topItem: UINavigationItem? {
        
        return navigationStack.last
    }
    
    public var backItem: UINavigationItem? {
        
        guard navigationStack.count > 1
            else { return nil }
        
        return navigationStack[navigationStack.count - 2]
    }
    
    private var navigationStack = [UINavigationItem]()
    
    // Pushing a navigation item displays the item's title in the center of the navigation bar.
    // The previous top navigation item (if it exists) is displayed as a "back" button on the left.
    public func pushItem(_ item: UINavigationItem, animated: Bool) {
        
        guard delegate?.navigationBar(self, shouldPush: item) ?? true
            else { return }
        
        navigationStack.append(item)
        
        // configure views
        
        
        delegate?.navigationBar(self, didPush: item)
    }
    
    // Returns the item that was popped.
    public func popItem(animated: Bool) -> UINavigationItem? {
        
        fatalError()
    }
    
    public func setItems(_ items: [UINavigationItem]?, animated: Bool) {
        
        
        
        _items = items
    }
}

private extension UINavigationBar {
    
    enum Transition {
        
        case none
        case push
        case pop
    }
}
