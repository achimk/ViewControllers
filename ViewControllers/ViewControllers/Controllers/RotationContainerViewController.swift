//
//  RotationContainerViewController.swift
//  ViewControllers
//
//  Created by Joachim Kret on 10.11.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

class RotationContainerViewController: ContainerViewController {
    private var animating: Bool = false
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rViewController = UIViewController()
        rViewController.view.backgroundColor = UIColor.redColor()
        let gViewController = UIViewController()
        gViewController.view.backgroundColor = UIColor.greenColor()
        let bViewController = UIViewController()
        bViewController.view.backgroundColor = UIColor.blueColor()
        
        viewControllers = [rViewController, gViewController, bViewController]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "nextController:")
        
        replaceBlock = { [weak self] fromVC, toVC, viewContainer in
            let options: UIViewAnimationOptions = [.TransitionFlipFromRight, .CurveEaseInOut]
            
            self?.animating = true
            self?.replaceFromViewController(
                fromVC,
                toViewController: toVC,
                inContainer: viewContainer,
                duration: 0.333,
                options: options,
                completion: { isFinished in
                    self?.animating = false
            })
        }
    }
    
    // MARK: Actions
    
    @IBAction func nextController(sender: AnyObject?) {
        if animating {
            return
        }
        
        var index = selectedIndex + 1
        index = (index % viewControllers.count == 0) ? 0 : index
        selectedIndex = index
    }
}
