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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("\(#function) \(view.frame)")
        
        view.backgroundColor = .blue

        let view1 = UIView()
        view1.backgroundColor = .red
        view.addSubview(view1)
        self.view1 = view1
        
        //let view2 = UIView(frame: CGRect(x: 10, y: 10, width: 580, height: 580))
        //view2.backgroundColor = .green
        //view1.addSubview(view2)
    }
    
    override func viewWillLayoutSubviews() {
        
        NSLog("\(#function) \(view.frame)")
        
        view1.frame = CGRect(x: 20, y: 20,
                             width: view.bounds.size.width - 40,
                             height: 512)
    }
    
    /*
    @objc func tapped(gesture: UITapGestureRecognizer) {
        print("tapped")
    }
    */
}
