//
//  UISearchBarViewControler.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 1/7/19.
//

import Foundation

#if os(iOS)
import UIKit
#else
import Android
import AndroidUIKit
#endif

final class UISearchBarViewControler: UIViewController {
    
    private var tableView: UITableView?
    
    var searchActive : Bool = false
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var filtered:[String] = []
    
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
        
        self.view.backgroundColor = .white
        
        navigationItem.title = "Test SearchBar"
        
        let searchBar = UISearchBar(frame: CGRect(x: 20, y: 10, width: 250, height: 50))
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        #if os(Android) || os(macOS)
        searchBar.androidSearchViewExpand()
        #endif
        
        self.view.addSubview(searchBar)
        
        tableView = UITableView(frame: CGRect(x: 10, y: 75, width: 200, height: 300))
        
        guard let tableView = tableView else {
            fatalError("Missing table view")
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(tableView)
    }
}

extension UISearchBarViewControler: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)
        
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row];
        }
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
}

extension UISearchBarViewControler: UITableViewDelegate {
    
    
}

extension UISearchBarViewControler: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {
        
        log("textDidChange = \(textDidChange)")
        
        filtered = data.filter { $0.lowercased().contains(textDidChange) }
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView?.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        log("\(#function)")
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        log("\(#function)")
        searchActive = false;
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        log("\(#function)")
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        log("\(#function)")
        searchActive = false;
    }
}
