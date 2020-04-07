//
//  ViewController.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

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

