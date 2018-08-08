//
//  CalendarViewController.swift
//  CubeMe
//
//  Created by William Fernandes on 31/07/18.
//  Copyright © 2018 William Fernandes. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SVProgressHUD

class CalendarViewController: UIViewController {
    
    var roomParam: Room?
    var dateParam: Date?
    var dateAll: Date = Date()
    var today: Date = Date()
    var roomArray: [Room] = [Room]()
    
    let outsideMonthColor = UIColor(colorWithHexValue: 0x584a66)
    let monthColor = UIColor.white
    let selectedMonthColor = UIColor(colorWithHexValue: 0x3a294b)
    let currentDateSelectedViewColor = UIColor(colorWithHexValue: 0x4e3f5d)
    
    let formatter = DateFormatter()
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    
    @IBOutlet weak var scheduleRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        
        scheduleRoomTableView.delegate = self
        scheduleRoomTableView.dataSource = self
        self.scheduleRoomTableView?.rowHeight = 50.0
        self.scheduleRoomTableView.backgroundColor = UIColor(colorWithHexValue: 0x044389)
        
        setupCalendarView()
    }
    
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        calendarView.scrollToDate(today)
        
        calendarView.visibleDates { visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = view as? CustomCell else { return }
        
        if cellState.dateBelongsTo != .thisMonth { return }
        
        if validCell.isSelected {
            
            validCell.selectedView.isHidden = false
            
            guard let dayString = validCell.dateLabel.text else { return }
            
            var dateString   = dateAll.toString(dateFormat: "YYYY-MM")
            dateString.append("-\(dayString)")
            let date = dateString.toDate(dateFormat: "yyyy-MM-dd")
            dateParam = date

            RoomService.retrieve(calendarViewController: self)

        } else {
            validCell.selectedView.isHidden = true
            
        }
        
    }
    
    func handleCelltextColor(view: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = view as? CustomCell  else { return }
        
        if cellState.isSelected {
            
            validCell.dateLabel.textColor = selectedMonthColor
            
        } else {
            
            if cellState.dateBelongsTo == .thisMonth {
                
                validCell.dateLabel.textColor = monthColor
                
            } else {
                
                validCell.dateLabel.textColor = outsideMonthColor
                
            }
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        
        let date = visibleDates.monthDates.first!.date
        
        dateAll = date
        
        self.formatter.dateFormat = "yyyy"
        self.year.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.month.text = self.formatter.string(from: date)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier
            else { return }
        
        switch identifier {
            
        case Constants.Segue.goToAddAppointment:
            
            guard let date = dateParam, let room = roomParam else {return}
            
            let avc = segue.destination as! AppointmentViewController
            avc.dateParam = date
            avc.roomParam = room
            
        default:
            print("Error")
        }
    }
}

extension CalendarViewController:  JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")
        let endDate = formatter.date(from: "2018 12 31")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
     
        return parameters
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        let myCustomCell = cell as! CustomCell
        myCustomCell.dateLabel.text = cellState.text
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        if cellState.dateBelongsTo != .thisMonth {
            roomArray = []
            scheduleRoomTableView.reloadData()
            return
        }
        
        
        let todayStringCorrection = today.toString(dateFormat: "dd/MM/yyyy")
        let todayCorrect = todayStringCorrection.toDate(dateFormat: "dd/MM/yyyy")

        if cellState.date < todayCorrect {

            SVProgressHUD.showError(withStatus: "Out of date!")
//            Storage.roomsDate = []
            
            roomArray = []
            scheduleRoomTableView.reloadData()
            return
        }
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        setupViewsOfCalendar(from: visibleDates)
    }
    
}

extension CalendarViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomArray.count
//        return Storage.roomsDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellName.scheduleRoomTableViewCell) as! ScheduleRoomTableViewCell
        let room = roomArray[indexPath.row]
//        let room = Storage.roomsDate[indexPath.row]
        setupRoomCell(cell, room)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(colorWithHexValue: 0x05668d)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    private func setupRoomCell(_ cell: ScheduleRoomTableViewCell, _ room: Room) {
        cell.roomNameLabel.text = room.name
        cell.roomLocationLabel.text = room.location
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let room = roomArray[indexPath.row]
//        let room = Storage.rooms[indexPath.row]
        roomParam = room
        
        performSegue(withIdentifier: Constants.Segue.goToAddAppointment, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(colorWithHexValue: 0x044389)
    }
    
}
