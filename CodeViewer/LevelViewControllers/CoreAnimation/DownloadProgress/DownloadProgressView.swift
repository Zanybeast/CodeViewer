//
//  DownloadProgressView.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class DownloadProgressView: UIView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        label.textAlignment = .center
        label.bounds = CGRect(x: 0, y: 0, width: self.bounds.width, height: 50)
        self.addSubview(label)
        
        return label
    }()
    
    var progress: Float = 0.0 {
        didSet {
            self.label.text = String(format: "%.2f%%", oldValue * 100.0)
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        let lineWidth: CGFloat = 10
        
        let context = UIGraphicsGetCurrentContext()
        
        let center = CGPoint(x:width / 2, y:height / 2)
        
        let radius = ((width >= height) ? height : width) / 2 - lineWidth
        
        let startAngle = CGFloat(-(Double.pi / 2))
        let endAngle = CGFloat(Double(self.progress) * (Double.pi) * 2 - (Double.pi) / 2)
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        context?.addPath(path.cgPath)
        
        context?.setLineWidth(lineWidth)
        
        UIColor.blue.set()
        
        context?.strokePath()
        
    }

}
