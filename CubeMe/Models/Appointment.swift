//
//  Appointment.swift
//  CubeMe
//
//  Created by William Fernandes on 31/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Appointment {
    
    var uid: String = ""
    var description: String
    var hour: String
    var user: String = ""
    var scheduleUid = ""
    
    var date: Date
    var roomName: String
    
    init(description: String, hour: String, date: Date, roomName: String) {
        
        self.description = description
        self.hour = hour
        self.date = date
        self.roomName = roomName
    }
    
    var dictValue: [String : Any] {
        
        return ["uid": uid,
                "description" : description,
                "hour" : hour,
                "user" : user,
                "schedule_uid": scheduleUid,
                "date": date.toString(dateFormat: "dd/MM/yyyyy"),
                "room_name": roomName]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let uid = dict["uid"] as? String,
            let description = dict["description"] as? String,
            let hour = dict["hour"] as? String,
            let scheduleUid = dict["schedule_uid"] as? String,
            let date = dict["date"] as? String,
            let roomName = dict["room_name"] as? String
            else { return nil }
        
        self.uid = uid
        self.description = description
        self.hour = hour
        self.scheduleUid = scheduleUid
        self.date = date.toDate(dateFormat: "dd/MM/yyyy")
        self.roomName = roomName
    }

}
