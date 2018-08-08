//
//  AppointmentService.swift
//  CubeMe
//
//  Created by William Fernandes on 06/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SVProgressHUD

class AppointmentService {
    
    static func create(appointment: Appointment) {
        
        let rootRef = Database.database().reference()
        let newAppointmentRef = rootRef.child(Constants.FirebaseRoot.appointments).childByAutoId()
        let newAppointmentKey = newAppointmentRef.key
        appointment.uid = newAppointmentKey
        appointment.user = UserDefaults.standard.string(forKey: Constants.UserDefaults.currentUser)!
        
        let appointmentDictionary = appointment.dictValue
        
        newAppointmentRef.updateChildValues(appointmentDictionary) {
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
    
    static func retriveWithSchedule(uidShedule: String, completion: @escaping ([Appointment]) -> Void) {
        
        let appointmentDB = Database.database().reference().child(Constants.FirebaseRoot.appointments)
        let query = appointmentDB.queryOrdered(byChild: "schedule_uid").queryEqual(toValue: uidShedule)
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            let dispatchGroup = DispatchGroup()
            var result = [Appointment]()
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                guard let appointment = Appointment(snapshot: rest) else {return}
                dispatchGroup.enter()
                result.append(appointment)
                
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(result)
            })
        }
    }
    
    static func retriveWithUser(user: String, completion: @escaping ([Appointment]) -> Void) {
        
        let appointmentDB = Database.database().reference().child(Constants.FirebaseRoot.appointments)
        let query = appointmentDB.queryOrdered(byChild: "user").queryEqual(toValue: user)
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            let dispatchGroup = DispatchGroup()
            var result = [Appointment]()
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                guard let appointment = Appointment(snapshot: rest) else {return}
                dispatchGroup.enter()
                result.append(appointment)
                
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(result)
            })
        }
    }
}
