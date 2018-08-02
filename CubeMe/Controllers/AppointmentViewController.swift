//
//  AppointmentViewController.swift
//  CubeMe
//
//  Created by William Fernandes on 31/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController {
    
    var roomSchedule: RoomSchedule?
    
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberOfChairs: UILabel!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var iconChair: UIImageView!
    @IBOutlet weak var iconAir: UIImageView!
    @IBOutlet weak var iconCoffee: UIImageView!
    @IBOutlet weak var iconProjector: UIImageView!
    @IBOutlet weak var iconWhiteBoard: UIImageView!
    @IBOutlet weak var iconWifi: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let roomSchedule = roomSchedule,
            let room = roomSchedule.room
            else {return}
        
        roomNameLabel.text = room.name
        numberOfChairs.text = "\(room.chair)"
        
        setupIconColor(room)
        
    }
    
    func setupIconColor(_ room: Room) {
        
        iconChair.image = iconChair.image?.withRenderingMode(.alwaysTemplate)
        iconChair.tintColor = UIColor(colorWithHexValue: 0xe3b505)
        
        if room.wifi {
            iconWifi.image = iconWifi.image?.withRenderingMode(.alwaysTemplate)
            iconWifi.tintColor = UIColor(colorWithHexValue: 0xe3b505)
        }
        
        if room.projector {
            iconProjector.image = iconProjector.image?.withRenderingMode(.alwaysTemplate)
            iconProjector.tintColor = UIColor(colorWithHexValue: 0xe3b505)
        }
        
        if room.coffee {
            iconCoffee.image = iconCoffee.image?.withRenderingMode(.alwaysTemplate)
            iconCoffee.tintColor = UIColor(colorWithHexValue: 0xe3b505)
        }
        
        if room.airConditioner {
            iconAir.image = iconAir.image?.withRenderingMode(.alwaysTemplate)
            iconAir.tintColor = UIColor(colorWithHexValue: 0xe3b505)
        }
        
        if room.whiteBoard {
            iconWhiteBoard.image = iconWhiteBoard.image?.withRenderingMode(.alwaysTemplate)
            iconWhiteBoard.tintColor = UIColor(colorWithHexValue: 0xe3b505)
        }
        
    }
}
