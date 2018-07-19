//
//  UIView.swift
//  AndroidUIKit
//
//  Created by Carlos Duclos on 7/13/18.
//

import Foundation
import Android

open class UIView {
    
    internal var androidView: Android.Widget.FrameLayout!
    
    /// The view’s background color.
    var backgroundColor: UIColor {
        get {
            return androidView.background != nil ? UIColor.init(androidColor: androidView.background! as! Android.Graphics.Drawable.ColorDrawable) :  UIColor.clear
        }
        set{
            androidView.background = newValue.androidColor
        }
    }
    
    /// The frame rectangle, which describes the view’s location and size in its superview’s coordinate system.
    open var frame: CGRect {
        get { return _frame }
        set {
            _frame = newValue
            _bounds.size = newValue.size
        }
    }
    
    /// The bounds rectangle, which describes the view’s location and size in its own coordinate system.
    public final var bounds: CGRect {
        get { return _bounds }
        set {
            _bounds = newValue
            _frame.size = newValue.size
        }
    }
    
    private var _bounds = CGRect()
    
    private var _frame = CGRect()
    
    public init(){
        androidView = Android.Widget.FrameLayout(context: UIApplication.context!)
        androidView.layoutParams = Android.Widget.FrameLayout.FLayoutParams(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.MATCH_PARENT)
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public init(frame: CGRect) {
        
        self.frame = frame
        
        androidView = Android.Widget.FrameLayout(context: UIApplication.context!)
        androidView.setX(x: Float(frame.minX))
        androidView.setY(y: Float(frame.minY))
        
        androidView.layoutParams = Android.Widget.FrameLayout.FLayoutParams(width: Int(frame.width), height: Int(frame.height))
        
    }
    
    func addSubview(_ view: UIView) {
        
        androidView.addView(view.androidView)
    }
    
}
