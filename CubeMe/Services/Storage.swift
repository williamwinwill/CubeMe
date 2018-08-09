//
//  Storage.swift
//  CubeMe
//
//  Created by William Fernandes on 30/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

class Storage {
    
    static var rooms: [Room] = []
    
    static var roomsDate: [Room] = []
    
    static var hours: [String] = []
    
    private static var names = ["Turing", "Doge", "Matz"]
    
    static func start() {
        
        for index in 1...3 {
            //let room = Room(uid: index, name: "Room \(names[index-1])")
            let room = Room(name: "Room \(names[index-1])")
            room.location = "Basement"
            room.chair = 3 + index
            room.airConditioner = true
            room.whiteBoard = true
            room.wifi = true
            
            rooms.append(room)
            
//            RoomService.create(room: room)
            
            let s = Schedule(date: Date(), roomUid: room.uid, roomName: room.name)

//            ScheduleService.create(schedule: s)
            
            for newIndex in 1...3 {
                let a = Appointment(description: "Conference \(index)", hour: "\(newIndex) PM", date: s.date, roomName: s.roomName)
                a.scheduleUid = s.uid
//                AppointmentService.create(appointment: a)
            }
            
        }
        
        setupHour()
    }
    
    static func setupHour() {
        
        for h in 8...11 {
            hours.append("\(h) AM")
        }
        hours.append("12 PM")
        for h in 1...7 {
            hours.append("\(h) PM")
        }
        
    }
}
