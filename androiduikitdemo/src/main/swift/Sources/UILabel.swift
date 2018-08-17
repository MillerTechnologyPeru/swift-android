//
//  UILabel.swift
//  Android
//
//  Created by Marco Estrella on 8/15/18.
//

import Foundation
import Android
import java_swift

open class UILabel: UIView {
    
    // MARK: - Initialization
    
    /*
    internal lazy private(set) var androidTextView: AndroidTextView = { [unowned self] in
        
        guard let context = AndroidContext(casting: UIScreen.main.activity)
            else { fatalError("Missing context") }
        
        return AndroidTextView(context: context)
    }()*/
    
    var androidTextView: AndroidTextView?
    
    public var text: String? {
        set {
            androidTextView?.text = newValue
        }
        get {
            return androidTextView?.text
        }
    }
    
    public var textColor: UIColor! {
        set {
            androidTextView?.color = newValue.androidColor.color
        }
        get {
            return UIColor.init(color: (androidTextView?.color)!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSLog("\((type: self)) \(#function) \(Int(frame.width)) - \(Int(frame.height))")
        // disable user interaction
        //self.isUserInteractionEnabled = false
        
        guard let context = AndroidContext(casting: UIScreen.main.activity)
            else { fatalError("Missing context") }
        
        androidTextView = AndroidTextView(context: context)
        
        androidTextView?.setId(1122334)
        //androidTextView.layoutParams = AndroidFrameLayoutLayoutParams(width: Int(frame.width), height: Int(frame.height))
        androidTextView?.layoutParams = AndroidFrameLayoutLayoutParams(width: AndroidFrameLayoutLayoutParams.MATCH_PARENT, height: AndroidFrameLayoutLayoutParams.WRAP_CONTENT)
    }
}
