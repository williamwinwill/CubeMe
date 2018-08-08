//
//  RoomTableViewController.swift
//  CubeMe
//
//  Created by William Fernandes on 27/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit
import SVProgressHUD

class RoomTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var roomTableView: UITableView!
    
    var roomArray: [Room] = [Room]()
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomTableView.delegate = self
        roomTableView.dataSource = self
        
        RoomService.retrieve(roomViewController: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier//,
            else { return }
        
        switch identifier {
            
        case "roomEdit":
            
            let selectedIndex = roomTableView.indexPathForSelectedRow
            guard let index = selectedIndex?.row else {return}
            let room = roomArray[index]
            
            
            let rvc = segue.destination as! RoomViewController
            rvc.room = room
            
        default:
            print("Error")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomTableViewCell") as! RoomTableViewCell
        let room = roomArray[indexPath.row]
        setupRoomCell(cell, room)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(colorWithHexValue: 0x05668d)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            let room = self.roomArray[indexPath.row]
            RoomService.remove(uid: room.uid)
            RoomService.retrieve(roomViewController: self)
            self.roomTableView.reloadData()
        }
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(colorWithHexValue: 0x044389)
    }
    
    private func setupRoomCell(_ cell: RoomTableViewCell, _ room: Room) {
        
        cell.roomNameLabel.text = room.name
        cell.roomLocationLabel.text = room.location
        
        //cell.lockImageView.image = cell.lockImageView.image?.withRenderingMode(.alwaysTemplate)
        //cell.lockImageView.tintColor = UIColor(colorWithHexValue: 0xe3b505)
        
        let image: UIImage?
        if room.lock {
            image = UIImage(named:"icons-locked")
        } else {
            image = UIImage(named:"icons-unlocked")
        }
        cell.roomLockLabel.addTextWithImage(text: "", image: image!, imageBehindText: false, keepPreviousText: false)
    }
    
}

