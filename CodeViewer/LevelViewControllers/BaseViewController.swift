//
//  BaseViewController.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var dict: Dictionary<String, String>?

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
