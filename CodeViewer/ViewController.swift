//
//  ViewController.swift
//  CodeViewer
//
//  Created by 曾钊 on 2020/4/4.
//  Copyright © 2020 曾钊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sortedArrForTitle: [String]!
    var contentDictionary: Dictionary<String, [String]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrieve data from plist to show the title on tableView
        let dicPath = Bundle.main.path(forResource: "SecondLevelContent", ofType: "plist")
        contentDictionary = NSDictionary(contentsOfFile: dicPath!) as? Dictionary<String, [String]>
//        print(contentDictionary)
        var array: [String] = []
        for key in contentDictionary!.keys {
            array.append(key)
        }
//        print(sortedArrForTitle)
        sortedArrForTitle = array.sorted()
        
        //Set tableView properties
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        
        //Register Cell For tableView
        tableView.register(UINib.init(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainReuseCell")
        
        
    }


}

//MARK: - TableView DataSource And Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cellText.count
        return sortedArrForTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainReuseCell", for: indexPath) as! MainTableViewCell
        
        cell.label.text = sortedArrForTitle![indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let key = sortedArrForTitle[indexPath.row]
        let content = contentDictionary![key]
        
        let storyBoard = UIStoryboard.init(name: "SecondLevel", bundle: nil)
        let secondVC = storyBoard.instantiateInitialViewController() as! SecondLevelViewController
        secondVC.content = content
        navigationController?.pushViewController(secondVC, animated: true)
        
    }
}

