//
//  SnowSurroundScreenVC.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class SnowSurroundScreenVC: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override var dict: Dictionary<String, String>? {
        set {
            
        }
        get {
            return [
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
""",
                    "UIImage+Tools.swift": """
//Using the extension to clip the image, just create an image while initialing the image and
//give it to an image view is OK
import UIKit

extension UIImage {
    static func createCircleImage(with image: UIImage, andBoundsWidth borderWidth: CGFloat, boundColor: UIColor) -> UIImage {
        let imageW = image.size.width
        let imageH = image.size.height
        
        let imageDiameter = imageW >= imageH ? imageH : imageW
        
        let contextAreaD = imageDiameter + borderWidth * 2
        
        //Start image context
        UIGraphicsBeginImageContextWithOptions(CGSize(width: contextAreaD, height: contextAreaD), false, 0)
        
        //draw the outermost path and fill color
        let borderPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: contextAreaD, height: contextAreaD))
        
        boundColor.set()
        
        borderPath.fill()
        
        //draw the image Path and clip the image
        let imagePath = UIBezierPath(ovalIn: CGRect(x: borderWidth, y: borderWidth, width: imageDiameter, height: imageDiameter))
        
        //clip the image
        imagePath.addClip()
        
        //Use the passed image to draw on the area
        image.draw(at: CGPoint(x: borderWidth, y: borderWidth))
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return finalImage
    }
}
"""
                ]
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage.createCircleImage(with: UIImage(named: "Ali")!, andBoundsWidth: 5, boundColor: UIColor.randomColor())
        
        imageView.image = image
        
    }


}
