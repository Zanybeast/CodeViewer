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
    
    static func initWithDoubleAction(alertTitle: String?,
                                    alertMessage: String?,
                                    alertStyle: UIAlertController.Style,
                                    leftActionTitle: String?,
                                    leftActionStyle: UIAlertAction.Style,
                                    leftHandler: ((UIAlertAction) -> Void)?,
                                    rightActionTitle: String?,
                                    rightActionStyle: UIAlertAction.Style,
                                    rightHandler: ((UIAlertAction) -> Void)? ) -> UIAlertController {
        let alertVC = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let leftAction = UIAlertAction(title: leftActionTitle, style: leftActionStyle, handler: leftHandler)
        
        let rightAction = UIAlertAction(title: rightActionTitle, style: rightActionStyle, handler: rightHandler)
        
        alertVC.addAction(leftAction)
        alertVC.addAction(rightAction)
        
        return alertVC
        
    }
}
