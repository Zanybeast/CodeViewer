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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let image = UIImage.createCircleImage(with: UIImage(named: "Ali")!, andBoundsWidth: 5, boundColor: UIColor.randomColor())
        
        imageView.image = image
        
    }


}
