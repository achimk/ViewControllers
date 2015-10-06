//
//  UIResponder+Chain.swift
//  Goalv8
//
//  Created by Joachim Kret on 24/09/15.
//  Copyright © 2015 Perform. All rights reserved.
//

import UIKit

extension UIResponder {
    
    func firstResponder(aClass: AnyClass) -> AnyObject? {
        var responder: UIResponder? = self.nextResponder()
        while responder != nil {
            if responder?.isKindOfClass(aClass) == true {
                return responder
            } else {
                responder = responder?.nextResponder()
            }
        }
        
        return nil
    }
    
}
