//
//  SecondLevelViewController.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class SecondLevelViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var content: [String]?
    
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
        return content!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondLevelCell", for: indexPath)
        
        cell.textLabel?.text = content![indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var nibStr = content![indexPath.row]
        nibStr.append("VC")
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            showAlert(info: "Fail to get space name")
            return
        }
        
        let vcClass: AnyClass? = NSClassFromString(nameSpace + "." + nibStr)
        guard let typeClass = vcClass as? UIViewController.Type else {
            showAlert(info: "This module has not been implemented yet. Please try other demo~")
            return
        }

//        let snowVC = SnowSurroundScreenVC(nibName: nibStr, bundle: nil)
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
