//
//  ViewController.swift
//  ViewControllers
//
//  Created by Joachim Kret on 05.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self.dynamicType): \(__FUNCTION__)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("\(self.dynamicType): \(__FUNCTION__)")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("\(self.dynamicType): \(__FUNCTION__)")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(self.dynamicType): \(__FUNCTION__)")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(self.dynamicType): \(__FUNCTION__)")
    }
    

}

