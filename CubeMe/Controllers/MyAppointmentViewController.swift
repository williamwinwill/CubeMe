//
//  MyAppointment.swift
//  CubeMe
//
//  Created by William Fernandes on 03/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

class MyAppointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var appointmentArray: [Appointment] = []
    
    @IBOutlet weak var appointmentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointmentTableView.delegate = self
        appointmentTableView.dataSource = self
        
         self.appointmentTableView?.rowHeight = 120.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user =  UserDefaults.standard.string(forKey: Constants.UserDefaults.currentUser) else {return}
        
        AppointmentService.retriveByUser(user: user) { (appointmens) in
            self.appointmentArray = appointmens
            self.appointmentTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentTableViewCell") as! AppointmentTableViewCell
        let appointment = appointmentArray[indexPath.row]
        
        cell.roomNameLabel.text = appointment.roomName
        cell.descriptionLabel.text = appointment.description
        cell.timeLabel.text = appointment.hour
        cell.dateLabel.text = appointment.date.toString(dateFormat: "dd/MM/yyyyy")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(colorWithHexValue: 0x044389)
        cell.isUserInteractionEnabled = false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Cancel") { (action, indexPath) in
            
            let room = self.appointmentArray[indexPath.row]
            AppointmentService.remove(uid: room.uid)
            guard let user =  UserDefaults.standard.string(forKey: Constants.UserDefaults.currentUser) else {return}
            AppointmentService.retriveByUser(user: user) { (appointmens) in
                self.appointmentArray = appointmens
                self.appointmentTableView.reloadData()
            }
            self.appointmentTableView.reloadData()
        }
        
        return [delete]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        if appointmentArray.count > 0 {
            
            self.appointmentTableView.separatorStyle = .singleLine
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            self.appointmentTableView.backgroundView = UIView(frame: rect)
            return 1
            
        } else {
            
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.text = "You don't have any appointments yet."
            messageLabel.textColor = UIColor(colorWithHexValue: 0xaeecef)
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
            messageLabel.sizeToFit()
            
            self.appointmentTableView.backgroundView = messageLabel;
            self.appointmentTableView.separatorStyle = .none;
            return 0
        }
    }
}


