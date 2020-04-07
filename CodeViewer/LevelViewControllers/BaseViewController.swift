//
//  BaseViewController.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var dict: Dictionary<String, String>? {
        set {}
        get {
            var dictRes: Dictionary<String, String>?
            if let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String {
                //Get the className depending on the class
                let classStr = NSStringFromClass(Self.self.classForCoder())
                let subStr = classStr.split(separator: ".")
                var thisClassStr = String(subStr.last!)
                //Remove the last two character for the name of the class is "xxxVC"
                thisClassStr.removeLast()
                thisClassStr.removeLast()
                //Add the "Dict" so that relative dictionary named as "xxxDict"
                thisClassStr = thisClassStr + "Dict"
                
                //Using the className to generate the class
                let dictClass: AnyClass? = NSClassFromString(nameSpace + "." + thisClassStr)
                //Get the dictionary related to the class
                if let thisDict = dictClass as? BaseDict.Type {
                    dictRes = thisDict.init().dict
                }
            }
            
            return dictRes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Display"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "ShowCode", style: .plain, target: self, action: #selector(showImpCode))
        
    }
    
    @objc func showImpCode() {
        let storyboard = UIStoryboard(name: "CodeViewerViewController", bundle: nil)
        let codeViewerVC = storyboard.instantiateInitialViewController() as! CodeViewerViewController
        if let safeDict = dict {
            codeViewerVC.contentDict = safeDict
            navigationController?.pushViewController(codeViewerVC, animated: true)
        } else {
            let alertVC = UIAlertController.initWithAlertAction(alertTitle: "Warning", alertMessage: "No code to record, wait for implementation", alertStyle: .alert, actionTitle: "OK", actionStyle: .default, handler: nil)
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
}
