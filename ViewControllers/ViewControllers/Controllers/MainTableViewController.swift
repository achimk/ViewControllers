//
//  MainTableViewController.swift
//  ViewControllers
//
//  Created by Joachim Kret on 06.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

class MainTableViewController: TableViewController {
    private let mainMenu = constructMainMenu()
    
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

// MARK: UITableViewDelegate

extension MainTableViewController {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        guard
            let row = mainMenuRow(mainMenu, indexPath: indexPath),
            let present = row.presentData
        else {
            return
        }
        
        let (type, controller, _) = present()
        guard let viewController = controller else {
            return
        }
        
        switch type {
        case .Push(let animated):
            navigationController?.pushViewController(viewController, animated: animated)
            
        case .Modal(let animated):
            navigationController?.presentViewController(viewController, animated: animated, completion: nil)
        }
    }
}

// MARK: UITableViewDataSource

extension MainTableViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.cell(tableView, indexPath: indexPath)

        if let row = mainMenuRow(mainMenu, indexPath: indexPath) {
            cell.textLabel?.text = row.title
        } else {
            cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        }
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mainMenu.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenu[section].rows.count
    }
}

// MARK: Main Menu

private enum Present {
    case Push(animated: Bool)
    case Modal(animated: Bool)
}

private struct MainSection {
    var title: String?
    var description: String?
    var rows = [MainRow]()
}

private struct MainRow {
    var title: String?
    var description: String?
    var presentData: ((Void) -> (type: Present, viewController: UIViewController?, userInfo: [String : AnyObject]?))?
}

private func constructMainMenu() -> [MainSection] {
    var sections = [MainSection]()
    
    // Rotation Section
    var rows = [MainRow]()
    rows.append(MainRow(title: "Navigation", description: "Navigation controller") {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.redColor()
        return (.Push(animated: true), viewController, nil)
    })
    rows.append(MainRow(title: "Tab Bar", description: "Tab bar controller") {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.greenColor()
        return (.Push(animated: true), viewController, nil)
    })
    rows.append(MainRow(title: "Container", description: "Container controller") {
        let viewController = RotationContainerViewController()
        return (.Push(animated: true), viewController, nil)
        })
    sections.append(MainSection(title: "Rotation", description: nil, rows: rows))
    
    return sections
}

private func mainMenuRow(sections: [MainSection], indexPath: NSIndexPath) -> MainRow? {
    if indexPath.section >= 0 && indexPath.section < sections.count {
        let section = sections[indexPath.section]
        if indexPath.row >= 0 && indexPath.row < section.rows.count {
            return section.rows[indexPath.row]
        }
    }
    
    return nil
}

