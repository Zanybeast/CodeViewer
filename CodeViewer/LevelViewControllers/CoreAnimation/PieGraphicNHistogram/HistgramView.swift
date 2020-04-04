//
//  HistgramView.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class HistgramView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let height = self.bounds.size.height
        let width = self.bounds.size.width
        
        let context = UIGraphicsGetCurrentContext()
        
        let array = Array.randomIntArray()
        
        let count = array.count
        let total = array.totalIntValue()
        
        var corX: CGFloat = 10.0
        let intervalX: CGFloat = (width - 20.0) / CGFloat(count)
        
        var histgramHeight: CGFloat = 0.0
        var corY: CGFloat = 0.0
    
        for i in 0..<count {
            histgramHeight = (CGFloat(array[i]) / CGFloat(total)) * height * 0.9
            corY = height - histgramHeight
            
            let path = UIBezierPath(rect: CGRect(x: corX, y: corY, width: intervalX, height: histgramHeight))
            
            UIColor.randomColor().set()
            
            context?.addPath(path.cgPath)
            
            context?.fillPath()
            
            corX += intervalX
        }
    }
    

}
