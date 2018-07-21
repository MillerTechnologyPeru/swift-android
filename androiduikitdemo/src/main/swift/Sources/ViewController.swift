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
        
        NSLog("\(#function)")
        
        view.backgroundColor = .blue

        let view0 = UIView(frame: CGRect(x: 100, y: 100, width: 30, height: 30))
        view0.backgroundColor = .red
        view.addSubview(view0)
        
        let uiView1 = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        uiView1.backgroundColor = .purple
        view.addSubview(uiView1)
        
        let uiView2 = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        uiView2.backgroundColor = uiView1.backgroundColor
        view.addSubview(uiView2)
        /*
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
        view.addGestureRecognizer(gesture)
        */
//        view.isUserInteractionEnabled = false
        uiView1.isOpaque = false
        uiView1.center = view.center
        uiView2.frame = CGRect(x: 0, y: view.frame.height - uiView1.frame.height, width: uiView1.frame.width, height: uiView1.frame.height)
    }
    
    /*
    @objc func tapped(gesture: UITapGestureRecognizer) {
        print("tapped")
    }
    */
}
