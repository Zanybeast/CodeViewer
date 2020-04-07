//
//  PaintBoardDict.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/7.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class PaintBoardDict: BaseDict {
    override var dict: Dictionary<String, String>? {
        set {}
        get {
            return [
                "PaintBoardVC.swift": """
import UIKit

class PaintBoardVC: BaseViewController {

    @IBOutlet weak var drawView: PBDrawView!
    var lastButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Save button click, save the image to album
    @IBAction func save(_ sender: UIBarButtonItem) {
        UIGraphicsBeginImageContextWithOptions(drawView.bounds.size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        
        drawView.layer.render(in: context!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    //MARK: - go to album to select an image to draw
    @IBAction func toAlbum(_ sender: UIBarButtonItem) {
        let pickerVC = UIImagePickerController()
        
        pickerVC.sourceType = .photoLibrary
        
        pickerVC.delegate = self
        
        self.present(pickerVC, animated: true, completion: nil)
    }
    
    //MARK: - erase picture
    @IBAction func erase(_ sender: UIBarButtonItem) {
        drawView.pathColor = .white
    }
    
    //MARK: - undo last action
    @IBAction func undo(_ sender: UIBarButtonItem) {
        drawView.undo()
    }
    
    //MARK: - clear all content on the view
    @IBAction func clear(_ sender: UIBarButtonItem) {
        drawView.clear()
    }
    
    //MARK: - change the color of draw pen
    @IBAction func colorChange(_ sender: UIButton) {
        drawView.pathColor = sender.backgroundColor
        
        lastButton?.superview?.backgroundColor = .white
        sender.superview?.backgroundColor = .systemGray5
        
        lastButton = sender
    
    }
    
    //MARK: - change width of draw pen
    @IBAction func widthChange(_ sender: UISlider) {
        drawView.lineWidth = sender.value
    }
    
    
    //Write to album
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

extension PaintBoardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        self.drawView.image = image
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
""",
                /*********************************************************/
                /*********************************************************/
                /*********************************************************/
                "PBDrawView.swift": """
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
""",
                /*********************************************************/
                /*********************************************************/
                /*********************************************************/
                "PBDrawPath.swift": """
import UIKit

class PBDrawPath: UIBezierPath {
    
    var pathColor: UIColor!

}
"""
            ]
        }
    }
}
