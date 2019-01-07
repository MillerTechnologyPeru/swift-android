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
        
        navigationItem.title = "Test SearchBar"
        
        let searchBar = UISearchBar(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        
        self.view.addSubview(searchBar)
    }
}

extension UISearchBarViewControler: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {
        
        log("textDidChange = \(textDidChange)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        log("\(#function)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let query = searchBar.text
        
        log("\(#function): query: \(query)")
        
        searchBar.text = ""
    }
}
