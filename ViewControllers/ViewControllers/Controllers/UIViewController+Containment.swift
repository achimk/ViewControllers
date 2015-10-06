//
//  UIViewController+Containment.swift
//  ViewControllers
//
//  Created by Joachim Kret on 06.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

extension UIViewController {

    func replace(existingViewController: UIViewController?, withViewController newViewController: UIViewController?, usingContainer viewContainer: UIView) -> Bool {
    
        if existingViewController != newViewController, let existingViewController = existingViewController, let newViewController = newViewController {
            // Replace existing view controller with new view controller
            newViewController.willMoveToParentViewController(self)
            existingViewController.willMoveToParentViewController(nil)
            existingViewController.view.removeFromSuperview()
            existingViewController.removeFromParentViewController()
            existingViewController.didMoveToParentViewController(nil)
            self.addChildViewController(newViewController)
            setupContainer(viewContainer, withViewController: newViewController)
            newViewController.didMoveToParentViewController(self)
            return true
            
        } else if existingViewController == nil, let newViewController = newViewController {
            // Add initial view controller
            newViewController.willMoveToParentViewController(self)
            self.addChildViewController(newViewController)
            setupContainer(viewContainer, withViewController: newViewController)
            newViewController.didMoveToParentViewController(self)
            return true
            
        } else if newViewController == nil, let existingViewController = existingViewController {
            // Remove existing view controller
            existingViewController.willMoveToParentViewController(nil)
            existingViewController.view.removeFromSuperview()
            existingViewController.removeFromParentViewController()
            existingViewController.didMoveToParentViewController(nil)
            return true
        }

        return false
    }
    
    private func setupContainer(viewContainer: UIView, withViewController viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = true
        viewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        viewController.view.frame = viewContainer.bounds
        viewContainer.addSubview(viewController.view)
        viewContainer.setNeedsLayout()
    }
}
