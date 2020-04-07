//
//  TimeRecorder.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/7.
//  Copyright © 2020 曾钊. All rights reserved.
//

import Foundation

class TimeTools {
    
    static func recordTime(title: String, function: () -> ()) {
        let startT = CFAbsoluteTimeGetCurrent()
        function()
        let endT = CFAbsoluteTimeGetCurrent()
        let interval = endT - startT
        
        let result = String(format: "%.4f", interval)
        print("【\(title)】")
        print("Execute this code using: \(result)s")
    }

}

