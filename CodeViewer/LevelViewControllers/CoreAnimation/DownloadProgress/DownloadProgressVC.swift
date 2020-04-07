//
//  DownloadProgressVC.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

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

