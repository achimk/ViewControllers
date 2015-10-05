//
//  Autorotatable.swift
//  ViewControllers
//
//  Created by Joachim Kret on 05.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import Foundation

enum Autorotation {
    case Container
    case ContainerAndTopChildren
    case ContainerAndAllChildren
}

struct AutorotationMode: RawRepresentable {
    private let mode: Autorotation
    
    static var Container: AutorotationMode {
        return AutorotationMode(rawValue: .Container)
    }
    
    static var ContainerAndTopChildren: AutorotationMode {
        return AutorotationMode(rawValue: .ContainerAndTopChildren)
    }
    
    static var ContainerAndAllChildren: AutorotationMode {
        return AutorotationMode(rawValue: .ContainerAndAllChildren)
    }
 
    init(rawValue: Autorotation) {
        self.mode = rawValue
    }
    
    var rawValue: Autorotation {
        return mode
    }
}

protocol Autorotatable {
    var autorotationMode: AutorotationMode {get set}
}
