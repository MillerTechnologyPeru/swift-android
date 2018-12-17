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

final class UITabBarTestViewController: UITabBarController {
    
    private let items = [
        TabItem(
            title: NSLocalizedString("Views", comment: "Views Tab Bar Item Name"),
            viewController: MainViewController(),
            imageName: "ic_free_breakfast"
        ),
        TabItem(
            title: NSLocalizedString("Doc Picker", comment: "Configurations Tab Bar Item Name"),
            viewController: TestDocPickerViewController(),
            imageName: "ic_restaurant_menu"
        ),
        TabItem(
            title: NSLocalizedString("Table", comment: "Table Tab Bar Item Name"),
            viewController: TestThirdViewController(),
            imageName: "ic_chat"
        )
    ]
    
    /*override func loadView() {
        self.view = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: UIScreen.main.bounds.width,
                                         height: UIScreen.main.bounds.height))
        self.view.backgroundColor = UIColor.white
    }*/
    
    override func viewDidLoad() {
        
        NSLog("\(type(of: self)) \(#function)")
        
        viewControllers = items.map {
            let navigationController = UINavigationController(rootViewController: $0.viewController)
            #if os(iOS)
            let tabBarItem = UITabBarItem(
                title: $0.title,
                image: UIImage(named: $0.imageName),
                selectedImage: UIImage(named: $0.imageName + "_selected") ?? UIImage(named: $0.imageName)
            )
            #elseif os(Android) || os(macOS)
            let tabBarItem = UITabBarItem(
                title: $0.title,
                image: UIImage(named: $0.imageName)
            )
            #endif
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }
        
        #if os(Android)
        //viewControllers = viewControllers?.reversed()
        #endif
        
        /*
        
        let uiTabBar = UITabBar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: 56))
        
        var items = [UITabBarItem]()
        
        items.append(UITabBarItem(title: "Breakfast", image: UIImage(named: "ic_free_breakfast"), tag: 0))
        items.append(UITabBarItem(title: "Restaurants", image: UIImage(named: "ic_restaurant_menu"), tag: 1))
        items.append(UITabBarItem(title: "Chat", image: UIImage(named: "ic_chat"), tag: 2))
        
        uiTabBar.delegate = self
        uiTabBar.setItems(items, animated: false)
        
        self.view.addSubview(uiTabBar)
         */
    }
}

// MARK: - Supporting Types

private extension UITabBarTestViewController {
    
    struct TabItem {
        let title: String
        let viewController: UIViewController
        let imageName: String
    }
}
