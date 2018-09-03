//
//  UINavigationBar.swift
//  androiduikittarget
//
//  Created by Alsey Coleman Miller on 8/23/18.
//

import Foundation
import Android
import java_swift

open class UINavigationBar: UIView {
    
    public weak var delegate: UINavigationBarDelegate?
    
    public var items: [UINavigationItem]? {
        
        get { return _navigationStack }
        
        set { setItems(newValue, animated: false) }
    }
    
    private var _navigationStack = [UINavigationItem]()
    
    public var isTranslucent: Bool = true
    
    public var topItem: UINavigationItem? {
        
        return _navigationStack.last
    }
    
    public var backItem: UINavigationItem? {
        
        guard _navigationStack.count > 1
            else { return nil }
        
        return _navigationStack[_navigationStack.count - 2]
    }
    
    internal private(set) lazy var androidToolbar: AndroidToolbar = { [unowned self] in
        
        let toolbar = AndroidToolbar.init(context: UIScreen.main.activity)
        
        toolbar.context?.setTheme(resId: UIScreen.main.activity.getIdentifier(name: "Dark_ActionBar", type: "style"))
        toolbar.popupTheme = UIScreen.main.activity.getIdentifier(name: "Light", type: "style")

        toolbar.title = "AndroidUIKit"
        
        // default background color
        let colorPrimaryId = UIScreen.main.activity.getIdentifier(name: "colorPrimary", type: "color")
        toolbar.setBackgroundColor(color: AndroidContextCompat.getColor(context: UIScreen.main.activity, colorRes: colorPrimaryId))
        
        return toolbar
    }()
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateAndroidToolbarSize()
        
        androidView.addView(androidToolbar)
        
        NSLog("\(type(of: self)) \(#function)")
    }
    
    private func updateAndroidToolbarSize() {
        
        let frameDp = CGRect.applyDP(rect: frame)
        
        // set origin
        androidToolbar.setX(x: Float(frameDp.minX))
        androidToolbar.setY(y: Float(frameDp.minY))
        
        // set size
        androidToolbar.layoutParams = Android.Widget.FrameLayout.FLayoutParams(width: Int(frameDp.width), height: Int(frameDp.height))
    }
    
    private func updateAndroidToolbar(){
        
        guard let item = _navigationStack.last
            else { return }
        
        // configure views
        androidToolbar.title = item.title ?? ""
        
        let menu = androidToolbar.menu
        
        menu.clear()
        
        if item.leftBatButtonItem != nil {
            
            menu.add(groupId: 2, itemId: AndroidViewCompat.generateViewId(), order: 1, title: item.leftBatButtonItem?.title ?? "")
                .setShowAsAction(action: AndroidMenuItemForward.ShowAsAction.ifRoom)
        }
        
        item.leftBarButtonItems?.forEach { barButton in
            menu.add(groupId: 2, itemId: AndroidViewCompat.generateViewId(), order: 1, title: barButton.title ?? "")
                .setShowAsAction(action: AndroidMenuItemForward.ShowAsAction.ifRoom)
        }
        
        if item.rightBarButtonItem != nil {
            
            menu.add(groupId: 1, itemId: AndroidViewCompat.generateViewId(), order: 1, title: item.rightBarButtonItem?.title ?? "")
                .setShowAsAction(action: AndroidMenuItemForward.ShowAsAction.ifRoom)
        }
        
        item.rightBarButtonItems?.forEach { barButton in
            menu.add(groupId: 1, itemId: AndroidViewCompat.generateViewId(), order: 1, title: barButton.title ?? "")
                .setShowAsAction(action: AndroidMenuItemForward.ShowAsAction.ifRoom)
        }
    }
    
    // Pushing a navigation item displays the item's title in the center of the navigation bar.
    // The previous top navigation item (if it exists) is displayed as a "back" button on the left.
    public func pushItem(_ item: UINavigationItem, animated: Bool) {
        
        guard delegate?.navigationBar(self, shouldPush: item) ?? true
            else { return }
        
        _navigationStack.append(item)
        
        updateAndroidToolbar()
        
        delegate?.navigationBar(self, didPush: item)
    }
    
    // Returns the item that was popped.
    public func popItem(animated: Bool) -> UINavigationItem? {
        
        NSLog("\(type(of: self)) \(#function) 1")
        
        NSLog("\(type(of: self)) \(#function) count \(_navigationStack.count)")
        
        if _navigationStack.count <= 1 {
            return nil
        }
        NSLog("\(type(of: self)) \(#function) 2")
        guard let poppedItem = topItem
            else { return nil }
        
        delegate?.navigationBar(self, shouldPop: poppedItem)
        
        _navigationStack.removeLast()
        
        updateAndroidToolbar()
        
        NSLog("\(type(of: self)) \(#function) 3")
        
        delegate?.navigationBar(self, didPop: poppedItem)
        return poppedItem
    }
    
    public func setItems(_ items: [UINavigationItem]?, animated: Bool) {
        
        guard let items = items else {
            
            _navigationStack.removeAll()
            return
        }
        
        _navigationStack = items
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        updateAndroidToolbarSize()
    }
    
}

private extension UINavigationBar {
    
    enum Transition {
        
        case none
        case push
        case pop
    }
}
