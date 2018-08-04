//
//  Room.swift
//  CubeMe
//
//  Created by William Fernandes on 28/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import Foundation

class Room {
    
    //    init(uid: Int, name: String) {
    init( name: String) {
        self.name = name
        //self.uid = uxid
        //self.schedule = []
    }
    
    var uid: Int?
    var name: String    
    var location: String = ""
    
    var lock: Bool = false
    var chair: Int = 0
    var coffee: Bool = false
    var whiteBoard: Bool = false
    var wifi: Bool = false
    var airConditioner: Bool = false
    var projector: Bool = false
    
    var schedule = [Date: [Appointment]]()
    
}
