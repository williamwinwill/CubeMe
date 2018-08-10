//
//  Room.swift
//  CubeMe
//
//  Created by William Fernandes on 28/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Room {
    
    init( name: String) {
        self.name = name
    }
    
    var uid: String = ""
    var name: String    
    var location: String = ""
    var chair: Int = 0
    var coffee: Bool = false
    var whiteBoard: Bool = false
    var wifi: Bool = false
    var airConditioner: Bool = false
    var projector: Bool = false
    
    var schedule = [Date: [Appointment]]()
    
    var dictValue: [String : Any] {
        
        return ["uid": uid,
                "name" : name,
                "location" : location,
                "chair" : chair,
                "coffee" : coffee,
                "white_board" : whiteBoard,
                "wifi" : wifi,
                "air_conditioner" : airConditioner,
                "projector" : projector]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let uid = dict["uid"] as? String,
            let name = dict["name"] as? String,
            let location = dict["location"] as? String,
            let chair = dict["chair"] as? Int,
            let coffee = dict["coffee"] as? Bool,
            let white_board = dict["white_board"] as? Bool,
            let wifi = dict["wifi"] as? Bool,
            let air_conditioner = dict["air_conditioner"] as? Bool,
            let projector = dict["projector"] as? Bool
            else { return nil }
        
        self.uid = uid
        self.name = name
        self.location = location
        self.chair = chair
        self.coffee = coffee
        self.whiteBoard = white_board
        self.wifi = wifi
        self.airConditioner = air_conditioner
        self.projector = projector
    }
    
}
