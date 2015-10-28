//
//  UITableViewCell+Dequeue.swift
//  Goalv8
//
//  Created by Joachim Kret on 24/09/15.
//  Copyright © 2015 Perform. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    class var identifier: String {
        return NSStringFromClass(self)
    }
    
    class var nibName: String? {
        return nil
    }
    
    static func registerCell(tableView: UITableView) {
        if let cellNibName = nibName {
            let nib = UINib(nibName: cellNibName, bundle: NSBundle.mainBundle())
            tableView.registerNib(nib, forCellReuseIdentifier: identifier)
        } else {
            tableView.registerClass(self, forCellReuseIdentifier: identifier)
        }
    }
    
    static func cell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    }
}
