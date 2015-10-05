//
//  NSObject+Swizzle.swift
//  ViewControllers
//
//  Created by Joachim Kret on 05.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import ObjectiveC

// MARK: Swizzle methods

internal func swizzleMethod(anyClass_: AnyClass, selector1 sel1: String, selector2 sel2: String, isClassMethod: Bool) {
    var class_: AnyClass = anyClass_
    if isClassMethod {
        class_ = object_getClass(class_)
    }
    
    let selector1 = Selector(sel1)
    let selector2 = Selector(sel2)
    
    let method1: Method = class_getInstanceMethod(class_, selector1)
    let method2: Method = class_getInstanceMethod(class_, selector2)
    
    if class_addMethod(class_, selector1, method_getImplementation(method2), method_getTypeEncoding(method2)) {
        class_replaceMethod(class_, selector2, method_getImplementation(method1), method_getTypeEncoding(method1))
    } else {
        method_exchangeImplementations(method1, method2)
    }
}

public func swizzleInstanceMethod(class_: AnyClass, sel1: String, sel2: String) {
    swizzleMethod(class_, selector1: sel1, selector2: sel2, isClassMethod: false)
}

public func swizzleClassMethod(class_: AnyClass, sel1: String, sel2: String) {
    swizzleMethod(class_, selector1: sel1, selector2: sel2, isClassMethod: true)
}