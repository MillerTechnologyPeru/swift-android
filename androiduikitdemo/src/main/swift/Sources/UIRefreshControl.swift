//
//  UIRefreshControl.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 9/13/18.
//

import Foundation
import Android

open class UIRefreshControl: UIControl {
    
    internal lazy var androidSwipeRefreshLayout: AndroidSwipeRefreshLayout = {
        
        let swipeRefreshLayout = AndroidSwipeRefreshLayout.init(context: UIScreen.main.activity)
        
        //swipeRefreshLayout.setColorSchemeColors(colors: )
        
        return swipeRefreshLayout
    }()
    
    //public var tintColor: UIColor!
    
    public var isRefreshing: Bool {
        get {
            return androidSwipeRefreshLayout.isRefreshing
        }
        
        set {
            androidSwipeRefreshLayout.isRefreshing = newValue
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
         updateSwipeRefreshLayoutFrame()
    }
    
    private func updateSwipeRefreshLayoutFrame() {
        
        let frameDp = CGRect.applyDP(rect: frame)
        
        // set origin
        androidSwipeRefreshLayout.setX(x: Float(frameDp.minX))
        androidSwipeRefreshLayout.setY(y: Float(frameDp.minY))
        
        // set size
        androidSwipeRefreshLayout.layoutParams = AndroidViewGroupLayoutParams(width: Int(frameDp.width), height: Int(frameDp.height))
    }
    
    override func updateAndroidViewSize() {
        
        updateSwipeRefreshLayoutFrame()
    }
    
    open override func targetAdded(action: @escaping () -> (), for event: UIControlEvent) {
        
        androidSwipeRefreshLayout.setOnRefreshListener {
            action()
        }
    }
    
    open override func targetRemoved(for event: UIControlEvent) {
        
        androidSwipeRefreshLayout.setOnRefreshListener(listener: nil)
    }
    
    public func beginRefreshing() {
        
        androidSwipeRefreshLayout.isRefreshing = true
    }
    
    public func endRefreshing() {
        
        androidSwipeRefreshLayout.isRefreshing = false
    }
}
