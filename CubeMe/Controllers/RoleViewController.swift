//
//  RoleViewController.swift
//  CubeMe
//
//  Created by William Fernandes on 06/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

class RoleViewController: UIViewController {
    
    @IBOutlet weak var createRoomsButton: UIButton!
    @IBOutlet weak var bookRoomsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRoomsButton.setRoundConers()
        bookRoomsButton.setRoundConers()
        
        self.navigationItem.hidesBackButton = true;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(back))
    }
    
    @objc func back() {
        let defaults = UserDefaults.standard
        defaults.set("", forKey: Constants.UserDefaults.currentUser)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func createRoomButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func bookRoomButtonPressed(_ sender: UIButton) {
    }
    
    
}
