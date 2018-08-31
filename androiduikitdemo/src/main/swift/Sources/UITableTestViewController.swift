//
//  UITableTestViewController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 8/16/18.
//

import Foundation

#if os(iOS)
import UIKit
#else
import Android
//import AndroidUIKit
#endif

final class UITableTestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    #if os(iOS)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    #endif
    
    private var tableView: UITableView?
    
    private var data: [String] = []
    
    override func viewDidLoad() {
        
        let displayWidth: CGFloat = UIScreen.main.bounds.width
        let displayHeight: CGFloat = UIScreen.main.bounds.height
        
        NSLog("\(#function) displayWidth = \(displayWidth) ")
        NSLog("\(#function) displayHeight = \(displayHeight) ")
        
        view.backgroundColor = UIColor.cyan
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        
        guard let tableView = tableView else {
            fatalError("Missing table view")
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        for i in 0...100 {
            data.append("item \(i)")
        }
        
        /*
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) {
            for i in 101...200 {
                self.data.append("item \(i)")
                NSLog("item \(i)")
            }
            #if os(Android)
            UIScreen.main.activity.runOnMainThread { [weak self] in
                self?.tableView?.reloadData()
            }
            #elseif os(iOS)
            DispatchQueue.main.async {  [weak self] in
                
                self?.tableView?.reloadData()
            }
            #endif
        }*/
        
        let delay2 = DispatchTime.now() + .seconds(3)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: delay2) {
            #if os(Android)
            UIScreen.main.activity.runOnMainThread { [weak self] in
                
                let child2ViewController = MainViewController()
                self?.navigationController?.pushViewController(child2ViewController, animated: false)
            }
            #endif
        }
        
        navigationItem.title = "UITableView"
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")
            else { fatalError("Could not dequeue cell") }
        
        let text = data[indexPath.row]
        
        cell.textLabel?.text = "Data item: \(text)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        NSLog("Click on Data item: \(data[indexPath.row])")
    }
    
}
