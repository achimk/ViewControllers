//
//  Autorotatable.swift
//  ViewControllers
//
//  Created by Joachim Kret on 05.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import Foundation

enum Autorotation: UInt {
    case Container = 1
    case ContainerAndTopChildren = 2
    case ContainerAndAllChildren = 3
}

protocol Autorotatable {
    var autorotation: Autorotation {get set}
}
