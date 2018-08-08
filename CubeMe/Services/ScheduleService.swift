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
            }
        }
    }
    
    static func retriveWithDateAndRoom(date: String, uidRoom: String, completion: @escaping (Schedule?) -> Void) {
        
        let scheduleDB = Database.database().reference().child(Constants.FirebaseRoot.schedules)
        let query = scheduleDB.queryOrdered(byChild: "room_uid").queryEqual(toValue: uidRoom)
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            let dispatchGroup = DispatchGroup()
            var result: Schedule?
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                guard let schedule = Schedule(snapshot: rest) else {return}
                dispatchGroup.enter()
                if schedule.date.toString(dateFormat: "dd/MM/yyyy") == date {
                    result = schedule
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(result)
            })
        }
    }
}


