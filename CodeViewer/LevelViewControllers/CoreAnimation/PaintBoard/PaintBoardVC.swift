//
//  PaintBoardVC.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/7.
//  Copyright © 2020 曾钊. All rights reserved.
//

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
