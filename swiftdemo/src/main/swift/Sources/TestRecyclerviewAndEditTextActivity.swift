//
//  TestRecyclerviewAndEditTextActivity.swift
//  Android
//
//  Created by Marco Estrella on 1/23/19.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("TestRecyclerviewAndEditTextActivity bind \(#function)")
    return TestRecyclerviewAndEditTextActivity.self
}

// Like AppDelegate in iOS
final class TestRecyclerviewAndEditTextActivity: SwiftSupportAppCompatActivity {
    
    private var recyclerViewTotalHeight = 0
    private var adapter: MyAdapter?
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        let metrics = AndroidDisplayMetrics()
        windowManager?.defaultDisplay?.getMetrics(outMetrics: metrics)
        
        let metrics2 = resources!.getDisplayMetrics()!
        
        log("w: \(metrics.widthPixels) - h: \(metrics.heightPixels)")
        log("w: \(metrics2.widthPixels) - h: \(metrics2.heightPixels)")
        
        let dp150 = Int(metrics.density * 150)
        
        let rootFrameLayout = AndroidWidgetFrameLayout(context: self)
        rootFrameLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)
        rootFrameLayout.setBackgroundColor(color: AndroidGraphicsColor.WHITE)
        
        let textView = AndroidTextView(context: self)
        textView.setBackgroundColor(color: AndroidGraphicsColor.BLUE)
        textView.layoutParams = AndroidFrameLayoutLayoutParams.init(width: AndroidFrameLayoutLayoutParams.MATCH_PARENT, height: dp150)
        
        recyclerViewTotalHeight = metrics2.heightPixels - dp150 - 48
        
        let recyclerView = AndroidWidgetRecyclerView(context: self)
        recyclerView.layoutParams = AndroidFrameLayoutLayoutParams.init(width: AndroidFrameLayoutLayoutParams.MATCH_PARENT, height: recyclerViewTotalHeight)
        recyclerView.layoutManager = AndroidWidgetRecyclerViewLinearLayoutManager(context: self)
        recyclerView.setBackgroundColor(color: AndroidGraphicsColor.CYAN)
        recyclerView.setY(y: Float(dp150))
        
        adapter = MyAdapter(recyclerView: recyclerView, recyclerViewHeight: recyclerViewTotalHeight, activity: self, list: getList())
        
        recyclerView.adapter = adapter!
        
        rootFrameLayout.addView(textView)
        rootFrameLayout.addView(recyclerView)
        
        setContentView(view: rootFrameLayout)
    }
    
    override func onResume() {
        
    }
    
    override func onPause() {
        
        
    }
    
    private func getList() -> [String] {
        
        var list = [String]()
       
        list.append("Texto 1")
        list.append("Texto 2")
        list.append("Texto 3")
        list.append("Texto 4")
        list.append("Texto 5")
        list.append("Texto 6")
        list.append("Texto 7")
        list.append("Texto 8")
        list.append("Texto 9")
        list.append("Texto 10")
        list.append("Texto 11")
        list.append("Texto 12")
        list.append("Texto 13")
        list.append("Texto 14")
        list.append("Texto 15")
        list.append("Texto 16")
        list.append("Texto 17")
        list.append("Texto 18")
        list.append("Texto 19")
        list.append("Texto 20")
        
        return list
    }

}

class MyAdapter: Android.Widget.RecyclerView.Adapter {
    
    public var selectedEditText: AndroidEditText?
    public var keyBoardHeight = 0
    private var counter = 0
    
    private var recyclerView: AndroidWidgetRecyclerView?
    private var activity: SwiftSupportAppCompatActivity?
    private var recyclerViewHeight = 0
    
    private lazy var list: [String] = {
        return [String]()
    }()
    
    public required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    convenience init(recyclerView: AndroidWidgetRecyclerView, recyclerViewHeight: Int, activity: SwiftSupportAppCompatActivity, list: [String]) {
        
        NSLog("\(type(of: self)) \(#function)")
        
        self.init(javaObject: nil)
        bindNewJavaObject()
        
        self.recyclerView = recyclerView
        self.activity = activity
        self.list = list
        self.recyclerViewHeight = recyclerViewHeight
        
        log("recyclerView.height: \(recyclerViewHeight)")
    }
    
