//
//  Appointment.swift
//  CubeMe
//
//  Created by William Fernandes on 31/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import Foundation

class Appointment {
    
    var startDate: Date
    var endDate: Date
    var description: String
    var user: Any?
    
    init(startDate: Date, endDate: Date, description: String) {
        
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
    }
}
