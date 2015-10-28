//
//  ContainerViewController.swift
//  ViewControllers
//
//  Created by Joachim Kret on 15.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

class ContainerViewController: ViewController {
    private(set) var viewContainerFromNib = false
    
    @IBOutlet var viewContainer: UIView? = UIView() {
        willSet {
            if let viewContainer = viewContainer {
                tearDownViewContainer(viewContainer)
            }
        }
        
        didSet {
            if let viewContainer = viewContainer {
                setupViewContainer(viewContainer)
            }
        }
    }
    
    var viewControllers: [UIViewController] = [] {
        didSet {
            selectedIndex = (viewControllers.count > 0) ? 0 : NSNotFound
        }
    }
    
    var selectedIndex: Int {
        get {
            var index = NSNotFound
            if let selectedViewController = selectedViewController {
                index = viewControllers.indexOf(selectedViewController) ?? NSNotFound
            }
            
            return index
        }
        
        set {
            if newValue <= 0 && newValue > viewControllers.count {
               selectedViewController = viewControllers[newValue]
            }
        }
    }
    
    private var currentViewController: UIViewController?
    var selectedViewController: UIViewController? {
        get {
            return currentViewController
        }

        set {
            if currentViewController != newValue {
                let existingViewController: UIViewController? = currentViewController
                let newViewController: UIViewController? = newValue
                currentViewController = newValue
                
                if let viewContainer = viewContainer, _ = view {
                    replaceFromViewController(existingViewController, toViewController: newViewController, inContainer: viewContainer)
                }
            }
        }
    }

    var autorotation: Autorotation = .Container
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainerFromNib = (viewContainer != nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewContainer = viewContainer {
            setupViewContainer(viewContainer)
        }
    }
}

// MARK: Rotation

extension ContainerViewController: Autorotatable {

    override func shouldAutorotate() -> Bool {
        switch autorotation {
        case .Container:
            return super.shouldAutorotate()
            
        case .ContainerAndTopChildren:
            if let selectedViewController = selectedViewController {
                return selectedViewController.shouldAutorotate()
            } else {
                return true
            }
            
        case .ContainerAndAllChildren:
            for viewController in viewControllers {
                if !viewController.shouldAutorotate() {
                    return false
                }
            }
            
            return true
        }
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        var mask = UIInterfaceOrientationMask.All.rawValue
        
        switch autorotation {
        case .Container:
            mask = super.supportedInterfaceOrientations().rawValue
            
        case .ContainerAndTopChildren:
            if let selectedViewController = selectedViewController {
                mask &= selectedViewController.supportedInterfaceOrientations().rawValue
            }
            
        case .ContainerAndAllChildren:
            for viewController in viewControllers {
                mask &= viewController.supportedInterfaceOrientations().rawValue
            }
        }
        
        return UIInterfaceOrientationMask(rawValue: mask)
    }
}

// MARK: Private Methods

extension ContainerViewController {

    private func tearDownViewContainer(viewContainer: UIView) {
        viewContainer.removeFromSuperview()
    }
    
    private func setupViewContainer(viewContainer: UIView) {
        guard isViewLoaded() && viewContainer.superview == nil else {
            return
        }
        
        viewContainerFromNib = false
        automaticallyAdjustsScrollViewInsets = false
        
        viewContainer.translatesAutoresizingMaskIntoConstraints = true
        viewContainer.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        viewContainer.frame = view.bounds
        view.addSubview(viewContainer)
    }
}
