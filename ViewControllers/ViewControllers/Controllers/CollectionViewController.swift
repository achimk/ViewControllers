//
//  CollectionViewController.swift
//  ViewControllers
//
//  Created by Joachim Kret on 06/10/15.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

class CollectionViewController: ViewController {
    var shouldClearSelectionOnReloadData = false
    var shouldReloadDataOnViewWillAppear = false
    
    // MARK: Accessors
    
    @IBOutlet var collectionView: UICollectionView? = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout()) {
        willSet {
            if let collectionView = collectionView {
                tearDownCollectionView(collectionView)
            }
        }
        
        didSet {
            if let collectionView = collectionView {
                setupCollectionView(collectionView)
            }
        }
    }
    
    // MARK: Init / Deinit
    
    convenience init(collectionViewLayout: UICollectionViewLayout) {
        self.init(nibName: nil, bundle: nil)
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    }
    
    deinit {
        collectionView?.delegate = nil
        collectionView?.dataSource = nil
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = collectionView {
            setupCollectionView(collectionView)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if appearsFirstTime() || shouldReloadDataOnViewWillAppear {
            reloadData()
        }
    }
}

// MARK: Public Methods

extension CollectionViewController {
    
    func reloadData() {
        assert(NSThread.isMainThread() == true, "\(self.dynamicType): \(__FUNCTION__) must be called on main thread!")
        
        if let collectionView = collectionView {
            let indexPaths = collectionView.indexPathsForSelectedItems()
            collectionView.reloadData()
            
            if shouldClearSelectionOnReloadData == false, let indexPaths = indexPaths {
                for indexPath in indexPaths {
                    collectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .None)
                }
            }
        }
    }
}

// MARK: UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        assert(false, "Can't present a cell for empty dequeue implementation.")
        return UICollectionViewCell()
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

}

// MARK: Private Methods

extension CollectionViewController {
    private func tearDownCollectionView(collectionView: UICollectionView) {
        collectionView.removeFromSuperview()
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
    private func setupCollectionView(collectionView: UICollectionView) {
        guard isViewLoaded() && collectionView.superview == nil else {
            return
        }
        
        if collectionView.delegate == nil {
            collectionView.delegate = self
        }
        
        if collectionView.dataSource == nil {
            collectionView.dataSource = self
        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
}
