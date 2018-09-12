//
//  TestAlertDialogActivity.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 9/10/18.
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
    NSLog("TestAlertDialogActivity bind \(#function)")
    return TestAlertDialogActivity.self
}*/

// Like AppDelegate in iOS
final class TestAlertDialogActivity: SwiftSupportAppCompatActivity {
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        let metrics = AndroidDisplayMetrics()
        windowManager?.defaultDisplay?.getMetrics(outMetrics: metrics)
        
        let rootFrameLayout = AndroidWidgetFrameLayout.init(context: self)
        rootFrameLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)
        rootFrameLayout.setBackgroundColor(color: AndroidGraphicsColor.CYAN)
        
        let buttonWidth = Int(150 * metrics.density)
        let buttonHeight = Int(80 * metrics.density)
        
        let layoutparams = AndroidFrameLayoutLayoutParams(width: buttonWidth, height: buttonHeight)
        
        let margin = Int(16 * metrics.density)
        
        layoutparams.setMargins(left: margin, top: margin, right: margin, bottom: margin)
        
        let button1 = AndroidButton.init(context: self)
        button1.layoutParams = layoutparams
        button1.text = "Show Alert 1"
        
        let button2 = AndroidButton.init(context: self)
        button2.layoutParams = layoutparams
        button2.text = "Show Alert 2"
        button2.setY(y: 120 * metrics.density)
        
        let button3 = AndroidButton.init(context: self)
        button3.layoutParams = layoutparams
        button3.text = "Show Alert 3"
        button3.setY(y: 300 * metrics.density)
        
        rootFrameLayout.addView(button1)
        rootFrameLayout.addView(button2)
        rootFrameLayout.addView(button3)
        
        setContentView(view: rootFrameLayout)
        
        button1.setOnClickListener {
            
            self.showAlert1()
        }
        
        button2.setOnClickListener {
            
            self.showAlert2()
        }
        
        button3.setOnClickListener {
            
            self.showAlert3()
        }
    }
    
    private func showAlert1(){
        
        AndroidAlertDialog.Builder.init(context: self)
            .setTitle(title: "Title")
            .setMessage(message: "Message message message")
            .setPositiveButton(text: "OK", { dialog, which in
                
                AndroidToast.makeText(context: self, text: "PositiveButton clicked", duration: AndroidToast.Dutation.short).show()
                dialog?.dismiss()
            })
            .setNegativeButton(text: "Cancel", { dialog, which in
                
                AndroidToast.makeText(context: self, text: "NegativeButton clicked", duration: AndroidToast.Dutation.short).show()
                dialog?.dismiss()
            })
            .show()
    }
    
    private func showAlert2(){
        
        AndroidAlertDialog.Builder.init(context: self)
            .setTitle(title: "Title")
            .setMessage(message: "Message message message")
            .setPositiveButton(text: "OK", { dialog, which in
                
                AndroidToast.makeText(context: self, text: "PositiveButton clicked", duration: AndroidToast.Dutation.short).show()
                dialog?.dismiss()
            })
            .setNegativeButton(text: "Cancel", { dialog, which in
                
                AndroidToast.makeText(context: self, text: "NegativeButton clicked", duration: AndroidToast.Dutation.short).show()
                dialog?.dismiss()
            })
            .setNeutralButton(text: "Neutral", { dialog, which in
                
                AndroidToast.makeText(context: self, text: "NeutralButton clicked", duration: AndroidToast.Dutation.short).show()
                dialog?.dismiss()
            })
            .show()
    }
    
    private func showAlert3(){
        
        let density = getDensity()
        
        let llPadding = Int(3 * density)
        
        let linearLayout = AndroidLinearLayout.init(context: self)
        linearLayout.layoutParams = AndroidViewGroupLayoutParams.init(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.WRAP_CONTENT)
        linearLayout.orientation = AndroidLinearLayout.VERTICAL
        linearLayout.setPadding(left: 0, top: llPadding, right: llPadding, bottom: llPadding)
        
        let tvPaddingLeft = Int(24 * density)
        let tvPaddingTop = Int(12 * density)
        let tvPaddingRight = Int(24 * density)
        let tvPaddingBottom = Int(6 * density)
        
        let textViewMessage = AndroidTextView.init(context: self)
        textViewMessage.layoutParams = AndroidViewGroupLayoutParams.init(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.WRAP_CONTENT)
        textViewMessage.setPadding(left: tvPaddingLeft, top: tvPaddingTop, right: tvPaddingRight, bottom: tvPaddingBottom)
        textViewMessage.setTextSize(size: 16.0)
        textViewMessage.color = AndroidGraphicsColor.BLACK
        textViewMessage.text = "Message message message message message message"
        
        /*
        let options = ["option 1","opcion 2","opcion 3","opcion 4","opcion 5","opcion 6","opcion 7"]
        let adapter = AndroidArrayAdapter<String>(activity: self, items: options)
        */
        
        let options = [100, 200, 300, 400, 500]
        
        let adapter = AndroidArrayAdapter<Int>(activity: self, items: options)
        
        let recyclerView = AndroidWidgetRecyclerView.init(context: self)
        recyclerView.layoutParams = AndroidViewGroupLayoutParams.init(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.WRAP_CONTENT)
        recyclerView.layoutManager = AndroidWidgetRecyclerViewLinearLayoutManager.init(context: self)
        recyclerView.adapter = adapter
        
        linearLayout.addView(textViewMessage)
        linearLayout.addView(recyclerView)
        
        let alertDialog = AndroidAlertDialog.Builder.init(context: self)
            .setTitle(title: "Title")
            .setView(view: linearLayout)
            .show()
        
        adapter.onClickBlock = { position in
            
            AndroidToast.makeText(context: self, text: "\(options[position])", duration: AndroidToast.Dutation.short).show()
            alertDialog.dismiss()
        }
    }
}
