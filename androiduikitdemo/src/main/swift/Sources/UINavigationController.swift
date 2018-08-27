//
//  UINavigationController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 8/23/18.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(Android)
import Android
#endif

open class UINavigationController: UIViewController {
    
    // MARK: - Public properties
    
    /// The view controller at the top of the navigation stack.
    public var topViewController: UIViewController? {
        
        return children.last
    }
    
    /// The view controller associated with the currently visible view in the navigation interface.
    public private(set) var visibleViewController: UIViewController?
    
    /// The view controllers currently on the navigation stack.
    public var viewControllers: [UIViewController] {
        
        get { return _viewControllers }
        
        set { setViewControllers(newValue, animated: false) }
    }
    
    private var _viewControllers = [UIViewController]()
    
    public lazy var navigationBar = UINavigationBar()
    
    public var isNavigationBarHidden: Bool {
        
        get { return _isNavigationBarHidden }
        
        set {
            navigationBar.isHidden = newValue
            _isNavigationBarHidden = newValue
        }
    }
    
    private var _isNavigationBarHidden: Bool = false
    
    public lazy var toolbar = UIToolbar()
    
    public var isToolbarHidden: Bool {
        
        get { return _isToolbarHidden }
        
        set {
            toolbar.isHidden = newValue
            _isToolbarHidden = newValue
        }
    }
    
    private var _isToolbarHidden: Bool = false
    
    /// The delegate of the navigation controller object.
    public weak var delegate: UINavigationControllerDelegate?
    
    open override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        
        return false
    }
    
    /// Initializes and returns a newly created navigation controller.
    public init(rootViewController: UIViewController) {
        
        #if os(iOS)
        super.init(nibName: nil, bundle: nil)
        #else
        super.init()
        #endif
        
        //self.view.backgroundColor = UIColor.purple
        
        // setup
        self.navigationBar.delegate = self
        self.setViewControllers([rootViewController], animated: false)
        
        let delay = DispatchTime.now() + .seconds(5)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) {
            #if os(Android)
            UIScreen.main.activity.runOnMainThread { [weak self] in
                let mainViewController = MainViewController()

                self?.isToolbarHidden = true
                
                self?.pushViewController(mainViewController, animated: false)
            }
            #endif
        }
    }
    
    #if os(iOS)
    public required init?(coder aDecoder: NSCoder) {
        
        fatalError("Dont use \(#function)")
    }
    #endif
    
    open override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.clipsToBounds = true
        self.view = view
        
        guard let visibleViewControllerView = visibleViewController?.view
            else { fatalError("No visible view controller") }
        
        // calculate frame
        let (contentRect, navigationBarRect, toolbarRect) = self.contentRect(for: view.bounds)
        navigationBar.frame = navigationBarRect
        navigationBar.backgroundColor = .blue
        toolbar.frame = toolbarRect
        toolbar.backgroundColor = .purple
        visibleViewControllerView.frame = contentRect
        
        // set resizing
        toolbar.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        navigationBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        visibleViewControllerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // add subviews\
        view.addSubview(visibleViewControllerView)
        view.addSubview(navigationBar)
        view.addSubview(toolbar)
    }
    
    open override func viewWillLayoutSubviews() {
        
        
    }
    
    private func contentRect(for bounds: CGRect) -> (content: CGRect, navigationBar: CGRect, toolbar: CGRect) {

        var contentRect = bounds
        
        let androidActionBarHeight = CGFloat.applyDP(pixels: UIScreen.main.activity.actionBarHeighPixels) //https://material.io/design/components/app-bars-top.html#specs
        let androidBottomNavigationBarHeight = CGFloat(56) //dp https://material.io/design/components/bottom-navigation.html#specs
        
        NSLog("actionBarHeigh dp \(androidActionBarHeight)")
        
        let navigationBarRect = CGRect(x: bounds.minX,
                                       y: bounds.minY,
                                       width: bounds.width,
                                       height: androidActionBarHeight)
        
        let toolbarRect = CGRect(x: bounds.minX,
                                 y: bounds.maxY - toolbar.frame.size.height,
                                 width: bounds.width,
                                 height: androidBottomNavigationBarHeight)
        
        NSLog("\(isNavigationBarHidden)")
        NSLog("\(isToolbarHidden)")
        if isNavigationBarHidden == false {
            
            contentRect.origin.y += navigationBarRect.height
            contentRect.size.height -= navigationBarRect.height
        }
        
        if isToolbarHidden == false {
            
            contentRect.size.height -= toolbarRect.height
        }
        
        return (contentRect, navigationBarRect, toolbarRect)
    }
    
    private func updateVisibleViewController(animated: Bool) {
        
        guard let newVisibleViewController = self.topViewController
            else { fatalError("Must have visible view controller") }
        
        let oldVisibleViewController = self.visibleViewController
        
        let isPushing = oldVisibleViewController?.parent != nil
        
        oldVisibleViewController?.beginAppearanceTransition(false, animated: animated)
        newVisibleViewController.beginAppearanceTransition(true, animated: animated)
        
        //self.delegate?.navigationController(self, willShow: newVisibleViewController, animated: animated)
        
        self.visibleViewController = newVisibleViewController
        
        let (contentRect, navigationBarRect, toolbarRect) = self.contentRect(for: view.bounds)
        navigationBar.frame = navigationBarRect
        toolbar.frame = toolbarRect
        newVisibleViewController.view.frame = contentRect
        
        //NSLog("navigationview height \(self.)")
        
        NSLog("navigationBarRect height \(navigationBarRect.height)")
        NSLog("contentRect height \(contentRect.height)")
        NSLog("toolbarRect height \(toolbarRect.height)")
        
        newVisibleViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(newVisibleViewController.view, at: 0)
        
        NSLog("view controller child height \(newVisibleViewController.view.frame.height)")
        
        // FIXME: Animate
        
        // finish animation
        oldVisibleViewController?.view.removeFromSuperview()
        toolbar.isHidden = _isToolbarHidden
        navigationBar.isHidden = _isNavigationBarHidden
        
        oldVisibleViewController?.endAppearanceTransition()
        newVisibleViewController.endAppearanceTransition()
        
        if let oldVisibleViewController = oldVisibleViewController, isPushing {
            
            oldVisibleViewController.didMove(toParentViewController: nil)
            
        } else {
            
            newVisibleViewController.didMove(toParentViewController: self)
        }
        
        //self.delegate?.navigationController(self, didShow: newVisibleViewController, animated: animated)
    }
}

