//
//  RoomViewController.swift
//  CubeMe
//
//  Created by William Fernandes on 27/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit
import SVProgressHUD

class RoomViewController: UIViewController {
    
    var room: Room?
    
    //MARK: IBOutlets
    //TextFields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var lockSegmentedControl: UISegmentedControl!
    
    //Amenities
    @IBOutlet weak var chairTextField: UITextField!
    @IBOutlet weak var coffeeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var whiteBoardSegmentedControl: UISegmentedControl!
    @IBOutlet weak var wifiSegmentedControl: UISegmentedControl!
    @IBOutlet weak var airConditionerSegmentedControl: UISegmentedControl!
    @IBOutlet weak var projectorSegmentedControl: UISegmentedControl!
    
    //Images
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var chairImage: UIImageView!
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var whiteBoardImage: UIImageView!
    @IBOutlet weak var wifiImage: UIImageView!
    @IBOutlet weak var airImage: UIImageView!
    @IBOutlet weak var projectotImage: UIImageView!
    
    
    //MARK: overrides
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        setupLabelsRoom()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier,
            let destination = segue.destination as? RoomTableViewController
            else { return }
        
        switch identifier {
            
        case "saveRoom" where room != nil:
            
            setupEditRoom()
            guard let room = room else { return }
            
            RoomService.update(uid: room.uid, room: room)
            destination.roomTableView.reloadData()
            
        case "saveRoom" where room == nil:
            
            SVProgressHUD.show()
            
            let room = Room(name: nameTextField.text!)
            setupNewRoom(room)
            
            RoomService.create(room: room)
            
            destination.roomTableView.reloadData()
            
        default:
            print("Error")
        }
        
    }
    
    //MARK: IBActions
    @IBAction func lockSegmentControleTapped(_ sender: Any) {
        
        switch lockSegmentedControl.selectedSegmentIndex {
            
        case 0:
            
            UIView.transition(with: lockImage,
                              duration: 1,
                              options: .transitionCrossDissolve,
                              animations: { self.lockImage.image = UIImage(named:"icons-unlocked") },
                              completion: nil)
            
        case 1:
            
            UIView.transition(with: lockImage,
                              duration: 1,
                              options: .transitionCrossDissolve,
                              animations: { self.lockImage.image = UIImage(named:"icons-locked-color") },
                              completion: nil)
            
        default:
            print("Error")
        }
    }
    
    @IBAction func saveRoom(_ sender: Any) {
        performSegue(withIdentifier: "saveRoom", sender: nil)
    }
    
    
    @IBAction func roomSegmentControleTapped(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == Constants.CMBoolean.cmFalse {
            
            verifyTagFromSegmentControl(tag: sender.tag, onOrOff: Constants.CMBoolean.cmFalse)
        } else { 
            verifyTagFromSegmentControl(tag: sender.tag, onOrOff: Constants.CMBoolean.cmTrue)
            
        }
        
    }
    
    //MARK: funcs
    func verifyTagFromSegmentControl(tag: Int, onOrOff: Int) {
        switch tag {
        case 1:
            changeColorImage(imageView: coffeeImage, onOrOff: onOrOff)
        case 2:
            changeColorImage(imageView: whiteBoardImage, onOrOff: onOrOff)
        case 3:
            changeColorImage(imageView: wifiImage, onOrOff: onOrOff)
        case 4:
            changeColorImage(imageView: airImage, onOrOff: onOrOff)
        case 5:
            changeColorImage(imageView: projectotImage, onOrOff: onOrOff)
        default:
            print("error!")
        }
    }
    
    func changeColorImage(imageView: UIImageView, onOrOff: Int) {
        
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        if onOrOff == Constants.CMBoolean.cmFalse {
            
            imageView.tintColor = UIColor(colorWithHexValue: Constants.Colors.yellow)
            UIView.animate(withDuration: 1, animations: {
                imageView.tintColor = UIColor(colorWithHexValue: Constants.Colors.black)
            }, completion: nil)
            
        } else if onOrOff == Constants.CMBoolean.cmTrue {
            
            imageView.tintColor = UIColor(colorWithHexValue: Constants.Colors.black)
            UIView.animate(withDuration: 1, animations: {
                imageView.tintColor = UIColor(colorWithHexValue: Constants.Colors.yellow)
            }, completion: nil)
            
        }
    }
    
    //MARK: setups
    func setupLabelsRoom(){
        
        if let room = room {
            
            nameTextField.text = room.name
            locationTextField.text = room.location
            chairTextField.text = String(room.chair)
            
            coffeeSegmentedControl.selectedSegmentIndex = room.coffee.hashValue
            whiteBoardSegmentedControl.selectedSegmentIndex = room.whiteBoard.hashValue
            wifiSegmentedControl.selectedSegmentIndex = room.wifi.hashValue
            airConditionerSegmentedControl.selectedSegmentIndex = room.airConditioner.hashValue
            projectorSegmentedControl.selectedSegmentIndex = room.projector.hashValue
            
            
            setupChangeColorImage(imageView: coffeeImage, onOrOff: room.coffee.hashValue)
            setupChangeColorImage(imageView: whiteBoardImage, onOrOff: room.whiteBoard.hashValue)
            setupChangeColorImage(imageView: airImage, onOrOff: room.airConditioner.hashValue)
            setupChangeColorImage(imageView: projectotImage, onOrOff: room.projector.hashValue)
            setupChangeColorImage(imageView: wifiImage, onOrOff: room.wifi.hashValue)
            
        } else {
            nameTextField.text = ""
            chairTextField.text = "0"
            
        }
    }
    
    func setupChangeColorImage(imageView: UIImageView, onOrOff: Int) {
        
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        if onOrOff == Constants.CMBoolean.cmTrue {
            
            imageView.tintColor = UIColor(colorWithHexValue: Constants.Colors.black)
            UIView.animate(withDuration: 1, animations: {
                imageView.tintColor = UIColor(colorWithHexValue: Constants.Colors.yellow)
            }, completion: nil)
            
        }
    }
    
    func setupNewRoom(_ room: Room){
        
        room.location = locationTextField.text!
        room.chair = Int(chairTextField.text ?? "0")!
        room.coffee = Bool(truncating: coffeeSegmentedControl.selectedSegmentIndex as NSNumber)
        room.whiteBoard = Bool(truncating: whiteBoardSegmentedControl.selectedSegmentIndex as NSNumber)
        room.wifi = Bool(truncating: wifiSegmentedControl.selectedSegmentIndex as NSNumber)
        room.airConditioner = Bool(truncating: airConditionerSegmentedControl.selectedSegmentIndex as NSNumber)
        room.projector = Bool(truncating: projectorSegmentedControl.selectedSegmentIndex as NSNumber)
    }
    
    func setupEditRoom() {
        
        room?.name = nameTextField.text ?? ""
        room?.location = locationTextField.text ?? ""
        room?.chair = Int(chairTextField.text ?? "0")!
        room?.coffee = Bool(truncating: coffeeSegmentedControl.selectedSegmentIndex as NSNumber)
        room?.whiteBoard = Bool(truncating: whiteBoardSegmentedControl.selectedSegmentIndex as NSNumber)
        room?.wifi = Bool(truncating: wifiSegmentedControl.selectedSegmentIndex as NSNumber)
        room?.airConditioner = Bool(truncating: airConditionerSegmentedControl.selectedSegmentIndex as NSNumber)
        room?.projector = Bool(truncating: projectorSegmentedControl.selectedSegmentIndex as NSNumber)
    }
    
}
