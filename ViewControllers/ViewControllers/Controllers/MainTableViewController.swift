//
//  MainTableViewController.swift
//  ViewControllers
//
//  Created by Joachim Kret on 06.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

class MainTableViewController: TableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tableView = tableView {
            UITableViewCell.registerCell(tableView)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}

// MARK: UITableViewDataSource

extension MainTableViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.cell(tableView, indexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