// MARK: - Accessing Items on the Navigation Stack

public extension UINavigationController {
    
    /// Replaces the view controllers currently managed by the navigation controller with the specified items.
    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        
        precondition(viewControllers.isEmpty == false, "Missing root view controller")
        
        guard viewControllers != self.viewControllers
            else { return } // no change
        
        // these view controllers are not in the new collection, so we must remove them as children
        self.viewControllers.forEach {
            if viewControllers.contains($0) == false {
                $0.willMove(toParentViewController: nil)
                $0.removeFromParent()
            }
        }
        
        // reset navigation bar
        self.navigationBar.items = nil
        
        // add items
        viewControllers.forEach {
            pushViewController($0, animated: animated && $0 === viewControllers.last)
        }
    }
}

 // MARK: - Pushing and Popping Stack Items

public extension UINavigationController {
    
    /// Pushes a view controller onto the receiver’s stack and updates the display.
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // assertions
        precondition(viewController is UITabBarController == false, "Cannot embed tab bar controller in navigation controller")
        precondition(viewControllers.contains(viewController) == false, "Already pushed view controller")
        precondition(viewController.parent == nil || viewController.parent == self, "Belongs to another parent \(viewController.parent!)")
        
        if viewController.parent !== self {
            
            addChild(viewController)
        }
        
        updateVisibleViewController(animated: animated)
        
        navigationBar.pushItem(viewController.navigationItem, animated: animated)
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

// MARK: - UINavigationBarDelegate

extension UINavigationController: UINavigationBarDelegate {
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool  {
        
        return true
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
        
        
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        
        return true
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        
        
    }
}
