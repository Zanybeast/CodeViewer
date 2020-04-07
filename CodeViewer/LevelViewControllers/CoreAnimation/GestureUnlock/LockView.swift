//
//  LockView.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/7.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class LockView: UIView {
    
    var currentP: CGPoint?
    var btnArray : [UIButton] = []

    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        //Get the touch point
        currentP = sender.location(in: self)
        
        for view in self.subviews {
            
            let button = view as! UIButton
            
            if button.frame.contains(currentP!) && button.isSelected == false {
                button.isSelected = true
                
                btnArray.append(button)
            }
            
        }
        
        self.setNeedsDisplay()
        
        if sender.state == .ended {
            var str = String()
            
            for button in btnArray {
                str += String(button.tag)
            }
            
            print(str)
            
            for btn in btnArray {
                btn.isSelected = false
            }
            
            btnArray.removeAll()
        }
        
        
    }
    
    //draw the connected line
    override func draw(_ rect: CGRect) {
        let count = btnArray.count
        if count == 0 {
            return
        }
        
        let path = UIBezierPath()
        for i in 0..<count {
            let btn = btnArray[i]
            
            if i == 0 {
                path.move(to: btn.center)
            } else {
                path.addLine(to: btn.center)
            }
        }
        
        path.addLine(to: currentP!)
        
        UIColor.green.set()
        
        path.lineWidth = 10
        path.lineJoinStyle = .round
        path.stroke()
        
    }
    
    //Add nine buttons while awakeFromNib
    override func awakeFromNib() {
//        super.awakeFromNib()
        
        for i in 0..<9 {
            let button = UIButton.init(type: .custom)
            
            button.isUserInteractionEnabled = true
            
            button.setImage(UIImage(named: "btnUnlock"), for: .normal)
            button.setImage(UIImage(named: "btnUnlock_highlight"), for: .selected)
            
            button.tag = i
            
            self.addSubview(button)
        }
    }
    
    //set button frame while layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = self.subviews.count
        let column = 3
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        let width: CGFloat = 74
        let height: CGFloat = 74
        
        let margin = (self.bounds.size.width - CGFloat(column) * width) / CGFloat(column + 1);
        
        var col = 0
        var row = 0
        
        for i in 0..<count {
            
            let button = self.subviews[i]
            
            col = i % column
            row = i / column
            x = margin + CGFloat(col) * (margin + width)
            y = CGFloat(row) * (margin + width)
            
            button.frame = CGRect(x: x, y: y, width: width, height: height)
        }
        
    }

    
}
