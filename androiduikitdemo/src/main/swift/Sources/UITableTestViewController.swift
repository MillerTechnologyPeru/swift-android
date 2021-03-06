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
        
        tableView = UITableView(frame: .zero)
        
        guard let tableView = tableView else {
            fatalError("Missing table view")
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(tableView)
    
        for i in 0...20 {
            data.append("item \(i)")
        }
        
        navigationItem.title = "UITableView"
        
        let leftItem = UIBarButtonItem.init(title: "Views", style: .done, target: nil, action: nil)
        #if os(Android) || os(macOS)
        leftItem.action = {
            NSLog("Clicked on Views")
            let child2ViewController = MainViewController()
            self.navigationController?.pushViewController(child2ViewController, animated: false)
        }
        #endif
        
        let rightItem = UIBarButtonItem.init(title: "RB", style: .done, target: nil, action: nil)
        #if os(Android) || os(macOS)
        rightItem.action = {
            NSLog("Hello Right Button")
        }
        #endif
        
        let rightItem2 = UIBarButtonItem.init(title: "RB", style: .done, target: nil, action: nil)
        #if os(Android) || os(macOS)
        rightItem2.action = {
            NSLog("Hello Right Button 2")
        }
        #endif
        
        let rightItem3 = UIBarButtonItem.init(title: "RB", style: .done, target: nil, action: nil)
        #if os(Android) || os(macOS)
        rightItem3.action = {
            NSLog("Hello Right Button 3")
        }
        #endif
        
        let rightItem4 = UIBarButtonItem.init(title: "RB", style: .done, target: nil, action: nil)
        #if os(Android) || os(macOS)
        rightItem4.action = {
            NSLog("Hello Right Button 4")
        }
        #endif
        
        navigationItem.leftBarButtonItem = leftItem
        
        navigationItem.rightBarButtonItems = [rightItem, rightItem2, rightItem3, rightItem4]
        
        
        //TOOLBAR
        
        #if os(Android) || os(macOS)
         var items = [UIBarButtonItem]()
        
        let toolbarItem1 = UIBarButtonItem(title: "Breakfast", style: .done, target: self) {
            
            NSLog("Toolbar Item 1 clicked")
        }
        toolbarItem1.image = UIImage(named: "ic_free_breakfast")
        
        let toolbarItem2 = UIBarButtonItem(title: "Restaurant", style: .done, target: self) {
            
            NSLog("Toolbar Item 2 clicked")
        }
        toolbarItem2.image = UIImage.init(named: "ic_restaurant_menu")
        
        let toolbarItem3 = UIBarButtonItem(title: "Chat", style: .done, target: self) {
            
            NSLog("Toolbar Item 3 clicked")
        }
        toolbarItem3.image = UIImage(named: "ic_chat")
        
        items.append(toolbarItem1)
        items.append(toolbarItem2)
        items.append(toolbarItem3)
        
        
        self.navigationController?.toolbar.items = items
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = false
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
            
            #if os(Android) || os(macOS)
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed default 0", duration: AndroidToast.Dutation.short).show()
            #endif
            print("You've pressed default 0");
        }
        
        let action12 = UIAlertAction.init(title: "Default 1", style: UIAlertActionStyle.default) { action in
            
            #if os(Android) || os(macOS)
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed default 1 ", duration: AndroidToast.Dutation.short).show()
            #endif
            print("You've pressed default 1");
        }
        
        let action13 = UIAlertAction.init(title: "Default 2", style: UIAlertActionStyle.default) { action in
            
            #if os(Android) || os(macOS)
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed default 2", duration: AndroidToast.Dutation.short).show()
            #endif
            print("You've pressed default 2");
        }
        
        let action14 = UIAlertAction.init(title: "Default 3", style: UIAlertActionStyle.default) { action in
            
            #if os(Android) || os(macOS)
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed default 3", duration: AndroidToast.Dutation.short).show()
            #endif
            print("You've pressed default 3");
        }

        let action2 = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { action in
            
            #if os(Android) || os(macOS)
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed cancel", duration: AndroidToast.Dutation.short).show()
            #endif
            print("You've pressed cancel");
        }
        
        let action22 = UIAlertAction.init(title: "Cancel 2", style: UIAlertActionStyle.cancel) { action in
            
            #if os(Android) || os(macOS)
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed cancel 2", duration: AndroidToast.Dutation.short).show()
            #endif
            print("You've pressed cancel 2");
        }
        
        let action3 = UIAlertAction.init(title: "Destructive", style: UIAlertActionStyle.destructive) { action in
            
            #if os(Android) || os(macOS)
            AndroidToast.makeText(context: UIApplication.shared.androidActivity, text: "You've pressed the destructive", duration: AndroidToast.Dutation.short).show()
            #endif
            print("You've pressed the destructive");
        }
        
        alertController.addAction(action1)
//        alertController.addAction(action12)
//        alertController.addAction(action13)
//        alertController.addAction(action14)
//        alertController.addAction(action2)
//        alertController.addAction(action22)
        alertController.addAction(action3)
        
        alertController.addTextField(configurationHandler: { text in text.placeholder = "FullName" })
        alertController.addTextField()
    
        self.present(alertController, animated: false, completion: nil)
    }
    
}
