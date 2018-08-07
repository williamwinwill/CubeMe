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
    }
}
