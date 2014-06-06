//
//  LogViewController.swift
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/6/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

import UIKit

class LogViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var navBar = UINavigationBar()
        self.tableView.addSubview(navBar)
        var navigationItem = UINavigationItem(title: "Sort Log")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "dismiss")
        navigationItem.hidesBackButton = true
        self.navigationController.navigationBar.pushNavigationItem(navigationItem, animated: false)
        self.tableView.rowHeight = 20
    }
    
    var sortLog : String[] = []
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cellIdentifier = "SortLogCell"
        var cell : UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        cell.textLabel.text = self.sortLog[indexPath.row]
        cell.textLabel.font = UIFont(name: "Helvetica Neue", size: 12.0)
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.sortLog.count
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
