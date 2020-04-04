//
//  Array+Tools.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    static func randomIntArray() -> Array<Int> {
        var array: [Int] = []
        
        let size = arc4random_uniform(8)
        
        for _ in 0...(size + 2) {
            array.append(Int(arc4random_uniform(100) + 5))
        }
        
        return array
    }
    
    func totalIntValue() -> Int {
        
        var total = 0
        
        for element in self {
            total += element
        }
        
        return total
    }
}
