//
//  Appointment.swift
//  CubeMe
//
//  Created by William Fernandes on 31/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import Foundation

class Appointment {
    
    var description: String?
    var hour: String?
    var user: Any?
    var date: Date?
    var roomName: String?
    
    
    init(description: String, hour: String) {
        
        self.description = description
        self.hour = hour
    }
}
