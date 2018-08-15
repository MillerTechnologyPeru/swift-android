//
//  UILabel.swift
//  Android
//
//  Created by Marco Estrella on 8/15/18.
//

import struct Foundation.CGFloat
import struct Foundation.CGPoint
import struct Foundation.CGSize
import struct Foundation.CGRect
import Android
import java_swift

open class UILabel: UIView {
    
    // MARK: - Initialization
    
    internal lazy private(set) var androidTextView: AndroidTextView = { [unowned self] in
        
        guard let context = AndroidContext(casting: UIScreen.main.activity)
            else { fatalError("Missing context") }
        
        return AndroidTextView.init(context: context)
    }()
    
    public var text: String? {
        set {
            androidTextView.text = newValue
        }
        get {
            return androidTextView.text
        }
    }
    
    public var textColor: UIColor! {
        set {
            androidTextView.color = newValue.androidColor.color
        }
        get {
            return UIColor.init(color: (androidTextView.color))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // disable user interaction
        //self.isUserInteractionEnabled = false
        
        androidTextView.layoutParams = AndroidFrameLayoutLayoutParams(width: Int(frame.width), height: Int(frame.height))
    }
}
