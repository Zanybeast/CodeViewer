//
//  UIColor+Tools.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(255)) / 255.0
        let g = CGFloat(arc4random_uniform(255)) / 255.0
        let b = CGFloat(arc4random_uniform(255)) / 255.0
        let color = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
        return color
    }
}
