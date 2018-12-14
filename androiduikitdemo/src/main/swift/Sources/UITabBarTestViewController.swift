//
//  UITabBarTestViewController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 10/23/18.
//

import Foundation
#if os(iOS)
import UIKit
#else
import Android
import AndroidUIKit
#endif

final class UITabBarTestViewController: UIViewController, UITabBarDelegate {
    
    override func loadView() {
        self.view = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: UIScreen.main.bounds.width,
                                         height: UIScreen.main.bounds.height))
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        let uiTabBar = UITabBar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: 56))
        
        var items = [UITabBarItem]()
        
        items.append(UITabBarItem.init(title: "Breakfast", image: UIImage.init(named: "ic_free_breakfast"), tag: 0))
        items.append(UITabBarItem.init(title: "Restaurants", image: UIImage.init(named: "ic_restaurant_menu"), tag: 1))
        items.append(UITabBarItem.init(title: "Chat", image: UIImage.init(named: "ic_chat"), tag: 2))
        
        uiTabBar.delegate = self
        uiTabBar.setItems(items, animated: false)
        
        self.view.addSubview(uiTabBar)
    }
    
    func tabBar(_ uiTableBar: UITabBar, didSelect: UITabBarItem) {
        
        NSLog("UITabBarTestViewController tabBar \(didSelect.title ?? "")")
    }
    
    func tabBar(_ uiTableBar: UITabBar, willBeginCustomizing: [UITabBarItem]) {
        
    }
    
    func tabBar(_ uiTableBar: UITabBar, didBeginCustomizing: [UITabBarItem]) {
        
    }
    
    func tabBar(_ uiTableBar: UITabBar, willEndCustomizing: [UITabBarItem], changed: Bool) {
        
    }
    
    func tabBar(_ uiTableBar: UITabBar, didEndCustomizing: [UITabBarItem], changed: Bool) {
        
    }
}
