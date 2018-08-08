//
//  AppointmentViewController.swift
//  CubeMe
//
//  Created by William Fernandes on 31/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit
import Firebase

class AppointmentViewController: UIViewController {
    
    var dateParam: Date?
    var roomParam: Room?
    var schedule: Schedule?
    var appointmentArray: [Appointment]?
    var hour: String?
    
    //Labels
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberOfChairs: UILabel!
    
    //Input
    @IBOutlet weak var descriptionTextField: UITextField!
    
    //Icons
    @IBOutlet weak var iconChair: UIImageView!
    @IBOutlet weak var iconAir: UIImageView!
    @IBOutlet weak var iconCoffee: UIImageView!
    @IBOutlet weak var iconProjector: UIImageView!
    @IBOutlet weak var iconWhiteBoard: UIImageView!
    @IBOutlet weak var iconWifi: UIImageView!
    
    //Collection
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addTapped))
        
        //Dismiss Keyboard
        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        guard let room = roomParam, let date = dateParam
            else {return}
        
        roomNameLabel.text = room.name
        numberOfChairs.text = "\(room.chair)"
        dateLabel.text = date.toString(dateFormat: "dd/MM/yyyy")
        
        setupIconColor(room)
        
        collectionView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let room = roomParam, let date = dateParam
            else {return}
        
        ScheduleService.retriveWithDateAndRoom(date: date.toString(dateFormat: "dd/MM/yyyy"), uidRoom: room.uid) { (schedule) in
            guard let result = schedule else {
                let newSchedule = Schedule(date: date, roomUid: room.uid, roomName: room.name)
                ScheduleService.create(schedule: newSchedule)
                self.schedule = newSchedule
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
                return
                
            }
            self.schedule = result
            
            AppointmentService.retriveWithSchedule(uidShedule: result.uid) { (appointments) in
                
                self.appointmentArray = appointments
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }
    
    
    @objc func addTapped() {
        
        //MARK: Add appoit
        guard let hour = hour, let schedule = schedule else {return}
        
        let appointment = Appointment(description: descriptionTextField.text!, hour: hour)
        appointment.scheduleUid = schedule.uid
        
        if var appointments = appointmentArray {
    
            let isHourThere = appointments.contains { (everyAppointment) -> Bool in
                everyAppointment.hour == appointment.hour
            }
            
            if isHourThere { return }
            
            AppointmentService.create(appointment: appointment)
            appointments.append(appointment)
            
        } else {
            AppointmentService.create(appointment: appointment)
        }
        
        navigationController?.popViewController(animated: true)
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

extension AppointmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storage.hours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        let hour = Storage.hours[indexPath.row]
        
        cell.oneLabel.text = hour
        
        //MARK: Mudar Busca
        if let appointments = appointmentArray  {
            
            let isHourThere = appointments.contains { (everyAppointment) -> Bool in
                everyAppointment.hour == hour
            }
            
            if isHourThere {
                
                cell.isUserInteractionEnabled = false
                cell.backgroundColor = UIColor.lightGray
                
            } else {
                
                cell.backgroundColor = UIColor(colorWithHexValue: 0x2d89bf)
            }
            
        } else {
            
            cell.backgroundColor = UIColor(colorWithHexValue: 0x2d89bf)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(colorWithHexValue: 0xe3b505)
        cell.selectedBackgroundView = backgroundView
        
        hour = cell.oneLabel.text
    }
    
}
