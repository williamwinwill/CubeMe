//
//  RoomTableViewController.swift
//  CubeMe
//
//  Created by William Fernandes on 27/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

class RoomTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var rooms: [Room] = []{
//        didSet{
//            roomTableView.reloadData()
//        }
//    }
    
    @IBOutlet weak var roomTableView: UITableView!
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomTableView.delegate = self
        roomTableView.dataSource = self
        //rooms = Storage.rooms
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier//,
            else { return }
        
        switch identifier {
            
        case "roomEdit":
            
            let selectedIndex = roomTableView.indexPathForSelectedRow
            guard let index = selectedIndex?.row else {return}
            let room = Storage.rooms[index]
            
            let rvc = segue.destination as! RoomViewController
            rvc.room = room
            
        default:
            print("Error")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return rooms.count
        return Storage.rooms.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomTableViewCell") as! RoomTableViewCell
        //let room = rooms[indexPath.row]
        let room = Storage.rooms[indexPath.row]
        setupRoomCell(cell, room)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            //self.rooms.remove(at: indexPath.row)
            Storage.rooms.remove(at: indexPath.row)
            self.roomTableView.reloadData()
        }
        
        return [delete]
    }
    
    private func setupRoomCell(_ cell: RoomTableViewCell, _ room: Room) {
        cell.roomNameLabel.text = room.name
        cell.roomLocationLabel.text = room.location
        
        let image: UIImage?
        if room.lock {
            image = UIImage(named:"icons-locked")
        } else {
            image = UIImage(named:"icons-unlocked")
        }
        cell.roomLockLabel.addTextWithImage(text: "", image: image!, imageBehindText: false, keepPreviousText: false)
    }
    
}

