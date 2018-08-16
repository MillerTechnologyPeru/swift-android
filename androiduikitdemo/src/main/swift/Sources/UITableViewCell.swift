//
//  UITableViewCell.swift
//  Android
//
//  Created by Marco Estrella on 7/23/18.
//

import Foundation
import Android
import java_swift

/// A cell in a table view.
///
/// This class includes properties and methods for setting and managing cell content
/// and background (including text, images, and custom views), managing the cell
/// selection and highlight state, managing accessory views, and initiating the
/// editing of the cell contents.
open class UITableViewCell: UIView {
    
    /// A string used to identify a cell that is reusable.
    public let reuseIdentifier: String?
    
    public let style: UITableViewCellStyle?
    
    public var textLabel: UILabel?
    
    internal var defaultViewHolder: DefaultViewHolder?
    // MARK: - Private
    
    internal static let defaultSize = CGSize(width: 320, height: UITableView.defaultRowHeight)
    
    // MARK: - Initializing a `UITableViewCell` Object
    
    /// Initializes a table cell with a style and a reuse identifier and returns it to the caller.
    public required init(style: UITableViewCellStyle = UITableViewCellStyle.default, reuseIdentifier: String?) {
        
        self.style = style
        self.reuseIdentifier = reuseIdentifier
        
        // while `UIView.init()` creates a view with an empty frame,
        // UIKit creates a {0,0, 320, 44} cell with this initializer
        let frame = CGRect(origin: .zero, size: UITableViewCell.defaultSize)
        
        super.init(frame: frame)
        
        NSLog("\((type: self)) \(#function)")
        
        textLabel = UILabel.init(frame: frame)
        //self.setupTableViewCellCommon()
        
        defaultViewHolder = DefaultViewHolder.init(tableViewCell: self)
    }
}

internal class DefaultViewHolder: AndroidWidgetRecyclerViewViewHolder {
    
    var textLabel: Android.Widget.TextView?
    
    convenience init(tableViewCell: UITableViewCell){
        
        self.init(javaObject: nil)
        bindNewJavaObject(itemView: tableViewCell.androidView)
        
        self.textLabel = tableViewCell.textLabel?.androidTextView
        
        NSLog("\((type: self)) \(#function)")
    }
    
    required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
}

// MARK: - Supporting Types

public enum UITableViewCellSeparatorStyle: Int {
    
    case none
    case singleLine
    case singleLineEtched
}

public enum UITableViewCellStyle: Int {
    
    case `default`
    case value1
    case value2
    case subtitle
}

public enum UITableViewCellSelectionStyle: Int {
    
    case none
    case blue
    case gray
}

public enum UITableViewCellEditingStyle: Int {
    
    case none
    case delete
    case insert
}
