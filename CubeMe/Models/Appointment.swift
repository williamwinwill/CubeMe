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
    
    var date: Date?
    var roomName: String?
    
    init(description: String, hour: String) {
        
        self.description = description
        self.hour = hour
    }
    
    var dictValue: [String : Any] {
        
        return ["uid": uid,
                "description" : description,
                "hour" : hour,
                "user" : user,
                "schedule_uid": scheduleUid]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let uid = dict["uid"] as? String,
            let description = dict["description"] as? String,
            let hour = dict["hour"] as? String,
            let scheduleUid = dict["schedule_uid"] as? String
            else { return nil }
        
        self.uid = uid
        self.description = description
        self.hour = hour
        self.scheduleUid = scheduleUid
    }

}
