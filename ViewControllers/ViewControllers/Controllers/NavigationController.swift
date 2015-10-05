//
//  NavigationController.swift
//  ViewControllers
//
//  Created by Joachim Kret on 06.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(__FUNCTION__)
        self.view.backgroundColor = UIColor.redColor()
        
        print(autorotation.rawValue)
        autorotation = .ContainerAndTopChildren
        print(autorotation.rawValue)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(__FUNCTION__)
        print(appearsFirstTime())
        print(isViewVisible())
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(__FUNCTION__)
        print(appearsFirstTime())
        print(isViewVisible())
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print(__FUNCTION__)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print(__FUNCTION__)
    }
    
}
