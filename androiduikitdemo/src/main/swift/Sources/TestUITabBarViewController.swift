//
//  TestUITabBarViewController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 10/24/18.
//

import Foundation
#if os(iOS)
import UIKit
#else
import Android
import AndroidUIKit
#endif

final class TestUITabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        
        let first = FirstViewController()
        first.tabBarItem = UITabBarItem.init(title: "Restaurants", image: UIImage.init(named: "ic_restaurant_menu"), tag: 0)
        
        let second = SecondViewController()
        second.tabBarItem = UITabBarItem.init(title: "Breakfast", image: UIImage.init(named: "ic_free_breakfast"), tag: 1)
        
        let third = ThirdViewController()
        third.tabBarItem = UITabBarItem.init(title: "Chat", image: UIImage.init(named: "ic_chat"), tag: 2)
        
        viewControllers = [first, second, third]
    }
}

final class ThirdViewController: UIViewController {
    
    override func loadView() {
        self.view = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: UIApplication.shared.androidActivity.screen.bounds.width,
                                         height: UIApplication.shared.androidActivity.screen.bounds.height))
    }
    
    override func viewDidLoad() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.view.backgroundColor = UIColor.cyan
        
    }
}

final class SecondViewController: UIViewController {
    
    override func loadView() {
        self.view = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: UIApplication.shared.androidActivity.screen.bounds.width,
                                         height: UIApplication.shared.androidActivity.screen.bounds.height))
    }
    
    override func viewDidLoad() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.view.backgroundColor = UIColor.blue
    }
}

final class FirstViewController: UIViewController {
    
    override func loadView() {
        self.view = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: UIApplication.shared.androidActivity.screen.bounds.width,
                                         height: UIApplication.shared.androidActivity.screen.bounds.height))
    }
    
    override func viewDidLoad() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.view.backgroundColor = UIColor.orange
    }
}
