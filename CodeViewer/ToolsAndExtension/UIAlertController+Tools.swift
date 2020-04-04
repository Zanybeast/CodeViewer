//
//  UIAlertController+Tools.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func initWithAlertAction(alertTitle: String?,
                                    alertMessage: String?,
                                    alertStyle: UIAlertController.Style,
                                    actionTitle: String?,
                                    actionStyle: UIAlertAction.Style,
                                    handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alertVC = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: actionStyle, handler: handler)
        
        alertVC.addAction(action)
        
        return alertVC
        
    }
}
