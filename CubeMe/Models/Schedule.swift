//
//  Schedule.swift
//  CubeMe
//
//  Created by William Fernandes on 06/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Schedule {
    
    var uid: String = ""
    var date: Date
    var roomUid: String
    var roomName: String
//    var uidAppointmens: [String] = [String]()

    init(date: Date, roomUid: String, roomName: String) {
        
        self.date = date
        self.roomUid = roomUid
        self.roomName = roomName
    }
    
    var dictValue: [String : Any] {
        
        return ["uid": uid,
                "date" : date.toString(dateFormat: "dd/MM/yyyy"),
                "room_uid" : roomUid,
                "room_name" : roomName]//,
//                "uidAppointmens" :uidAppointmens]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let uid = dict["uid"] as? String,
            let date = dict["date"] as? String,
            let roomUid = dict["room_uid"] as? String,
            let roomName = dict["room_name"] as? String//,
//            let uidAppointmens = dict["uidAppointmens"] as? [String]
            else { return nil }
        
        self.uid = uid
        self.date = date.toDate(dateFormat: "dd/MM/yyyy")
        self.roomUid = roomUid
        self.roomName = roomName
//        self.uidAppointmens = uidAppointmens
        
    }
}
