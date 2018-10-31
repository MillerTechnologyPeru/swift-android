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
        
        let fourth = UINavigationController(rootViewController: NavFirstViewController())
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

final class NavFirstViewController: UIViewController {
    
    override func loadView() {
        self.view = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: UIApplication.shared.androidActivity.screen.bounds.width,
                                         height: UIApplication.shared.androidActivity.screen.bounds.height))
    }
    
    override func viewDidLoad() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.view.backgroundColor = UIColor.red
        
        navigationItem.title = "First Nav VC"
        
        let rightItem = UIBarButtonItem.init(title: "Second", style: .done, target: nil, action: nil)
        rightItem.action = {
            
            let secondViewController = NavSecondViewController()
            self.navigationController?.pushViewController(secondViewController, animated: false)
        }
        
        navigationItem.rightBarButtonItems = [rightItem]
        
        //TOOLBAR
        
        var items = [UIBarButtonItem]()
        
        let toolbarItem1 = UIBarButtonItem(title: "Breakfast", style: .done, target: self) {
            
            NSLog("Toolbar Item 1 clicked")
        }
        toolbarItem1.image = UIImage(named: "ic_free_breakfast")
        
        let toolbarItem2 = UIBarButtonItem(title: "Restaurant", style: .done, target: self) {
            
            NSLog("Toolbar Item 2 clicked")
        }
        toolbarItem2.image = UIImage.init(named: "ic_restaurant_menu")
        
        let toolbarItem3 = UIBarButtonItem(title: "Chat", style: .done, target: self) {
            
            NSLog("Toolbar Item 3 clicked")
        }
        
        toolbarItem3.image = UIImage(named: "ic_chat")
        
        items.append(toolbarItem1)
        items.append(toolbarItem2)
        items.append(toolbarItem3)
        
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.items = items
    }
}

final class NavSecondViewController: UIViewController {
    
    override func loadView() {
        self.view = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: UIApplication.shared.androidActivity.screen.bounds.width,
                                         height: UIApplication.shared.androidActivity.screen.bounds.height))
    }
    
    override func viewDidLoad() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.view.backgroundColor = UIColor.purple
        
        navigationItem.title = "Second Nav VC"
        
        let rightItem = UIBarButtonItem.init(title: "Click", style: .done, target: nil, action: nil)
        rightItem.action = {
            
            let thirdViewController = NavThirdViewController()
            self.navigationController?.pushViewController(thirdViewController, animated: false)
        }
        
        navigationItem.rightBarButtonItems = [rightItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

final class NavThirdViewController: UIViewController {
    
    override func loadView() {
        self.view = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: UIApplication.shared.androidActivity.screen.bounds.width,
                                         height: UIApplication.shared.androidActivity.screen.bounds.height))
    }
    
    override func viewDidLoad() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.view.backgroundColor = UIColor.yellow
        
        navigationItem.title = "Third Nav VC"
        
        let rightItem = UIBarButtonItem.init(title: "Second", style: .done, target: nil, action: nil)
        rightItem.action = {
            
            NSLog("HI5")
        }
        
        navigationItem.rightBarButtonItems = [rightItem]
        
        //TOOLBAR
        
        var items = [UIBarButtonItem]()
        
        let toolbarItem1 = UIBarButtonItem(title: "Breakfast", style: .done, target: self) {
            
            NSLog("Toolbar Item 1 clicked")
        }
        toolbarItem1.image = UIImage(named: "ic_free_breakfast")
        
        let toolbarItem2 = UIBarButtonItem(title: "Restaurant", style: .done, target: self) {
            
            NSLog("Toolbar Item 2 clicked")
        }
        toolbarItem2.image = UIImage.init(named: "ic_restaurant_menu")
        
        let toolbarItem3 = UIBarButtonItem(title: "Chat", style: .done, target: self) {
            
            NSLog("Toolbar Item 3 clicked")
        }
        
        toolbarItem3.image = UIImage(named: "ic_chat")
        
        items.append(toolbarItem1)
        items.append(toolbarItem2)
        items.append(toolbarItem3)
        
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.items = items
    }
}
