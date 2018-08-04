//
//  MyAppointment.swift
//  CubeMe
//
//  Created by William Fernandes on 03/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

class MyAppointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var appointments: [Appointment] = []
    
    @IBOutlet weak var appointmentTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointmentTableView.delegate = self
        appointmentTableView.dataSource = self
        
         self.appointmentTableView?.rowHeight = 120.0
        
        for room in Storage.rooms {
            
            //guard let schedule = room.schedule else {return}
            
            if room.schedule.count > 0 {
                for (key,value) in room.schedule {

                    for appoint in value {
                        appoint.date = key
                        appoint.roomName = room.name
                        appointments.append(appoint)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentTableViewCell") as! AppointmentTableViewCell
        let appointment = appointments[indexPath.row]
        
        cell.roomNameLabel.text = appointment.roomName
        cell.descriptionLabel.text = appointment.description
        cell.timeLabel.text = appointment.hour
        cell.dateLabel.text = appointment.date?.toString(dateFormat: "dd/MM/yyyyy")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(colorWithHexValue: 0x044389)
    }
    
}

