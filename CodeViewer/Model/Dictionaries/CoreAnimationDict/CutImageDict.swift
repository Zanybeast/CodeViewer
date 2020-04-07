//
//  CutImageDict.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/6.
//  Copyright © 2020 曾钊. All rights reserved.
//

import Foundation

class CutImageDict: BaseDict {
    override var dict: Dictionary<String, String>? {
        set {}
        get {
            return [
                "CutImageVC.swift": """
//In this demo, the imageView frame should be the same as the superview
//or it may not correct while clipping the image
import UIKit

class CutImageVC: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    var clippedImageView: UIImageView?
    var startP: CGPoint?
    let sightLength : CGFloat = 3
    
    var obtainView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pan = UIPanGestureRecognizer(target: self, action: #selector(getClipView(pan:)))
        
        view.addGestureRecognizer(pan)
        
    }
    
    @objc func getClipView(pan: UIPanGestureRecognizer) {
        
        var endP = CGPoint.zero
        
        if pan.state == .began {
            startP = pan.location(in: self.view)
            if obtainView == nil {
                obtainView = UIView()
                obtainView?.backgroundColor = .gray
                obtainView?.alpha = 0.4
                
                self.view.addSubview(obtainView!)
            }

        } else if pan.state == .changed {
            
            endP = pan.location(in: self.view)
            
            let width = endP.x - startP!.x
            let height = endP.y - startP!.y
            
            let frame = CGRect(x: startP!.x, y: startP!.y, width: width, height: height)
            //Make the view to prompt which part user wants to clipped
            obtainView!.frame = frame
            
        } else if pan.state == .ended {
            
            UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0.0)
            
            //Make a white rectangle to seperate the origin image and clipped image
            let sightX = obtainView!.frame.origin.x - sightLength
            let sightY = obtainView!.frame.origin.y - sightLength
            let sightW = obtainView!.frame.size.width + sightLength * 2
            let sightH = obtainView!.frame.size.height + sightLength * 2
    
            let sightPath = UIBezierPath.init(rect: CGRect(x: sightX, y: sightY, width: sightW, height: sightH))
            
            UIColor.white.set()

            sightPath.fill()
            
            //Draw the image
            let imagePath = UIBezierPath.init(rect: obtainView!.frame)
            
            imagePath.addClip()
            
            let context = UIGraphicsGetCurrentContext()
            
            
            imageView.layer.render(in: context!)
            
            //Initial a new imageView to store the cutdown
            clippedImageView = UIImageView(frame: imageView.frame)
            clippedImageView?.image = UIGraphicsGetImageFromCurrentImageContext()
            self.view.addSubview(clippedImageView!)
            
            UIGraphicsEndImageContext()
            
            obtainView!.removeFromSuperview()
            
            obtainView = nil
            
            //After capturing the image, remind user to save the image or not
            let alert = UIAlertController.initWithDoubleAction(alertTitle: "Remind", alertMessage: "You've already clip the image, will you save it to album?", alertStyle: .alert, leftActionTitle: "Cancel", leftActionStyle: .cancel, leftHandler: { (action) in
                self.clippedImageView?.removeFromSuperview()
            }, rightActionTitle: "Save!", rightActionStyle: .default) { (action) in
                UIImageWriteToSavedPhotosAlbum((self.clippedImageView?.image)!, nil, nil, nil)
                self.clippedImageView?.removeFromSuperview()
            }
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }


}
"""
            ]
        }
    }
}
