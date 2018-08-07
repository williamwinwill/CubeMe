//
//  UIButton+Style.swift
//  CubeMe
//
//  Created by William Fernandes on 06/08/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setRoundConers() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
