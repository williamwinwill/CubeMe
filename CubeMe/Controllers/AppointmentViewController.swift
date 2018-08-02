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
        dateLabel.text = roomSchedule.date?.toString(dateFormat: "dd/MM/yyyy")
        
        setupIconColor(room)
        
        setupHour()
        
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
    
    @IBOutlet var collectionView: UICollectionView!
    var hours: [String] = []
    
    func setupHour() {
        
        for h in 8...12 {
            hours.append("\(h) AM")
        }
        
        for h in 1...7 {
            hours.append("\(h) PM")
        }

    }
    
    
}

extension AppointmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        let hour = hours[indexPath.row]
        
        cell.oneLabel.text = hour
        
        if hour == "12 AM" {
            
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = UIColor.lightGray
            
        } else {
            
            cell.backgroundColor = UIColor(colorWithHexValue: 0x2d89bf)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(colorWithHexValue: 0xe3b505)
        cell?.selectedBackgroundView = backgroundView
        
    }
    
}
