//
//  UITableView.swift
//  Android
//
//  Created by Marco Estrella on 7/23/18.
//

import Foundation
import Android
import java_swift

final public class UITableView: UIView {
    
    // MARK: - Android
    
    internal var recyclerView: AndroidWidgetRecyclerView!
    
    // MARK: - Initialization
    
    public var style: UITableViewStyle!
    
    /// The object that acts as the data source of the table view.
    public weak var dataSource: UITableViewDataSource?
    
    // MARK: - Private
    
    internal static let defaultRowHeight: CGFloat = 44
    
    
    /// Initializes and returns a table view object having the given frame and style.
    public required init(frame: CGRect, style: UITableViewStyle = .plain) {
        
        // UITableView properties
        self.style = style
        
        guard let context = AndroidContext(casting: UIScreen.main.activity)
            else { fatalError("Missing context") }
        
        recyclerView = AndroidWidgetRecyclerView(context: context)
        
        recyclerView.layoutManager = AndroidWidgetRecyclerViewLinearLayoutManager(context: context)
        //recyclerView.
        
        super.init(frame: frame)
        // setup common
        //setupTableViewCommon()
    }
    
    /// Registers a class for use in creating new table cells.
    public func register(_ cellClass: UITableViewCell.Type?,
                         forCellReuseIdentifier identifier: String) {
        
    }
}

/// Default data source
final class DefaultDataSource: AndroidWidgetRecyclerViewAdapter, UITableViewDataSource {
    
    private var uiTable: UITableView!
    
    convenience init(uiTable: UITableView) {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.init(javaObject: nil)
        bindNewJavaObject()
        
        self.uiTable = uiTable
    }
    
    required convenience init(javaObject: jobject?) {
        self.init(javaObject: javaObject
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        fatalError("Should never request cell for table view with default data source")
    }
    
    public override func getItemCount() -> Int {
        return tableView(uiTable, numberOfRowsInSection: numberOfSections(in: uiTable))
    }
    
    public override func onCreateViewHolder(parent: Android.View.ViewGroup, viewType: Int?) -> AndroidWidgetRecyclerView.ViewHolder {
       // uiTable.register(, forCellReuseIdentifier: <#T##String#>)
        
    }
    
    public override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int) {
        let indexPath = IndexPath.init(index: IndexPath.Element.init(exactly: position)!)
        let view = tableView(uiTable, cellForRowAt: indexPath)
    }
}

public protocol UITableViewDataSource: class {
    
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
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

/// The position in the table view (top, middle, bottom) to which a given row is scrolled.
public enum UITableViewScrollPosition: Int {
    
    case none
    case top
    case middle
    case bottom
}

/// The type of animation when rows are inserted or deleted.
public enum UITableViewRowAnimation: Int {
    
    case fade
    case right
    case left
    case top
    case bottom
    case none
    case middle
    
    case automatic = 100
}

/// Requests icon to be shown in the section index of a table view.
///
/// If the data source includes this constant string in the array of strings it returns
/// in `sectionIndexTitles(for:)`, the section index displays a magnifying glass icon at
/// the corresponding index location. This location should generally be the first title in the index.
// http://stackoverflow.com/questions/235120/whats-the-uitableview-index-magnifying-glass-character
public let UITableViewIndexSearch: String = "{search}"

/// The default value for a given dimension.
///
/// Requests that UITableView use the default value for a given dimension.
public let UITableViewAutomaticDimension: CGFloat = -1.0

open class UITableViewRowAction {
    
}

/*
public protocol UITableViewDelegate: UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    
    func tableView(_ tableView: UITableView,
                   targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                   toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
}

public extension UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) { }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) { }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) { }
    
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) { }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return tableView.rowHeight }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return tableView.sectionHeaderHeight }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return tableView.sectionFooterHeight }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat { return tableView.estimatedRowHeight }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat { return tableView.estimatedSectionHeaderHeight }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat { return tableView.estimatedSectionFooterHeight }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { return nil }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?  { return nil }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool  { return true }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?  { return indexPath }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? { return indexPath }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle { return .delete }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? { return nil }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? { return nil }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool { return true }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) { }
    
    func tableView(_ tableView: UITableView,
                   targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                   toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        return proposedDestinationIndexPath
    }
}
 */
