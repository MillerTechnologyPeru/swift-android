//
//  ViewController.swift
//  iOSDemo
//
//  Created by Carlos Duclos on 7/19/18.
//

import Foundation

#if os(iOS)
import UIKit
#else
import Android
//import AndroidUIKit
#endif

final class MainViewController: UIViewController {
    
    private(set) weak var view1: UIView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    #if os(iOS)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    #endif
    
    //override var prefersStatusBarHidden: Bool { return true }
    
    override func loadView() {
        
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("\(#function) \(view.frame)")
        
        view.backgroundColor = .blue

        let view1 = UIView(frame: CGRect(x: 20, y: 20,
                                         width: view.bounds.size.width - 40,
                                         height: view.bounds.size.height / 2.0))
        //view1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view1.backgroundColor = .red
        view.addSubview(view1)
        self.view1 = view1
        
        //let view2 = UIView(frame: CGRect(x: 10, y: 10, width: 580, height: 580))
        //view2.backgroundColor = .green
        //view1.addSubview(view2)
        
        printViews()
    }
    
    /*
    override func viewWillLayoutSubviews() {
        
        NSLog("\(#function) \(view.frame)")
        
        view1.frame = CGRect(x: 20, y: 20,
                             width: view.bounds.size.width - 40,
                             height: view.bounds.size.height / 2.0)
    }*/
    
    override func viewDidLayoutSubviews() {
        
        NSLog("\(#function)")
        
        printViews()
    }
    
    private func printViews() {
        
        NSLog("\(#function)")
        NSLog("View: \(view.frame)")
        NSLog("View1: \(view1.frame)")
    }
    
    /*
    @objc func tapped(gesture: UITapGestureRecognizer) {
        print("tapped")
    }
    */
}
