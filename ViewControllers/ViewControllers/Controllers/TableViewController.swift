//
//  TableViewController.swift
//  ViewControllers
//
//  Created by Joachim Kret on 06/10/15.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

class TableViewController: ViewController {
    var shouldClearSelectionOnReloadData = false
    var shouldReloadDataOnViewWillAppear = false
    
    // MARK: Accessors
    
    @IBOutlet var tableView: UITableView? = UITableView.init(frame: CGRect.zero, style: .Plain) {
        willSet {
            if let tableView = tableView {
                tearDownTableView(tableView)
            }
        }
        
        didSet {
            if let tableView = tableView {
                setupTableView(tableView)
            }
        }
    }

    // MARK: Init / Deinit
    
    convenience init(style: UITableViewStyle) {
        self.init(nibName: nil, bundle: nil)
        tableView = UITableView.init(frame: CGRect.zero, style: style)
    }
    
    deinit {
        tableView?.delegate = nil
        tableView?.dataSource = nil
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tableView = tableView {
            setupTableView(tableView)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if appearsFirstTime() || shouldReloadDataOnViewWillAppear {
            reloadData()
        }
    }
    
    // MARK: Edit
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if let tableView = tableView {
            tableView.setEditing(editing, animated: animated)
        }
    }
    
}

// MARK: Public Methods

extension TableViewController {

    func reloadData() {
        assert(NSThread.isMainThread() == true, "\(self.dynamicType): \(__FUNCTION__) must be called on main thread!")
        
        if let tableView = tableView {
            let indexPaths = tableView.indexPathsForSelectedRows
            tableView.reloadData()
            
            if shouldClearSelectionOnReloadData == false, let indexPaths = indexPaths {
                for indexPath in indexPaths {
                    tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
                }
            }
        }
    }
}

// MARK: UITableViewDelegate

extension TableViewController: UITableViewDelegate {}

// MARK: UITableViewDataSource

extension TableViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        assert(false, "Can't present a cell for empty dequeue implementation.")
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

// MARK: Private Methods

extension TableViewController {
    
    private func tearDownTableView(tableView: UITableView) {
        tableView.removeFromSuperview()
        tableView.delegate = nil
        tableView.dataSource = nil
    }
    
    private func setupTableView(tableView: UITableView) {
        guard isViewLoaded() && tableView.superview == nil else {
            return
        }
        
        if tableView.delegate == nil {
            tableView.delegate = self
        }
        
        if tableView.dataSource == nil {
            tableView.dataSource = self
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
}
