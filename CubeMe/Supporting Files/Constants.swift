//
//  Constant.swift
//  CubeMe
//
//  Created by William Fernandes on 05/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Segue {
        static let goToProfile = "goToProfile"
        static let goToAddAppointment = "goToAddAppointment"
    }
    
    struct UserDefaults {
        static let currentUser = "currentUser"
    }
    
    struct  CellName {
        static let scheduleRoomTableViewCell = "scheduleRoomTableViewCell"
    }
    
    struct FirebaseRoot {
        static let schedules = "schedules"
        static let rooms = "rooms"
        static let appointments = "appointments"
    }
}
