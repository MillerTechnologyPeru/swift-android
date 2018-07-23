//
//  UITableView.swift
//  Android
//
//  Created by Marco Estrella on 7/23/18.
//

import Foundation

final public class UITableView {
    
    public var style: UITableViewStyle!
    
    // MARK: - Initialization
    
    /// Initializes and returns a table view object having the given frame and style.
    public required init(frame: CGRect, style: UITableViewStyle) {
        
        // UITableView properties
        self.style = style
        
        // setup common
        //setupTableViewCommon()
    }
    
    public convenience init(frame: CGRect) {
        
        self.init(frame: frame, style: .plain)
    }
    
    // MARK: - Private
    
    internal static let defaultRowHeight: CGFloat = 44
}

public protocol UITableViewDataSource: class {
    
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    //func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

public extension UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
}

// MARK: - Supporting Types

/// The style of the table view.
public enum UITableViewStyle: Int {
    
    case plain
    case grouped
}
