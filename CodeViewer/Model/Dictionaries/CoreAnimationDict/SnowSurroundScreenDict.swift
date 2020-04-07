//
//  SnowSurroundScreenDict.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/6.
//  Copyright © 2020 曾钊. All rights reserved.
//

import Foundation

class SnowSurroundScreenDict: BaseDict {
    
    override var dict: Dictionary<String, String>? {
        set {}
        get {
            return [
                "SnowSurroundScreenVC.swift": """
import UIKit

class SnowSurroundScreenVC: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let image = UIImage.createCircleImage(with: UIImage(named: "Ali")!, andBoundsWidth: 5, boundColor: UIColor.randomColor())
        
        imageView.image = image
        
    }

}
""",
                /*********************************************************/
                /*********************************************************/
                /*********************************************************/
                "SnowMainView.swift": """
import UIKit

class SnowMainView: UIView {
    
    var downY: CGFloat = 0
    var upY:CGFloat = 0
    var forwardX: CGFloat = 0
    var backX: CGFloat = 0
    
    var corY: CGFloat = 0
    var corX: CGFloat = 0
    
    //Use awakeFromNib if code with Objective-C
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let link = CADisplayLink(target: self, selector: #selector(self.setNeedsDisplay(_:)))

        link.add(to: RunLoop.main, forMode: .default)
    }
    
    override func draw(_ rect: CGRect) {
        
        self.setNeedsDisplay(rect)
        
        let height = self.bounds.size.height
        let width = self.bounds.size.width
        
        let image = UIImage(named: "Snow")
        
        let imageW = image!.size.width
        let imageH = image!.size.height
        
        let endX = width - imageW
        let endY = height - imageH
        
        if downY < endY {
            downY += 10;    //snow down
            corY = downY + upY;
        } else {
            downY = endY;   //snow reaches bottom of screen
            corY = downY + upY;
            if (forwardX < endX) {
                forwardX += 10;
                corX = forwardX + backX;
            } else {
                forwardX = endX;    //snow reaches trailing of screen
                if (upY > -endY) {
                    upY -= 10;
                    corY = downY + upY;
                } else {
                    upY = -endY;
                    if (backX > -endX) {
                        backX -= 10;
                        corX = forwardX + backX;
                    } else {
                        backX = -endX;  //snow back to origin
                        downY = 0;      //set all to zero, loop run again
                        forwardX = 0;
                        backX = 0;
                        upY = 0;
                    }
                }
            }
        }
        
        image!.draw(at: CGPoint(x: corX, y: corY))
        
        
    }
    
}
"""
            ]
        }
    }
}
