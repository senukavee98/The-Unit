//
//  SpeedHistoryVC.swift
//  The Unit
//
//  Created by user187351 on 3/17/21.
//

import UIKit

class SpeedHistoryVC: UITableViewController {
    
    var history: [String] = [String]()
    let historyViewCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initHistoryInfo()
        
    }
    
    func initHistoryInfo() {
        loadDefaultData("SpeedHistory")
        history.forEach { (data) in
            print(data)
        }
        
    }
    
    func loadDefaultData(_ historyKey: String) {
        let defaults = UserDefaults.standard
        history = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyViewCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "speedCell")!
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = history.reversed()[indexPath.row]
        
        return cell
    }
    
}
