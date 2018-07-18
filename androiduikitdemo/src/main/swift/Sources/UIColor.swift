//
//  UIColor.swift
//  Android
//
//  Created by Marco Estrella on 7/17/18.
//

import Foundation
import Android

public struct UIColor {
    
    // MARK: - Properties
    
    internal var androidColor: Android.Graphics.Drawable.ColorDrawable?
    
    //public let cgColor: CGColor
    
    // MARK: - Initialization
    
    internal init( color: Int) {
        
        self.androidColor = Android.Graphics.Drawable.ColorDrawable.init(color: color)
    }
    
    /*
    public init(cgColor color: CGColor) {
        
        self.cgColor = color
    }*/
    
    /// An initialized color object. The color information represented by this object is in the device RGB colorspace.
    public init(red: CGFloat,
                green: CGFloat,
                blue: CGFloat,
                alpha: CGFloat = 1.0) {
        
        //self.cgColor = CGColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static let black = UIColor(color: Android.Graphics.Color.BLACK)
    
    static let blue = UIColor(color: Android.Graphics.Color.BLUE)
    
    static let brown = UIColor(color: Android.Graphics.Color.argb(alpha: 1.0, red: 0.6, green: 0.4, blue: 0.2))
    
    static let clear = UIColor(color: Android.Graphics.Color.TRANSPARENT)
    
    static let cyan = UIColor(color: Android.Graphics.Color.CYAN)
    
    static let darkGray = UIColor(color: Android.Graphics.Color.DKGRAY)
    
    static let gray = UIColor(color: Android.Graphics.Color.GRAY)
    
    static let green = UIColor(color: Android.Graphics.Color.GREEN)
    
    static let lightGray = UIColor(color: Android.Graphics.Color.LTGRAY)
    
    static let magenta = UIColor(color: Android.Graphics.Color.argb(alpha: 1.0, red: 1.0, green: 0.0, blue: 1.0))
    
    static let orange = UIColor(color: Android.Graphics.Color.argb(alpha: 1.0, red: 1.0, green: 0.5, blue: 1.0))
    
    static let purple = UIColor(color: Android.Graphics.Color.argb(alpha: 1.0, red: 0.5, green: 0.0, blue: 0.5))
    
    static let red = UIColor(color: Android.Graphics.Color.RED)
    
    static let white = UIColor(color: Android.Graphics.Color.WHITE)
    
    static let yellow = UIColor(color: Android.Graphics.Color.YELLOW)
}
