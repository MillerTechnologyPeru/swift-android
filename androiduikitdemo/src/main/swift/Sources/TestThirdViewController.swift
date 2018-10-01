//
//  TestThirdViewController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 9/3/18.
//

import Foundation


#if os(iOS)
import UIKit
#else
import Android
import AndroidUIKit
#endif

final class TestThirdViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    #if os(iOS)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    #endif
    
    override func viewDidLoad() {
        NSLog("viewDidLoad")
        
        view.backgroundColor = UIColor.cyan
        
        navigationItem.title = "Test Third"
    }
}