    override func onCreateViewHolder(parent: Android.View.ViewGroup, viewType: Int?) -> AndroidWidgetRecyclerView.ViewHolder {
        
        guard let activity = activity
            else { return AndroidWidgetRecyclerView.ViewHolder() }

        let density = activity.density
        
        let dp12 = Int(12 * density)
        
        let linearLayout = Android.Widget.LinearLayout.init(context: activity)
        linearLayout.layoutParams = AndroidFrameLayoutLayoutParams.init(width: AndroidFrameLayoutLayoutParams.MATCH_PARENT, height: AndroidFrameLayoutLayoutParams.WRAP_CONTENT)
        linearLayout.setPadding(left: dp12, top: dp12, right: dp12, bottom: dp12)
        linearLayout.orientation = Android.Widget.LinearLayout.HORIZONTAL
        
        let textView = AndroidTextView.init(context: activity)
        textView.text = "title:"
        textView.layoutParams = AndroidFrameLayoutLayoutParams.init(width: AndroidFrameLayoutLayoutParams.WRAP_CONTENT, height: AndroidFrameLayoutLayoutParams.WRAP_CONTENT)
        textView.color = AndroidGraphicsColor.BLACK
        
        let editText = AndroidEditText.init(context: activity)
        editText.color = AndroidGraphicsColor.BLUE
        
        let layoutParams = AndroidFrameLayoutLayoutParams.init(width: AndroidFrameLayoutLayoutParams.MATCH_PARENT, height: AndroidFrameLayoutLayoutParams.WRAP_CONTENT)
        layoutParams.marginStart = dp12
    
        editText.layoutParams = layoutParams
        
        linearLayout.addView(textView)
        linearLayout.addView(editText)
        
        return ItemViewHolder.init(itemView: linearLayout, mainActivity: activity)
    }
    
    override func onBindViewHolder(holder: AndroidWidgetRecyclerView.ViewHolder, position: Int) {
        
        let itemVH = holder as! ItemViewHolder
        itemVH.bind(item: self.list[position])
        
        itemVH.etDetail?.setOnFocusChangeListener{ [weak self] view, hasFocus  in
            
            if(hasFocus){
                
                self?.selectedEditText = itemVH.etDetail
                if (self?.counter == 0){
                    
                    self?.counter += 1
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                        
                        self?.activity?.runOnMainThread {
                            
                            self?.reduceRecyclerviewHeight()
                        }
                    }
                } else {
                    
                    self?.reduceRecyclerviewHeight()
                    self?.showKeyBoard(view: view!)
                }
            }
        }
    }
    
    override func getItemCount() -> Int {
        return self.list.count
    }
    
    private func showKeyBoard(view: AndroidView){
        
        let imm = activity!.systemService(AndroidInputMethodManager.self)
        imm?.showSoftInput(view: view, flags: AndroidInputMethodManager.SHOW_IMPLICIT)
    }
    
    private func reduceRecyclerviewHeight(){
        
        guard let recyclerView = recyclerView
            else { return }
        
        let newHeight = recyclerViewHeight - keyBoardHeight
        
        recyclerView.layoutParams = AndroidFrameLayoutLayoutParams(width: AndroidFrameLayoutLayoutParams.MATCH_PARENT, height: newHeight)
    }
    
    class ItemViewHolder: Android.Widget.RecyclerView.ViewHolder {
        
        fileprivate var tvTitle: Android.Widget.TextView?
        fileprivate var etDetail: Android.Widget.EditText?
        
        convenience init(itemView: Android.View.View, mainActivity: SwiftSupportAppCompatActivity) {
            NSLog("\(type(of: self)) \(#function)")
            
            self.init(javaObject: nil)
            
            bindNewJavaObject(itemView: itemView)
            
            guard let linearLayout = AndroidLinearLayout.init(casting: itemView)
                else { return }
            
            self.tvTitle = Android.Widget.TextView(casting: linearLayout.getChildAt(index: 0))
            self.etDetail = Android.Widget.EditText(casting: linearLayout.getChildAt(index: 1))
            
            guard let etDetail = self.etDetail
                else { return }
            
            etDetail.setShowSoftInputOnFocus(false)
        }
        
        
        
        required init(javaObject: jobject?) {
            super.init(javaObject: javaObject)
        }
        
        public func bind(item: String) {
            
            etDetail?.text = item
        }
        
    }
}
