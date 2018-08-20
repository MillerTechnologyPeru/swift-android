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

final class UITableTestViewController: UIViewController, UITableViewDataSource {
    
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
        
        for i in 0...100 {
            data.append("item \(i)")
        }
        
        //let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        //let displayWidth: CGFloat = view.frame.width
        //let displayHeight: CGFloat = view.frame.height
        let displayWidth: CGFloat = UIScreen.main.bounds.width
        let displayHeight: CGFloat = UIScreen.main.bounds.height
        
        NSLog("\(#function) displayWidth = \(displayWidth) ")
        NSLog("\(#function) displayHeight = \(displayHeight) ")
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: 700))
        
        guard let tableView = tableView else {
            fatalError("Missing table view")
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 20 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")
        
        //let text = data[indexPath.row]
        
        //cell.textLabel?.text = text
        
        return cell
    }
    
}
