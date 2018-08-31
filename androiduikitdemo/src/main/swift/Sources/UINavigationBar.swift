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
    
    private var navigationStack = [UINavigationItem]()
    
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
    
    // Pushing a navigation item displays the item's title in the center of the navigation bar.
    // The previous top navigation item (if it exists) is displayed as a "back" button on the left.
    public func pushItem(_ item: UINavigationItem, animated: Bool) {
        
        guard delegate?.navigationBar(self, shouldPush: item) ?? true
            else { return }
        
        navigationStack.append(item)
        
        // configure views
        androidToolbar.title = item.title ?? ""
        
        delegate?.navigationBar(self, didPush: item)
    }
    
    // Returns the item that was popped.
    public func popItem(animated: Bool) -> UINavigationItem? {
        
        fatalError()
    }
    
    public func setItems(_ items: [UINavigationItem]?, animated: Bool) {
        
        
        
        _items = items
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
