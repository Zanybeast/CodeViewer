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
