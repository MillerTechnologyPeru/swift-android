//
//  TestUISearchController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 1/8/19.
//

import Foundation

#if os(iOS)
import UIKit
#else
import Android
import AndroidUIKit
#endif

final class TestUISearchController: UIViewController {
    
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
        
        navigationItem.title = "Test UISearchController"
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        
        navigationItem.searchController = search
    }
}

extension TestUISearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text
            else { return }
        
        log(text)
    }
}
