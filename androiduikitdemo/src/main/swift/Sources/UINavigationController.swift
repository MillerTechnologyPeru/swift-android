//
//  UINavigationController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 8/23/18.
//

import Foundation
import Android
import java_swift

open class UINavigationController: UIViewController {
    
    // MARK: - Public properties
    
    public var topViewController: UIViewController?
    
    public var visibleViewController: UIViewController?
    
    public var viewControllers: [UIViewController] = []
    
    /// The delegate of the navigation controller object.
    public var delegate: UINavigationControllerDelegate?
    
    // MARK: - Private properties
    
    private var rootViewController: UIViewController?
    
    private lazy private(set) var contentView: UIView = { [unowned self] in
        return UIView.init(frame: CGRect.init(x: 0, y: 48, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 48))
    }()
    
    /// Initializes and returns a newly created navigation controller.
    public init(rootViewController: UIViewController) {
        
        super.init()
        
        self.rootViewController = rootViewController
        
        //create android toolbar
        
        //view.addSubview()
        
        //add content view to the main view
        
        view.addSubview(contentView)
        
        // add rootViewController view to the content view
        
        contentView.backgroundColor = UIColor.purple
        contentView.addSubview(rootViewController.view)
        
        //view = rootViewController.view
    }
    
    public init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?){
        
        super.init()
    }
}

// MARK: - Accessing Items on the Navigation Stack

public extension UINavigationController {
    
    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        self.viewControllers.removeAll()
        self.viewControllers = viewControllers
    }
}

 // MARK: - Pushing and Popping Stack Items

public extension UINavigationController {
    
    /// Pushes a view controller onto the receiver’s stack and updates the display.
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
    }
    
    /// Pops the top view controller from the navigation stack and updates the display.
    func popViewController(animated: Bool) -> UIViewController? {
        
        fatalError()
    }
    
    /// Pops all the view controllers on the stack except the root view controller and updates the display.
    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        
        fatalError()
    }
}

