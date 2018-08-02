//
//  Storage.swift
//  CubeMe
//
//  Created by William Fernandes on 30/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

class Storage {

    static var  rooms: [Room] = []
    
    static var  roomsDate: [Room] = []
    
    private var names = ["Turing", "Doge", "Matz"]
    
    init() {
        
        for index in 1...3 {
            let room = Room(name: "Room \(names[index-1])")
            room.location = "Basement"
            room.chair = 3 + index
            room.airConditioner = true
            room.whiteBoard = true
            room.wifi = true
            
            Storage.rooms.append(room)
            
        }
    }    
}
