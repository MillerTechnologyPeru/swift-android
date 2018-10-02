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
import AndroidUIKit
#endif

final class TestRefreshControlViewController: UITableViewController {
    
    private let cellReuseIdentifier = "Cell"
    
    var data: [Data] = [
        Data(type: "type 1", array: ["item 1","item 2","item 3","item 4","item 5"]),
        Data(type: "type 2", array: ["item 1","item 2","item 3","item 4"]),
        Data(type: "type 3", array: ["item 1","item 2"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title
        self.title = "Test UIRefreshControl"
        
        // setup table view
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
        
        let refreshControl = UIRefreshControl()
        
        let actionRefresh: () -> () = {
            
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "I'm refreshing, :)", duration: AndroidToast.Dutation.short).show()
            
            let delay = DispatchTime.now() + .seconds(3)
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) {
                #if os(Android)
                UIApplication.shared.androidActivity.runOnMainThread { [weak self] in
                    
                    refreshControl.endRefreshing()
                }
                #endif
            }
        }
        
        refreshControl.addTarget(action: actionRefresh, for: UIControlEvents.touchDown)
        
        self.refreshControl = refreshControl
        
        /*let delay = DispatchTime.now() + .seconds(10)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) {
            
            UIApplication.shared.androidActivity.runOnMainThread { [weak self] in
                
                self?.refreshControl = nil
            }
        }*/
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let peripheralViewLayoutId = UIApplication.shared.androidActivity.getIdentifier(name: "list_header", type: "layout")
        
        let layoutInflarer = Android.View.LayoutInflater.from(context: UIApplication.shared.androidActivity)
        
        let itemView = layoutInflarer.inflate(resource: Android.R.Layout(rawValue: peripheralViewLayoutId), root: nil, attachToRoot: false)
        
        let tvHeaderId = UIApplication.shared.androidActivity.getIdentifier(name: "tvHeader", type: "id")
        
        guard let tvHeaderObject = itemView.findViewById(tvHeaderId)
            else { fatalError("No view for \(tvHeaderId)") }
        
        let tvHeader = Android.Widget.TextView(casting: tvHeaderObject)
        
        tvHeader?.text = data[section].type
        
        let uiView = UIView.init(androidViewChild: itemView)
        
        uiView.androidView.layoutParams = Android.Widget.FrameLayout.FLayoutParams(width: Android.Widget.FrameLayout.FLayoutParams.MATCH_PARENT, height: Android.Widget.FrameLayout.FLayoutParams.WRAP_CONTENT)
        
        return uiView
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data[section].array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        NSLog("section: \(indexPath.section) - row: \(indexPath.row)")
        
        let item = data[indexPath.section].array[indexPath.row]
        
        cell.textLabel?.text = item
        
        return cell
    }
    
    
}

struct Data {
    
    let type: String
    let array: [String]
}
