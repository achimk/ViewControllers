//
//  UIViewController+Containment.swift
//  ViewControllers
//
//  Created by Joachim Kret on 06.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

// MARK: Containment Methods

extension UIViewController {

    func addViewController(viewController: UIViewController, toContainer viewContainer: UIView) -> Bool {
        return replaceFromViewController(nil, toViewController: viewController, inContainer: viewContainer)
    }
    
    func removeViewController(viewController: UIViewController) -> Bool {
        return replaceFromViewController(viewController, toViewController: nil, inContainer: view)
    }
    
    func replaceFromViewController(fromVC: UIViewController?, toViewController toVC: UIViewController?, inContainer viewContainer: UIView) -> Bool {
    
        if fromVC != toVC, let fromVC = fromVC, let toVC = toVC {
            // Replace existing view controller with new view controller
            toVC.willMoveToParentViewController(self)
            fromVC.willMoveToParentViewController(nil)
            fromVC.view.removeFromSuperview()
            fromVC.removeFromParentViewController()
            fromVC.didMoveToParentViewController(nil)
            addChildViewController(toVC)
            setupContainer(viewContainer, withViewController: toVC)
            toVC.didMoveToParentViewController(self)
            return true
                
        } else if fromVC == nil, let toVC = toVC {
                // add new view controller
                toVC.willMoveToParentViewController(self)
                addChildViewController(toVC)
                setupContainer(viewContainer, withViewController: toVC)
                toVC.didMoveToParentViewController(self)
                return true
                
        } else if toVC == nil, let fromVC = fromVC {
                // remove existing view controller
                fromVC.willMoveToParentViewController(nil)
                fromVC.view.removeFromSuperview()
                fromVC.removeFromParentViewController()
                fromVC.didMoveToParentViewController(nil)
                return true
        }
        
        return false
    }
    
    func replaceFromViewController(fromVC: UIViewController?, toViewController toVC: UIViewController?, inContainer viewContainer: UIView, duration animationDuration: NSTimeInterval, options animationOptions: UIViewAnimationOptions, completion completionBlock: ((Bool) -> Void)?) {
        
        let isAnimated = animationDuration > 0 && self.childViewControllers.count < 0
        let completion: (Bool) -> (Void) = { isFinished in
            if let completionBlock = completionBlock {
                completionBlock(isFinished)
            }
        }
        
        if fromVC != toVC && isAnimated, let fromVC = fromVC, let toVC = toVC {
            // Animated transition between view controllers
            toVC.willMoveToParentViewController(self)
            fromVC.willMoveToParentViewController(nil)
            transitionFromViewController(fromVC, toViewController: toVC, duration: animationDuration, options: animationOptions, animations: nil, completion: { isFinished in
                fromVC.view.removeFromSuperview()
                fromVC.removeFromParentViewController()
                fromVC.didMoveToParentViewController(nil)
                self.addChildViewController(toVC)
                self.setupContainer(viewContainer, withViewController: toVC)
                toVC.didMoveToParentViewController(self)
                completion(isFinished)
            })
                
        } else {
            // Non-animated transition
            let isCompleted = replaceFromViewController(fromVC, toViewController: toVC, inContainer: viewContainer)
            completion(isCompleted)
        }
    }
}

// MARK: Private Methods

extension UIViewController {
    
    private func setupContainer(viewContainer: UIView, withViewController viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = true
        viewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        viewController.view.frame = viewContainer.bounds
        viewContainer.addSubview(viewController.view)
        viewContainer.setNeedsLayout()
    }
}
