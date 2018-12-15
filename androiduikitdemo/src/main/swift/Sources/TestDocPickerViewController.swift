//
//  TestDocPickerViewController.swift
//  androiduikittarget
//
//  Created by Marco Estrella on 12/13/18.
//

import Foundation
#if os(iOS)
import UIKit
#else
import Android
import AndroidUIKit
#endif

final class TestDocPickerViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    #if os(iOS)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    #endif
    
    //override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        NSLog("\(#function) \(view.frame)")
        
        let btn1 = UIButton(frame: CGRect(x: 20, y: 50, width: 150, height: 50))
        btn1.backgroundColor = .green
        btn1.setTitle("Open Doc Picker", for: UIControlState.normal)
        #if os(iOS)
        btn1.addTarget(self, action: #selector(showDocPickerAction), for: UIControlEvents.touchDown)
        #else
        btn1.addTarget(action: { self.showDocPicker() }, for: UIControlEvents.touchDown)
        #endif
        
        self.view.addSubview(btn1)
    }
    
    #if os(iOS)
    @objc private func showDocPickerAction(){
        showDocPicker()
    }
    #endif
    
    private func showDocPicker(){
        #if os(iOS)
        let documentTypes = ["public.text", "public.image"]
        #else
        let documentTypes = ["apk", "climateconfig", "json"]
        #endif
        
        let docPickerVC = UIDocumentPickerViewController(documentTypes: documentTypes, in: .import)
        docPickerVC.delegate = self
        docPickerVC.allowsMultipleSelection = true
        self.present(docPickerVC, animated: false)
    }
}

extension TestDocPickerViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        NSLog("\(#function)")
        
        urls.forEach { url in
            
            NSLog("\(#function) path \(url.path)")
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        NSLog("\(#function)")
    }
}
