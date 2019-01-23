//
//  TestToolbarActivity.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 8/29/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

/*
/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("TestToolbarActivity bind \(#function)")
    return TestToolbarActivity.self
}*/

// Like AppDelegate in iOS
final class TestToolbarActivity: SwiftSupportAppCompatActivity {
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        let metrics = AndroidDisplayMetrics()
        windowManager?.defaultDisplay?.getMetrics(outMetrics: metrics)
        
        let rootFrameLayout = AndroidWidgetFrameLayout.init(context: self)
        rootFrameLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)
        rootFrameLayout.setBackgroundColor(color: AndroidGraphicsColor.MAGENTA)
        
        let toolbar = AndroidToolbar(context: self)
        
        toolbar.context?.setTheme(resId: getIdentifier(name: "Dark_ActionBar", type: "style"))
        toolbar.popupTheme = getIdentifier(name: "Light", type: "style")
        
        toolbar.setX(x: 0.0)
        toolbar.setY(y: 0.0)
        toolbar.layoutParams = AndroidViewGroupLayoutParams(width: metrics.widthPixels, height: actionBarHeighPixels)
        
        let colorPrimaryId = getIdentifier(name: "colorPrimary", type: "color")
        toolbar.setBackgroundColor(color: AndroidContextCompat.getColor(context: self, colorRes: colorPrimaryId))
        
        toolbar.title = "Title"
        toolbar.subTitle = "Subtitle"
        
        let arrowBackId = getIdentifier(name: "ic_arrow_back_black", type: "drawable")
        let navigationIcon = AndroidVectorDrawableCompat.create(res: resources!, resId: arrowBackId, theme: nil)
        guard let navIcon = navigationIcon else { return }
        var navIconDrawable = navIcon as AndroidGraphicsDrawableDrawable
        navIconDrawable = AndroidDrawableCompat.wrap(drawable: navIconDrawable)
        AndroidDrawableCompat.setTint(drawable: navIconDrawable, color: AndroidGraphicsColor.WHITE)
        
        let androidId = getIdentifier(name: "ic_android_black", type: "drawable")
        let androidIconVectorDrawable = AndroidVectorDrawableCompat.create(res: resources!, resId: androidId, theme: nil)
        guard let androidIconVector = androidIconVectorDrawable else { return }
        var androidIconDrawable = androidIconVector as AndroidGraphicsDrawableDrawable
        androidIconDrawable = AndroidDrawableCompat.wrap(drawable: androidIconDrawable)
        AndroidDrawableCompat.setTint(drawable: androidIconDrawable, color: AndroidGraphicsColor.WHITE)
        
        let bluetoothId = getIdentifier(name: "ic_bluetooth", type: "drawable")
        let bluetoothIconVectorDrawable = AndroidVectorDrawableCompat.create(res: resources!, resId: bluetoothId, theme: nil)
        guard let bluetoothIconVector = bluetoothIconVectorDrawable else { return }
        var bluetoothIconDrawable = bluetoothIconVector as AndroidGraphicsDrawableDrawable
        bluetoothIconDrawable = AndroidDrawableCompat.wrap(drawable: bluetoothIconDrawable)
        AndroidDrawableCompat.setTint(drawable: bluetoothIconDrawable, color: AndroidGraphicsColor.WHITE)
        
        toolbar.navigationIcon = navIconDrawable
        toolbar.logo = androidIconDrawable
        
        let menu = toolbar.menu
        
        let menuItem1 = menu.add(groupId: 0, itemId: AndroidViewCompat.generateViewId(), order: 0, title: "SearchView")
        menuItem1.setShowAsAction(action: AndroidMenuItemForward.ShowAsAction.always)
        addSearchView(menuItem: menuItem1)
        /*
        menuItem1.setIcon(bluetoothIconDrawable)
        menuItem1.setShowAsAction(action: AndroidMenuItemForward.ShowAsAction.always)
        
        let menuItem2 = menu.add(groupId: 0, itemId: AndroidViewCompat.generateViewId(), order: 1, title: "Item 2")
                .setIcon(androidIconDrawable)
                .setShowAsAction(action: AndroidMenuItemForward.ShowAsAction.always)
        
        menu.add(groupId: 0, itemId: AndroidViewCompat.generateViewId(), order: 2, title: "Item 3")
        
        menu.add(groupId: 0, itemId: AndroidViewCompat.generateViewId(), order: 3, title: "Item 4")
        
        menu.add(groupId: 0, itemId: AndroidViewCompat.generateViewId(), order: 4, title: "Item 5")
        */
        rootFrameLayout.addView(toolbar)
        
        setContentView(view: rootFrameLayout)
        
        toolbar.setOnMenuItemClickListener { itemMenu in
            
            NSLog("selected item: \(itemMenu?.getTitle())")
            
            return true
        }
    }
    
    private func addSearchView(menuItem: AndroidMenuItemForward){
        
        let searchView = AndroidSearchView(context: self)
        searchView.layoutParams = AndroidFrameLayoutLayoutParams(width: AndroidFrameLayoutLayoutParams.WRAP_CONTENT, height: AndroidFrameLayoutLayoutParams.WRAP_CONTENT)
        searchView.setQueryHint("Write Something")
        
        menuItem.actionView = searchView
        
        searchView.setOnCloseListener { [weak self] in
            
            self?.toast("SeachView was closed")
            
            return false
        }
        
        searchView.setOnQueryTextListener(SearchViewQueryListener(self, searchView))
    }
}

class SearchViewQueryListener: AndroidSearchViewOnQueryTextListener {
    
    private var activity: SwiftSupportAppCompatActivity?
    private var searchView: AndroidSearchView?
    
    init(_ activity: SwiftSupportAppCompatActivity, _ searchView: AndroidSearchView) {
        
        super.init(javaObject: nil)
        self.bindNewJavaObject()
        
        self.activity = activity
        self.searchView = searchView
    }
    
    required public init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    override func onQueryTextChange(newText: String?) -> Bool {
        
        log("newText: \(newText)")
        //activity?.toast("newText: \(newText)")
        
        return false
    }
    
    override func onQueryTextSubmit(query: String?) -> Bool {
        
        activity?.toast("query: \(query)")
        
        //searchView?.setIconified(true)
        
        return false
    }
}
