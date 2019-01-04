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


/// Needs to be implemented by app.
@_silgen_name("SwiftAndroidMainActivity")
public func SwiftAndroidMainActivity() -> SwiftSupportAppCompatActivity.Type {
    NSLog("TestAlertDialogActivity bind \(#function)")
    return TestAlertDialogActivity.self
}

// Like AppDelegate in iOS
final class TestAlertDialogActivity: SwiftSupportAppCompatActivity {
    
    override func onCreate(savedInstanceState: Android.OS.Bundle?) {
        
        let metrics = AndroidDisplayMetrics()
        windowManager?.defaultDisplay?.getMetrics(outMetrics: metrics)
        
        let rootFrameLayout = AndroidWidgetFrameLayout.init(context: self)
        rootFrameLayout.layoutParams = AndroidFrameLayoutLayoutParams(width: metrics.widthPixels, height: metrics.heightPixels)
        rootFrameLayout.setBackgroundColor(color: AndroidGraphicsColor.CYAN)
        
        let buttonWidth = Int(150 * metrics.density)
        let buttonHeight = Int(50 * metrics.density)
        
        let layoutparams = AndroidFrameLayoutLayoutParams(width: buttonWidth, height: buttonHeight)
        
        let margin = Int(16 * metrics.density)
        
        layoutparams.setMargins(left: margin, top: margin, right: margin, bottom: margin)
        
        let button1 = AndroidButton.init(context: self)
        button1.layoutParams = layoutparams
        button1.text = "Show Alert 1"
        
        let button2 = AndroidButton.init(context: self)
        button2.layoutParams = layoutparams
        button2.text = "Show Alert 2"
        button2.setY(y: 70 * metrics.density)
        
        let button3 = AndroidButton.init(context: self)
        button3.layoutParams = layoutparams
        button3.text = "Show Alert 3"
        button3.setY(y: 150 * metrics.density)
        
        let button4 = AndroidButton.init(context: self)
        button4.layoutParams = layoutparams
        button4.text = "Show Alert 4"
        button4.setY(y: 220 * metrics.density)
        
        let button5 = AndroidButton(context: self)
        button5.layoutParams = layoutparams
        button5.text = "Show ProgressDialog"
        button5.setY(y: 280 * metrics.density)
        
        let switchCompat = AndroidSwitchCompat(context: self)
        switchCompat.setY(y: 340 * metrics.density)
        switchCompat.setX(x: 12 * metrics.density)
        switchCompat.text = "This is a SwitchCompat"
        switchCompat.setShowText(false)
        switchCompat.setTextOn("ON")
        switchCompat.setTextOff("OFF")
        switchCompat.layoutParams = AndroidFrameLayoutLayoutParams(width: AndroidFrameLayoutLayoutParams.WRAP_CONTENT, height: AndroidFrameLayoutLayoutParams.WRAP_CONTENT)
        
        switchCompat.setOnCheckedChangeListener { compoundButton, checked in
            
            log("Switch was checked? : \(checked)")
        }
        
        let progressBar = AndroidProgressBar.init(context: self)
        progressBar.setIndeterminate(true)
        progressBar.layoutParams = AndroidFrameLayoutLayoutParams(width: buttonHeight, height: buttonHeight)
        progressBar.setY(y: 400 * metrics.density)
        progressBar.setX(x: 12 * metrics.density)
        
        let seekBar = AndroidSeekBar.init(context: self)
        seekBar.layoutParams = AndroidFrameLayoutLayoutParams(width: buttonWidth, height: AndroidFrameLayoutLayoutParams.WRAP_CONTENT)
        seekBar.setY(y: 470 * metrics.density)
        seekBar.setX(x: 12 * metrics.density)
        seekBar.setMax(10)
        seekBar.setOnSeekBarChangeListener(OnSeekBarListener())
        
        rootFrameLayout.addView(button1)
        rootFrameLayout.addView(button2)
        rootFrameLayout.addView(button3)
        rootFrameLayout.addView(button4)
        rootFrameLayout.addView(button5)
        rootFrameLayout.addView(switchCompat)
        rootFrameLayout.addView(progressBar)
        rootFrameLayout.addView(seekBar)
        
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
        
        button4.setOnClickListener {
            
            self.showAlert4()
        }
        
        button5.setOnClickListener {
            
            self.showProgressDialog2()
        }
    }
    
    private func showProgressDialog(){
        
        let progressDialog = AndroidProgressDialog(context: self)
        progressDialog.setIndeterminate(true)
        progressDialog.setTitle("Wait")
        progressDialog.setMessage("Downloading something...")
        progressDialog.setCancelable(cancelable: true)
        progressDialog.show()
    }
    
    private func showProgressDialog2(){
        
        AndroidProgressDialog.show(context: self, title: "Wait", message: "Uploading something..", indeterminate: true, cancelable: true)
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
    
    private func showAlert4(){
        
        let dp3 = Int(3 * density)
        let dp24 = Int(24 * density)
        let dp12 = Int(12 * density)
        let dp6 = Int(6 * density)
        
        let llParams = AndroidLinearLayoutLayoutParams(width: AndroidLinearLayoutLayoutParams.MATCH_PARENT, height: AndroidLinearLayoutLayoutParams.WRAP_CONTENT)

        let linearLayout = AndroidLinearLayout.init(context: self)
        linearLayout.layoutParams = llParams
        linearLayout.setPadding(left: dp24, top: dp3, right: dp24, bottom: dp3)
        linearLayout.orientation = AndroidLinearLayout.VERTICAL
        
        let textViewMessage = AndroidTextView.init(context: self)
        textViewMessage.layoutParams = AndroidViewGroupLayoutParams.init(width: AndroidViewGroupLayoutParams.MATCH_PARENT, height: AndroidViewGroupLayoutParams.WRAP_CONTENT)
        textViewMessage.setPadding(left: 0, top: dp12, right: 0, bottom: dp6)
        textViewMessage.setTextSize(size: 16.0)
        textViewMessage.color = AndroidGraphicsColor.BLACK
        textViewMessage.text = "Message message message message message message"
        
        let editTextLayoutParams = AndroidLinearLayoutLayoutParams(width: AndroidLinearLayoutLayoutParams.MATCH_PARENT, height: AndroidLinearLayoutLayoutParams.WRAP_CONTENT)
        editTextLayoutParams.setMargins(left: 0, top: 0, right: 0, bottom: 0)
        let editText = AndroidEditText(context: self)
        textViewMessage.layoutParams = editTextLayoutParams
        
        linearLayout.addView(textViewMessage)
        linearLayout.addView(editText)
        
        let alertDialog = AndroidAlertDialog.Builder.init(context: self)
            .setTitle(title: "Title")
            .setView(view: linearLayout)
            .show()
    }
}

class OnSeekBarListener: AndroidOnSeekBarChangeListener {
    
    override func onProgressChanged(seekBar: AndroidSeekBar?, progress: Int, fromUser: Bool) {
        
        log("Seekbar->Progress: \(progress)")
    }
    
    override func onStartTrackingTouch(seekBar: AndroidSeekBar?) {
        
    }
    
    override func onStopTrackingTouch(seekBar: AndroidSeekBar?) {
        
    }
}
