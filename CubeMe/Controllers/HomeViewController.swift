//
//  ProfileViewController.swift
//  CubeMe
//
//  Created by William Fernandes on 06/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var scheduleButton: UIButton!
    
    @IBOutlet weak var myAppointmentsView: UIView!
    @IBOutlet weak var comingNexUpdateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let goToMyAppointmens = UITapGestureRecognizer(target: self, action:  #selector (self.goToMYAppointments (_:)))
        self.myAppointmentsView.addGestureRecognizer(goToMyAppointmens)
        
        self.navigationItem.hidesBackButton = true;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(back))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Manager Rooms", style: .plain, target: self, action: #selector(manageRooms))
        
        self.comingNexUpdateLabel.text = "You don't have any appointments yet."
        
        self.myAppointmentsView.layer.borderWidth = 2
        self.myAppointmentsView.layer.borderColor = UIColor(colorWithHexValue: Constants.Colors.yellow).cgColor
        self.myAppointmentsView.backgroundColor = UIColor(colorWithHexValue: Constants.Colors.blue)
        self.myAppointmentsView.layer.cornerRadius = 10;
        self.myAppointmentsView.layer.masksToBounds = true;
        
        scheduleButton.setRoundConers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateComingNext()
    }
    
    func updateComingNext() {
        
        let user = UserDefaults.standard.string(forKey: Constants.UserDefaults.currentUser)!

        AppointmentService.retriveFisrtByUser(user: user) { (appointment) in
            
            guard let appointment = appointment else { return }
            self.comingNexUpdateLabel.text = "\(appointment.roomName) on \(appointment.date.toString(dateFormat: "dd/MM/yyyy")) at \(appointment.hour)"
        }
        self.comingNexUpdateLabel.text = "You don't have any appointments yet."
        
    }
    
    //MARK: @objct funcs
    @objc func manageRooms() {
        performSegue(withIdentifier: Constants.Segue.goToRoom, sender: self )
    }
    
    @objc func back() {
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: Constants.UserDefaults.currentUser)
        self.navigationController?.popViewController(animated: true)
    }    
    
    @objc func goToMYAppointments(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: Constants.Segue.goToMyAppointment, sender: self )
    }
}
