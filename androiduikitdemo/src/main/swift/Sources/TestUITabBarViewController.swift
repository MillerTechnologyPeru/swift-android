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
        
        let firstVCNavItem = UINavigationItem.init(title: "First VC")
        firstVCNavItem.rightBarButtonItem = UIBarButtonItem.init(title: "Android", style: .done, target: nil, action: { NSLog("Hi, im Android")})
        firstVCNavItem.rightBarButtonItem?.image = UIImage.init(named: "ic_android")
        
        let secondVCNavItem = UINavigationItem.init(title: "Second VC")
        secondVCNavItem.rightBarButtonItem = UIBarButtonItem.init(title: "Bluetooth", style: .done, target: nil, action: { NSLog("Hi, im Bluetooth")})
        secondVCNavItem.rightBarButtonItem?.image = UIImage.init(named: "ic_bluetooth")
        
        let thirdVCNavItem = UINavigationItem.init(title: "Third VC")
        thirdVCNavItem.rightBarButtonItem = UIBarButtonItem.init(title: "MR3", style: .done, target: nil, action: { NSLog("Hi, im MR3")})
        
        let first = FirstViewController()
        first.navigationItem = firstVCNavItem
        first.tabBarItem = UITabBarItem.init(title: "Restaurants", image: UIImage.init(named: "ic_restaurant_menu"), tag: 0)
        
        let second = SecondViewController()
        second.navigationItem = secondVCNavItem
        second.tabBarItem = UITabBarItem.init(title: "Breakfast", image: UIImage.init(named: "ic_free_breakfast"), tag: 1)
        
        let third = ThirdViewController()
        third.navigationItem = thirdVCNavItem
        third.tabBarItem = UITabBarItem.init(title: "Chat", image: UIImage.init(named: "ic_chat"), tag: 2)
        
        let fourth = UINavigationController(rootViewController: UITableTestViewController())
        fourth.tabBarItem = UITabBarItem.init(title: "Fourth", image: UIImage.init(named: "ic_android"), tag: 3)
        
        viewControllers = [first, second, third, fourth]
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
