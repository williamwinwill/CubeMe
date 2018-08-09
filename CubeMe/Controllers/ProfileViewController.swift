//
//  ProfileViewController.swift
//  CubeMe
//
//  Created by William Fernandes on 06/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var myAppointmensButton: UIButton!
    @IBOutlet weak var scheduleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myAppointmensButton.setRoundConers()
        scheduleButton.setRoundConers()
    }
    
    
}
