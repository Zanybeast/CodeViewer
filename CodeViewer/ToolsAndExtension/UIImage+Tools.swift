//
//  UIImage+Tools.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

extension UIImage {
    
    //Get image size to view
    func imageScaleToSize(size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    //Get image scale to fit the size of view
    func imageScaleToFitSize(size: CGSize) -> UIImage {
        
        let aspect: CGFloat = self.size.width / self.size.height
        
        if (size.width / aspect) <= size.width {
            return self.imageScaleToSize(size: CGSize(width: size.width, height: size.width / aspect))
        } else {
            return self.imageScaleToSize(size: CGSize(width: size.height * aspect, height: size.height))
        }
    }
    
    
    //capture image to screenshot
    static func captureImageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()!
        
        view.layer.render(in: context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    //Clip image so that to be a head icon
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
