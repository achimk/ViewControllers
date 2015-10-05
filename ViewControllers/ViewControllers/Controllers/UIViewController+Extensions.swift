//
//  UIViewController+Extensions.swift
//  ViewControllers
//
//  Created by Joachim Kret on 05.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

extension UIViewController {
    private struct Static {
        static var token: dispatch_once_t = 0
        static var AppearsFirstTime = "AppearsFirstTime"
        static var ViewVisible = "ViewVisible"
    }
    
    // MARK: Swizzle
    
    public override class func initialize() {
        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }
        
        dispatch_once(&Static.token) {
            swizzleInstanceMethod(self, sel1: "viewDidLoad", sel2: "swizzled_viewDidLoad")
            swizzleInstanceMethod(self, sel1: "viewWillAppear:", sel2: "swizzled_viewWillAppear:")
            swizzleInstanceMethod(self, sel1: "viewDidAppear:", sel2: "swizzled_viewDidAppear:")
            swizzleInstanceMethod(self, sel1: "viewWillDisappear:", sel2: "swizzled_viewWillDisappear:")
            swizzleInstanceMethod(self, sel1: "viewDidDisappear:", sel2: "swizzled_viewDidDisappear:")
        }
    }
    
    // MARK: Accessors
    
    private var firstTime: Bool {
        get {
            let firstTime = objc_getAssociatedObject(self, &Static.AppearsFirstTime) as? Bool
            if firstTime != nil, let isFirstTime = firstTime {
                return isFirstTime
            } else {
                return true
            }
        }
        
        set {
            objc_setAssociatedObject(self, &Static.AppearsFirstTime, newValue as Bool?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var viewVisible: Bool {
        get {
            let viewVisible = objc_getAssociatedObject(self, &Static.ViewVisible) as? Bool
            if viewVisible != nil, let isVisible = viewVisible {
                return isVisible
            } else {
                return false
            }
        }
        
        set {
            objc_setAssociatedObject(self, &Static.ViewVisible, newValue as Bool?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func appearsFirstTime() -> Bool {
        return firstTime
    }
    
    func isViewVisible() -> Bool {
        return viewVisible
    }

    // MARK: Swizzled View Lifecycle
    
    func swizzled_viewDidLoad() {
        self.swizzled_viewDidLoad()
        self.firstTime = true
    }
    
    func swizzled_viewWillAppear(animated: Bool) {
        self.swizzled_viewWillAppear(animated)
        self.viewVisible = true
    }
    
    func swizzled_viewDidAppear(animated: Bool) {
        self.swizzled_viewDidAppear(animated);
        self.firstTime = false
    }
    
    func swizzled_viewWillDisappear(animated: Bool) {
        self.swizzled_viewWillDisappear(animated)
    }
    
    func swizzled_viewDidDisappear(animated: Bool) {
        self.swizzled_viewDidDisappear(animated)
        self.viewVisible = false
    }
}
