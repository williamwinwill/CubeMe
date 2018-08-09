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
    
    struct Colors {
        static let lightBlue = 0xaeecef
        static let yellow = 0xe3b505
        static let darktBlue = 0x044389
        static let darkGreen = 0x05668d
        static let blue = 0x2d89bf
        static let black = 0x0f0f0f
        
    }
    
    struct CMBoolean {
        static let cmTrue = 1
        static let cmFalse = 0
        
    }
}
