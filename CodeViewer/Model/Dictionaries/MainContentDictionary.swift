//
//  MainContentDictionary.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/6.
//  Copyright © 2020 曾钊. All rights reserved.
//

import Foundation

struct MainContentDictionary {
    let dict: Dictionary<String, String> = [
        "00Noted00": """
1. Using xxxVC to every root class of items
2. Using xxxDict to every dictionary class, the name should be the same as xxxVC.
""",
        /*********************************************************/
        /*********************************************************/
        /*********************************************************/
        "ContentManager": """
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
""",
        /*********************************************************/
        /*********************************************************/
        /*********************************************************/
        "SecondLevelViewController.swift": """
import UIKit

class SecondLevelViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let contentManager = ContentManager.shared
    
    var key: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "List"
        
    }

}

extension SecondLevelViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContentManager.shared.getItems(with: key!)!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondLevelCell", for: indexPath)
        
        let cellStr = ContentManager.shared.getItems(with: key!)![indexPath.row]
        let priority = ContentManager.shared.dict[cellStr]
        var color: UIColor = .black
        switch priority {
        case 0:
            color = .blue
        case 1:
            color = .green
        case 2:
            color = .red
        case 3:
            color = .purple
        default:
            break
        }
        cell.textLabel?.textColor = color
        cell.textLabel?.text = cellStr
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var nibStr = ContentManager.shared.sortedItems![indexPath.row]
        nibStr.append("VC")
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            let alertVC = UIAlertController.initWithAlertAction(alertTitle: "Warning", alertMessage: "Fail to get name space", alertStyle: .alert
                , actionTitle: "OK", actionStyle: .default, handler: nil)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        
        let vcClass: AnyClass? = NSClassFromString(nameSpace + "." + nibStr)
        guard let typeClass = vcClass as? UIViewController.Type else {
            let alertVC = UIAlertController.initWithAlertAction(alertTitle: "Warning", alertMessage: "This module has not been implemented yet. Please try other demo~", alertStyle: .alert
                , actionTitle: "OK", actionStyle: .default, handler: nil)
            self.present(alertVC, animated: true, completion: nil)
            return
        }

        let pushVC = typeClass.init(nibName: nibStr, bundle: nil)
        navigationController?.pushViewController(pushVC, animated: true)
        
    }
}

extension SecondLevelViewController {
    func showAlert(info: String) {
        let alert = UIAlertController(title: "Warning", message: info, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in

        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
""",
        /*********************************************************/
        /*********************************************************/
        /*********************************************************/
        "BaseViewController.swift": """
import UIKit

class BaseViewController: UIViewController {
    
    var dict: Dictionary<String, String>? {
        set {}
        get {
            var dictRes: Dictionary<String, String>?
            if let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String {
                //Get the className depending on the class
                let classStr = NSStringFromClass(Self.self.classForCoder())
                let subStr = classStr.split(separator: ".")
                var thisClassStr = String(subStr.last!)
                //Remove the last two character for the name of the class is "xxxVC"
                thisClassStr.removeLast()
                thisClassStr.removeLast()
                //Add the "Dict" so that relative dictionary named as "xxxDict"
                thisClassStr = thisClassStr + "Dict"
                
                //Using the className to generate the class
                let dictClass: AnyClass? = NSClassFromString(nameSpace + "." + thisClassStr)
                //Get the dictionary related to the class
                if let thisDict = dictClass as? BaseDict.Type {
                    dictRes = thisDict.init().dict
                }
            }
            
            return dictRes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Display"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "ShowCode", style: .plain, target: self, action: #selector(showImpCode))
        
    }
    
    @objc func showImpCode() {
        let storyboard = UIStoryboard(name: "CodeViewerViewController", bundle: nil)
        let codeViewerVC = storyboard.instantiateInitialViewController() as! CodeViewerViewController
        if let safeDict = dict {
            codeViewerVC.contentDict = safeDict
            navigationController?.pushViewController(codeViewerVC, animated: true)
        } else {
            let alertVC = UIAlertController.initWithAlertAction(alertTitle: "Warning", alertMessage: "No code to record, wait for implementation", alertStyle: .alert, actionTitle: "OK", actionStyle: .default, handler: nil)
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
}
""",
        /*********************************************************/
        /*********************************************************/
        /*********************************************************/
        "ViewController.swift": """
import UIKit

class ViewController: UIViewController {


    let dict: Dictionary<String, String>? = MainContentDictionary().dict
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set tableView properties
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        
        //Register Cell For tableView
        tableView.register(UINib.init(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainReuseCell")
        
    }

    @IBAction func clickToCode(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "CodeViewerViewController", bundle: nil)
        let codeViewerVC = storyboard.instantiateInitialViewController() as! CodeViewerViewController
        if let safeDict = dict {
            codeViewerVC.contentDict = safeDict
            navigationController?.pushViewController(codeViewerVC, animated: true)
        } else {
            let alertVC = UIAlertController.initWithAlertAction(alertTitle: "Warning", alertMessage: "No code to record, wait for implementation", alertStyle: .alert, actionTitle: "OK", actionStyle: .default, handler: nil)
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
}

//MARK: - TableView DataSource And Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return ContentManager.shared.themes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainReuseCell", for: indexPath) as! MainTableViewCell
        
        cell.label.text = ContentManager.shared.sortedThemes()![indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let key = ContentManager.shared.sortedThemes()![indexPath.row]
        
        let storyBoard = UIStoryboard.init(name: "SecondLevel", bundle: nil)
        let secondVC = storyBoard.instantiateInitialViewController() as! SecondLevelViewController
        secondVC.key = key
        navigationController?.pushViewController(secondVC, animated: true)
        
    }
}
""",
        /*********************************************************/
        /*********************************************************/
        /*********************************************************/
        "CodeViewerViewController.swift": """
import UIKit

class CodeViewerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var contentDict: Dictionary<String, String>?
    
    var sortedKey: [String]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortedKey = (contentDict?.arrayForKeys() as! [String]).sorted{ $0 < $1 }

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "FileList"
        
    }

}

extension CodeViewerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentDict?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeViewerCell", for: indexPath)
        
        cell.textLabel?.text = sortedKey![indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let codePageVC = CodePageViewController(nibName: "CodePageViewController", bundle: nil)
        let key = sortedKey![indexPath.row]
        codePageVC.textStr = contentDict![key]
        
        navigationController?.pushViewController(codePageVC, animated: true)
        
    }
}
""",
        /*********************************************************/
        /*********************************************************/
        /*********************************************************/
        "CodePageViewController.swift": """
import UIKit
import Highlightr

class CodePageViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var textStr: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let highlightr = Highlightr()
        highlightr?.setTheme(to: "xcode")
        let highlightedStr = highlightr?.highlight(textStr, as: "swift", fastRender: true)
        let mutableAttrStr = NSMutableAttributedString(attributedString: highlightedStr!)
        mutableAttrStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: 0, length: mutableAttrStr.length))
        textView.attributedText = mutableAttrStr
        
    }

}
"""
    ]
}
