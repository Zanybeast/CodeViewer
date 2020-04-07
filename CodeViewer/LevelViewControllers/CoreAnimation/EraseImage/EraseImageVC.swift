//
//  EraseImageVC.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/7.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class EraseImageVC: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pan = UIPanGestureRecognizer(target: self, action: #selector(eraseUsing(pan:)))
        
        self.view.addGestureRecognizer(pan)
        
    }

    @objc func eraseUsing(pan: UIPanGestureRecognizer) {
    
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0.0)
        
        let startP = pan.location(in: self.view)
        
        let wh: CGFloat = 100
        
        let areaX = startP.x - wh * 0.5
        let areaY = startP.y - wh * 0.5
        
        let rect = CGRect(x: areaX, y: areaY, width: wh, height: wh)
        
        let context = UIGraphicsGetCurrentContext()
        
        imageView.layer.render(in: context!)
        
        context?.clear(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        imageView.image = image
        
        UIGraphicsEndImageContext()
        
    }

}
