//
//  RoomService.swift
//  CubeMe
//
//  Created by William Fernandes on 06/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SVProgressHUD

class RoomService {
    
    static func create(room: Room) {
        
        let rootRef = Database.database().reference()
        let newRoomRef = rootRef.child(Constants.FirebaseRoot.rooms).childByAutoId()
        let newRoomKey = newRoomRef.key
        room.uid = newRoomKey
        let roomDictionary = room.dictValue
        
        newRoomRef.updateChildValues(roomDictionary) {
            (error, reference) in
            
            if error != nil {
                
                print(error!)
                SVProgressHUD.dismiss(withDelay: 1)
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
                
            } else {
                
                print("Message saved succssfully!")
                SVProgressHUD.dismiss(withDelay: 1)
                SVProgressHUD.showSuccess(withStatus: "Room Created")
                
            }
        }
    }
    
    static func retrieve(roomViewController: RoomTableViewController) {
        
        //SVProgressHUD.show()
        roomViewController.roomArray = []
        
        let roomDB = Database.database().reference().child(Constants.FirebaseRoot.rooms)
        
        roomDB.observe(.childAdded) { (snapshot) in

            guard let room = Room(snapshot: snapshot) else {
                return
            }
            
            roomViewController.roomArray.append(room)
            roomViewController.roomTableView.reloadData()
            //SVProgressHUD.dismiss()
        }

    }
    
    static func retrieve(calendarViewController: CalendarViewController) {
        
        //SVProgressHUD.show()
        calendarViewController.roomArray = []
        
        let roomDB = Database.database().reference().child(Constants.FirebaseRoot.rooms)
        
        roomDB.observe(.childAdded) { (snapshot) in
            
            guard let room = Room(snapshot: snapshot) else {
                return
            }
            
            calendarViewController.roomArray.append(room)
            calendarViewController.scheduleRoomTableView.reloadData()
            //SVProgressHUD.dismiss()
        }
        
    }
    
    static func remove(uid: String){
        
        let roomDB = Database.database().reference().child(Constants.FirebaseRoot.rooms)
        roomDB.child(uid).removeValue()
    }
    
    static func update(uid: String, room: Room){
        
        let roomDB = Database.database().reference().child(Constants.FirebaseRoot.rooms).child(uid)
        roomDB.updateChildValues(room.dictValue)
    }
}
