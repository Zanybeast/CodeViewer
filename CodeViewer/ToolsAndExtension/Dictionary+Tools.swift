//
//  Dictionary+Tools.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import Foundation

extension Dictionary {
    func arrayForKeys() -> Array<Any> {
        var array: Array<Any> = []
        
        for key in self.keys {
            array.append(key)
        }
        
        
        return array
    }
}
