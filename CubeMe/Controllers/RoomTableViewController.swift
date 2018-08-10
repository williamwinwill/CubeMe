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
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if roomArray.count > 0 {
            
            self.roomTableView.separatorStyle = .singleLine
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            self.roomTableView.backgroundView = UIView(frame: rect)
            return 1
            
        } else {
            
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.text = "You don't have any room."
            messageLabel.textColor = UIColor(colorWithHexValue: 0xaeecef)
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
            messageLabel.sizeToFit()
            
            self.roomTableView.backgroundView = messageLabel;
            self.roomTableView.separatorStyle = .none;
            return 0
        }
    }
    
}

