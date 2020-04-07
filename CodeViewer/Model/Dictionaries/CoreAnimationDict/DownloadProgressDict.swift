//
//  DownloadProgressDict.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/6.
//  Copyright © 2020 曾钊. All rights reserved.
//

import Foundation

class DownloadProgressDict : BaseDict {
    override var dict: Dictionary<String, String>? {
        set {}
        get {
            return [
                "DownloadProgressVC.swift": """
import UIKit

class DownloadProgressVC: BaseViewController {
    

    @IBOutlet weak var progressView: DownloadProgressView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func slider(_ sender: UISlider) {
        progressView.progress = sender.value
    }
    
    @IBAction func capture(_ sender: UIButton) {
        
        //Use this method so that the button highlight status will disappear before the screenshot executes
        delay(0.6) {
            let image = UIImage.captureImageWithView(view: self.view)
            
            //The last three parameters can all be nil, so that no need to peform the below method
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

}
""",
                /*********************************************************/
                /*********************************************************/
                /*********************************************************/
                "DownloadProgressView.swift": """
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
"""
            ]
        }
    }
}
