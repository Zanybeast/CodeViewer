//
//  UnLockBackGroundView.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/7.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class UnLockBackGroundView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let image = UIImage(named: "btnUnlock_bg")
        
        image?.draw(in: rect)
        
    }
    

}
