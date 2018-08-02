//
//  Room.swift
//  CubeMe
//
//  Created by William Fernandes on 28/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import Foundation

class Room {
    
    init(name: String) {
        self.name = name
    }
    
    var name: String    
    var location: String = ""
    
    var lock: Bool = false
    var chair: Int = 0
    var coffee: Bool = false
    var whiteBoard: Bool = false
    var wifi: Bool = false
    var airConditioner: Bool = false
    var projector: Bool = false
    
}
