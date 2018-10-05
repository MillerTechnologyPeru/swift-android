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
import AndroidUIKit
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
        
        let refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        
        
        let actionRefresh: () -> () = {
            
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "I'm refreshing :)", duration: AndroidToast.Dutation.short).show()
            
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
        //refreshControl.backgroundColor = UIColor.cyan
        
        //self.view.androidView.addView(refreshControl.androidSwipeRefreshLayout)
        //self.view.addSubview(refreshControl)
        
        tableView = UITableView(frame: .zero)
        
        guard let tableView = tableView else {
            fatalError("Missing table view")
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tableView.frame = refreshControl.frame
        //refreshControl.androidSwipeRefreshLayout.addView(tableView.androidView)
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
        
        navigationItem.title = "UITableView"
        navigationItem.hidesBackButton = true
        
        let leftItem = UIBarButtonItem.init(title: "Views", style: .done, target: nil, action: nil)
        leftItem.action = {
            NSLog("Clicked on Views")
            let child2ViewController = MainViewController()
            self.navigationController?.pushViewController(child2ViewController, animated: false)
        }
        
        let rightItem = UIBarButtonItem.init(title: "RB", style: .done, target: nil, action: nil)
        rightItem.action = {
            NSLog("Hello Right Button")
        }
        
        let rightItem2 = UIBarButtonItem.init(title: "RB", style: .done, target: nil, action: nil)
        rightItem2.action = {
            NSLog("Hello Right Button 2")
        }
        
        
        let rightItem3 = UIBarButtonItem.init(title: "RB", style: .done, target: nil, action: nil)
        rightItem3.action = {
            NSLog("Hello Right Button 3")
        }
        
        let rightItem4 = UIBarButtonItem.init(title: "RB", style: .done, target: nil, action: nil)
        rightItem4.action = {
            NSLog("Hello Right Button 4")
        }
        
        navigationItem.leftBarButtonItem = leftItem
        
        navigationItem.rightBarButtonItems = [rightItem, rightItem2, rightItem3, rightItem4]
        
        /*
        let delay2 = DispatchTime.now() + .seconds(3)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: delay2) {
            #if os(Android)
            UIScreen.main.activity.runOnMainThread { [weak self] in
                
                let child2ViewController = MainViewController()
                self?.navigationController?.pushViewController(child2ViewController, animated: false)
            }
            #endif
        }*/
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
        
        let alertController = UIAlertController.init(title: "Title", message: "message", preferredStyle: UIAlertControllerStyle.alert)
        
        let action1 = UIAlertAction.init(title: "Default 0", style: UIAlertActionStyle.default) { action in
            
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed default 0", duration: AndroidToast.Dutation.short).show()
            print("You've pressed default 0");
        }
        
        let action12 = UIAlertAction.init(title: "Default 1", style: UIAlertActionStyle.default) { action in
            
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed default 1 ", duration: AndroidToast.Dutation.short).show()
            print("You've pressed default 1");
        }
        
        let action13 = UIAlertAction.init(title: "Default 2", style: UIAlertActionStyle.default) { action in
            
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed default 2", duration: AndroidToast.Dutation.short).show()
            print("You've pressed default 2");
        }
        
        let action14 = UIAlertAction.init(title: "Default 3", style: UIAlertActionStyle.default) { action in
            
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed default 3", duration: AndroidToast.Dutation.short).show()
            print("You've pressed default 3");
        }

        let action2 = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { action in
            
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed cancel", duration: AndroidToast.Dutation.short).show()
            print("You've pressed cancel");
        }
        
        let action22 = UIAlertAction.init(title: "Cancel 2", style: UIAlertActionStyle.cancel) { action in
            
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed cancel 2", duration: AndroidToast.Dutation.short).show()
            print("You've pressed cancel 2");
        }
        
        let action3 = UIAlertAction.init(title: "Destructive", style: UIAlertActionStyle.destructive) { action in
            
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed the destructive", duration: AndroidToast.Dutation.short).show()
            print("You've pressed the destructive");
        }
        
        alertController.addAction(action1)
//        alertController.addAction(action12)
//        alertController.addAction(action13)
//        alertController.addAction(action14)
//        alertController.addAction(action2)
//        alertController.addAction(action22)
        alertController.addAction(action3)
        
        alertController.addTextField(configurationHandler: { text in text.placeHolder = "FullName" })
        alertController.addTextField()
    
        self.present(alertController, animated: false, completion: nil)
    }
    
}
