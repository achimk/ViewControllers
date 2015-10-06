//
//  ViewController.swift
//  ViewControllers
//
//  Created by Joachim Kret on 05.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Init / Deinit
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        finishInitialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        finishInitialize()
    }
    
    internal func finishInitialize() {
        // Sublcasses can override this method
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}

