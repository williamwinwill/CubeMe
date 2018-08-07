//
//  ScheduleService.swift
//  CubeMe
//
//  Created by William Fernandes on 06/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SVProgressHUD

class ScheduleService {
    
    static func create(schedule: Schedule) {
        
        let rootRef = Database.database().reference()
        let newScheduleRef = rootRef.child(Constants.FirebaseRoot.schedules).childByAutoId()
        let newScheduleKey = newScheduleRef.key
        schedule.uid = newScheduleKey
        
        let scheduleDictionary = schedule.dictValue
        
        newScheduleRef.updateChildValues(scheduleDictionary) {
            (error, reference) in
            
            if error != nil {
                
                print(error!)
                SVProgressHUD.dismiss(withDelay: 1)
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
                
            } else {
                
                print("Saved succssfully!")
                SVProgressHUD.dismiss(withDelay: 1)
                SVProgressHUD.showSuccess(withStatus: "Room Booked")
                
            }
        }
    }
    
    static func retrive(date: String, uidRoom: String) {
        
        let scheduleDB = Database.database().reference().child(Constants.FirebaseRoot.schedules)
        
        scheduleDB.queryOrdered(byChild: "room_name").queryEqual(toValue: "Room Turing").observeSingleEvent(of: .value) { snapshot in
            //            .observe(.value) { (snapshot) in
            //             let dispatchGroup = DispatchGroup()
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                
                guard let schedule = Schedule(snapshot: rest) else {return}
                
                print(schedule.uid)
                
                //print(schedule)
                
                //guard let restDict = rest.value as? [String: Any] else { continue }
                //let name = restDict["uid"] as? String
                
                //print(name)
                
                //                guard let room = Room(snapshot: snapshot) else {
                //                    print(snapshot)
                //                    return completion(false)
                //                }
                //                dispatchGroup.enter()
                //                print(room.uid)
                //                dispatchGroup.leave()
                //            dispatchGroup.notify(queue: .main, execute: {
                //                completion(true)
                //            })
            }
        }
    }
}


