//
//  PBDrawView.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/7.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class PBDrawView: UIView {
    
    var image: UIImage? {
        willSet {
            paths.append(newValue!)
            
            setNeedsDisplay()
        }
    }
    
    var pathColor: UIColor?
    var lineWidth: Float?
    
    private var path: PBDrawPath?
    private var paths = [AnyObject]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    //setup the view
    func setup() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        
        self.addGestureRecognizer(pan)
        
        lineWidth = 1
        pathColor = .black
    }
    
    //Gesture function
    @objc func pan(_ sender: UIPanGestureRecognizer) {
        //Get start point
        let currentP = sender.location(in: self)
        
        if sender.state == .began {
            
            path = PBDrawPath()
            
            path?.lineWidth = CGFloat(lineWidth!)
            path?.pathColor = pathColor
            
            path?.move(to: currentP)
            
            paths.append(path!)
            
        }
        
        path?.addLine(to: currentP)
        
        setNeedsDisplay()
    }
    
    //redraw view while view changed or called setNeedsDisplay
    override func draw(_ rect: CGRect) {
        
        for path in paths {
            if path.isKind(of: UIImage.self) {
                var image = path as! UIImage
                print(image.size)

                image = image.imageScaleToFitSize(size: self.bounds.size)

                image.draw(in: rect)
                
            } else {
                let p = path as! PBDrawPath
                p.pathColor.set()
                p.stroke()
            }
        }
    }
    

    func undo() {
        if paths.count > 0 {
            paths.removeLast()
            setNeedsDisplay()
        }
    }
    
    func clear() {
        paths.removeAll()
        setNeedsDisplay()
    }

}
