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
    
    //Labels
    @IBOutlet weak var lockLabel: UILabel!
    @IBOutlet weak var chairLabel: UILabel!
    @IBOutlet weak var coffeeLabel: UILabel!
    @IBOutlet weak var whiteBoardLabel: UILabel!
    @IBOutlet weak var wifiLabel: UILabel!
    @IBOutlet weak var airConditionerLabel: UILabel!
    @IBOutlet weak var projectorLabel: UILabel!
    
    
    @IBAction func lockSegmentControleTapped(_ sender: Any) {
        
        var image: UIImage?
        
        switch lockSegmentedControl.selectedSegmentIndex {
        case 0:
            image = UIImage(named:"icons-unlocked")
            
        case 1:
            image = UIImage(named:"icons-locked")
            
        default:
            print("Error")
        }
        
        lockLabel.addTextWithImage(text: "", image: image!, imageBehindText: false, keepPreviousText: false)
    }
    
    
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        setupLabelsRoom()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLabelImages()
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
            
            //Storage.rooms.append(room)
            destination.roomTableView.reloadData()
            
        default:
            print("Error")
        }
        
    }
    
    @IBAction func saveRoom(_ sender: Any) {
        performSegue(withIdentifier: "saveRoom", sender: nil)
    }
    
    
    func setupLabelsRoom(){
        
        if let room = room {
            
            nameTextField.text = room.name
            locationTextField.text = room.location
            lockSegmentedControl.selectedSegmentIndex = room.lock.hashValue
            chairTextField.text = String(room.chair)
            coffeeSegmentedControl.selectedSegmentIndex = room.coffee.hashValue
            whiteBoardSegmentedControl.selectedSegmentIndex = room.whiteBoard.hashValue
            wifiSegmentedControl.selectedSegmentIndex = room.wifi.hashValue
            airConditionerSegmentedControl.selectedSegmentIndex = room.airConditioner.hashValue
            projectorSegmentedControl.selectedSegmentIndex = room.projector.hashValue
            
        } else {
            nameTextField.text = ""
            chairTextField.text = "0"
            
        }
    }
    
    func setupNewRoom(_ room: Room){
        
        room.location = locationTextField.text!
        room.lock = Bool(truncating: lockSegmentedControl.selectedSegmentIndex as NSNumber)
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
        room?.lock = Bool(truncating: lockSegmentedControl.selectedSegmentIndex as NSNumber)
        room?.chair = Int(chairTextField.text ?? "0")!
        room?.coffee = Bool(truncating: coffeeSegmentedControl.selectedSegmentIndex as NSNumber)
        room?.whiteBoard = Bool(truncating: whiteBoardSegmentedControl.selectedSegmentIndex as NSNumber)
        room?.wifi = Bool(truncating: wifiSegmentedControl.selectedSegmentIndex as NSNumber)
        room?.airConditioner = Bool(truncating: airConditionerSegmentedControl.selectedSegmentIndex as NSNumber)
        room?.projector = Bool(truncating: projectorSegmentedControl.selectedSegmentIndex as NSNumber)
    }
    
    func setupLabelImages() {
        
        let wifiIcon = UIImage(named:"icons-wifi")
        let chairIcon = UIImage(named:"icons-chair")
        let coffeeIcon = UIImage(named:"icons-coffee-cup")
        let whiteBoardIcon = UIImage(named:"icons-white-board")
        let airConditionerIcon = UIImage(named:"icons-air-conditioning")
        let projectorIcon = UIImage(named:"icons-projector")
        
        wifiLabel.addTextWithImage(text: "", image: wifiIcon!, imageBehindText: false, keepPreviousText: false)
        chairLabel.addTextWithImage(text: "", image: chairIcon!, imageBehindText: false, keepPreviousText: false)
        coffeeLabel.addTextWithImage(text: "", image: coffeeIcon!, imageBehindText: false, keepPreviousText: false)
        whiteBoardLabel.addTextWithImage(text: "", image: whiteBoardIcon!, imageBehindText: false, keepPreviousText: false)
        airConditionerLabel.addTextWithImage(text: "", image: airConditionerIcon!, imageBehindText: false, keepPreviousText: false)
        projectorLabel.addTextWithImage(text: "", image: projectorIcon!, imageBehindText: false, keepPreviousText: false)
        setupLockLabelImage()
        
        lockLabel.tintColor  = UIColor(colorWithHexValue: 0xe3b505)
    }
    
    func setupLockLabelImage(){
        let image: UIImage?
        
        guard let room = room else
            {
                lockLabel.addTextWithImage(text: "", image: UIImage(named:"icons-unlocked")!, imageBehindText: false, keepPreviousText: false)
                return
            }
        
        if room.lock {
        image = UIImage(named:"icons-locked")
        } else {
        image = UIImage(named:"icons-unlocked")
        }
        lockLabel.addTextWithImage(text: "", image: image!, imageBehindText: false, keepPreviousText: false)
    }
    
}
