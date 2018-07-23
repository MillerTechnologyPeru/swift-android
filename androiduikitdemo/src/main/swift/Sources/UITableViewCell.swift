//
//  UITableViewCell.swift
//  Android
//
//  Created by Marco Estrella on 7/23/18.
//

import Foundation

/// A cell in a table view.
///
/// This class includes properties and methods for setting and managing cell content
/// and background (including text, images, and custom views), managing the cell
/// selection and highlight state, managing accessory views, and initiating the
/// editing of the cell contents.
open class UITableViewCell: UIView {
    
    // MARK: - Initializing a `UITableViewCell` Object
    
    /// Initializes a table cell with a style and a reuse identifier and returns it to the caller.
    public required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.style = style
        self.reuseIdentifier = reuseIdentifier
        
        // while `UIView.init()` creates a view with an empty frame,
        // UIKit creates a {0,0, 320, 44} cell with this initializer
        super.init(frame: CGRect(origin: .zero, size: UITableViewCell.defaultSize))
        
        //self.setupTableViewCellCommon()
    }
    
    // MARK: - Reusing Cells
    
    /// A string used to identify a cell that is reusable.
    public let reuseIdentifier: String?
    
    public let style: UITableViewCellStyle?
    
    // MARK: - Private
    
    internal static let defaultSize = CGSize(width: 320, height: UITableView.defaultRowHeight)
}

// MARK: - Supporting Types

public enum UITableViewCellStyle: Int {
    
    case `default`
    case value1
    case value2
    case subtitle
}
