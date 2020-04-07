//
//  CodePageViewController.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit
import Highlightr

class CodePageViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var textStr: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.contentInsetAdjustmentBehavior = .never

        let highlightr = Highlightr()
        highlightr?.setTheme(to: "xcode")
        let highlightedStr = highlightr?.highlight(textStr, as: "swift", fastRender: true)
        let mutableAttrStr = NSMutableAttributedString(attributedString: highlightedStr!)
        mutableAttrStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: 0, length: mutableAttrStr.length))
        textView.attributedText = mutableAttrStr
        
    }

}
