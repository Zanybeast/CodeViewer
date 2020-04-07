//
//  PieGraphicNHistogramDict.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/6.
//  Copyright © 2020 曾钊. All rights reserved.
//

import Foundation

class PieGraphicNHistogramDict: BaseDict {
    override var dict: Dictionary<String, String>? {
        set {}
        get {
            return [
                "PieGraphicView.swift": """
import UIKit

class PieGraphicView: UIView {

   
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        let randomArray: [Int] = Array.randomIntArray()
        
        let count = randomArray.count
        let total = CGFloat(randomArray.totalIntValue())
        
        var startAngle: CGFloat = 0.0
        var endAngle: CGFloat = 0.0
        var incrementAngle: CGFloat = 0.0
        
        let center = CGPoint(x: width / 2, y: height / 2)
        
        let radius = (((width >= height) ? height : width) - 10) / 2
        
        for i in 0..<count {
        
            startAngle = endAngle
            incrementAngle = CGFloat(randomArray[i]) / CGFloat(total) * 2.0 * CGFloat(Double.pi)
            endAngle = startAngle + incrementAngle
            
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            path.addLine(to: center)
            
            context?.setLineWidth(3)
            
            UIColor.randomColor().set()
            
            context?.addPath(path.cgPath)
            
            context?.fillPath()
            
        }
        
    }
    

}
""",
                /*********************************************************/
                /*********************************************************/
                /*********************************************************/
                "HisgramView.swift": """
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
"""
            ]
        }
    }
}
