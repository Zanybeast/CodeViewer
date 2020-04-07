//
//  ContentM.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/6.
//  Copyright © 2020 曾钊. All rights reserved.
//

import Foundation

class ContentManager {
    
    static let shared = ContentManager()
    
    private var contentDict: Dictionary<String, [String]>? {
        get {
            let dicPath = Bundle.main.path(forResource: "SecondLevelContent", ofType: "plist")
            let contentDict = NSDictionary(contentsOfFile: dicPath!) as? Dictionary<String, [String]>
            return contentDict
        }
    }
    
    init() {
        let _ = itemsToShow()
    }
    
    var themes: [String]? {
        set {}
        get {
            var array : [String]! = []
            for key in contentDict!.keys {
                array.append(String(key))
            }
            return array
        }
    }
    
    func sortedThemes() -> [String]? {
        return themes?.sorted()
    }
    
    private var items: [String]?
    var sortedItems: [String]? {
        get {
            var res: [String] = []
            res = itemsToShow()
            return res
        }
    }
    var dict: Dictionary<String, Int> = [:]
    
    func itemsToShow() -> [String] {
        var res : [String] = []
        let array = items?.sorted {$0 < $1 }
        
        if let array = array {
            for element in array {
                var str = element
                let c = str.removeFirst()
                let p = Int(String(c))
                
                dict[str] = p
                res.append(str)
            }
        }
        
        return res
    }

    func getItems(with key: String) -> [String]? {
        self.items = contentDict![key]
        return sortedItems
    }
    
}
