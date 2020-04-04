//
//  CodeViewerViewController.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

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
