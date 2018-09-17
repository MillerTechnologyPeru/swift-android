//
//  TestRefreshControlViewController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 9/14/18.
//

import Foundation

#if os(iOS)
import UIKit
#else
import Android
//import AndroidUIKit
#endif

final class TestRefreshControlViewController: UITableViewController {
    
    private var data: [String] = []
    
    private let cellReuseIdentifier = "Cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title
        self.title = "Test UIRefreshControl"
        
        // setup table view
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
        
        for i in 0...10 {
            data.append("item \(i)")
        }
        
        let refreshControl = UIRefreshControl()
        
        let actionRefresh: () -> () = {
            
            AndroidToast.makeText(context: UIScreen.main.activity, text: "I'm refreshing, Madafaqas", duration: AndroidToast.Dutation.short).show()
            
            let delay = DispatchTime.now() + .seconds(3)
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) {
                #if os(Android)
                UIScreen.main.activity.runOnMainThread { [weak self] in
                    
                    refreshControl.endRefreshing()
                }
                #endif
            }
        }
        
        refreshControl.addTarget(action: actionRefresh, for: UIControlEvent.touchDown)
        
        self.refreshControl = refreshControl
        
        let delay = DispatchTime.now() + .seconds(10)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) {
            
            UIScreen.main.activity.runOnMainThread { [weak self] in
                
                self?.refreshControl = nil
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let item = data[indexPath.max()!]
        
        cell.textLabel?.text = item
        
        return cell
    }
}
