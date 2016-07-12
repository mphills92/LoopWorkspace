//
//  StartReservationContainerViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/7/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class StartReservationContainerViewController: UITableViewController {
    
    @IBOutlet weak var chooseServiceLevelSegementedControl: ChooseServiceLevelSegmentedControl!
    @IBOutlet weak var chooseNumberOfPlayersSegmentedControl: ChooseNumberOfPlayersSegmentedControl!
    
    var dateCellTapped = false
    var timeCellTapped = false
    var numberOfPlayersCellTapped = false
    var serviceLevelCellTapped = false
    var aCellIsExpanded = false
    var openRow = Int()
    var selectedRow = Int()
    
    var locationButtonForFormatting = UIButton()
    var selectedLocation = String()
    
    var selectedDate = NSDate()
    var dateFormatter = NSDateFormatter()

    var morningButtonSelected = Bool()
    var afternoonButtonSelected = Bool()
    var selectedIndex = Int()

//Choose date tableViewCell and dropdown outlet properties.
    @IBOutlet weak var chooseDateDisclosureIndicator: UIImageView!

//Choose time tableViewCell and dropdown outlet properties.
    @IBOutlet weak var chooseTimeLabel: UILabel!
    @IBOutlet weak var chooseTimePicker: UIDatePicker!
    @IBOutlet weak var chooseTimeDisclosureIndicator: UIImageView!
    
//Choose number of players tableViewCell and dropdown outlet properties.
    @IBOutlet weak var chooseNumberOfPlayersDisclosureIndicator: UIImageView!
    
//Choose service level tableViewCell and dropdown outlet properties.
    @IBOutlet weak var chooseServiceLevelDisclosureIndicator: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(-36, 0, -36, 0)
        
        chooseNumberOfPlayersSegmentedControl.hidden = true
        chooseServiceLevelSegementedControl.hidden = true
        
        morningButtonSelected = true
        afternoonButtonSelected = false

        /*
        var imageView = UIImageView(frame: self.view.frame)
        var image = UIImage(named: "LoopLogoWhite")!
        imageView.image = image
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
         */
 
        self.chooseTimePicker.setValue(UIColor.whiteColor(), forKey: "textColor")
        chooseTimePicker.addTarget(self, action: "timeChangedValue:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        selectedCellIndex()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (indexPath.row == selectedRow) {
            if (dateCellTapped == true) {
                chooseNumberOfPlayersSegmentedControl.hidden = true
                chooseServiceLevelSegementedControl.hidden = true
                return (view.frame.height) - 88
            } else if (timeCellTapped == true) {
                chooseNumberOfPlayersSegmentedControl.hidden = true
                chooseServiceLevelSegementedControl.hidden = true
                return (view.frame.height) - 88
            } else if (numberOfPlayersCellTapped == true) {
                chooseNumberOfPlayersSegmentedControl.hidden = false
                chooseServiceLevelSegementedControl.hidden = true
                return 100
            } else if (serviceLevelCellTapped == true) {
                chooseNumberOfPlayersSegmentedControl.hidden = true
                chooseServiceLevelSegementedControl.hidden = false
                return 100
            } else {
                chooseNumberOfPlayersSegmentedControl.hidden = true
                chooseServiceLevelSegementedControl.hidden = true
                return 44
            }
        }
    return 44
        
    }

    func selectedCellIndex() {
        // If no cells are open, set tapped cell identifier as true and store the index of the newly opened row as openRow.
        if (aCellIsExpanded == false) {
            if (selectedRow == 0) {
                dateCellTapped = true
                openedDateCellDisclosureIndicator()
                timeCellTapped = false
                numberOfPlayersCellTapped = false
                serviceLevelCellTapped = false
                aCellIsExpanded = true
                openRow = selectedRow
            } else if (selectedRow == 1) {
                dateCellTapped = false
                timeCellTapped = true
                openedTimeCellDisclosureIndicator()
                numberOfPlayersCellTapped = false
                serviceLevelCellTapped = false
                aCellIsExpanded = true
                openRow = selectedRow
            } else if (selectedRow == 2) {
                dateCellTapped = false
                timeCellTapped = false
                numberOfPlayersCellTapped = true
                openedPlayersCellDisclosureIndicator()
                serviceLevelCellTapped = false
                aCellIsExpanded = true
                openRow = selectedRow
            } else if (selectedRow == 3) {
                dateCellTapped = false
                timeCellTapped = false
                numberOfPlayersCellTapped = false
                serviceLevelCellTapped = true
                openedServiceLevelCellDisclosureIndicator()
                aCellIsExpanded = true
                openRow = selectedRow
            }
        }
        // If a cell is open but the index of the selected cell does not match the index of the open cell.
        else if (aCellIsExpanded == true && openRow != selectedRow) {
            if (selectedRow == 0) {
                dateCellTapped = true
                openedDateCellDisclosureIndicator()
                timeCellTapped = false
                closedTimeCellDisclosureIndicator()
                numberOfPlayersCellTapped = false
                closedPlayersCellDisclosureIndicator()
                serviceLevelCellTapped = false
                closedServiceLevelCellDisclosureIndicator()
                aCellIsExpanded = true
                openRow = selectedRow
            } else if (selectedRow == 1) {
                dateCellTapped = false
                closedDateCellDisclosureIndicator()
                timeCellTapped = true
                openedTimeCellDisclosureIndicator()
                numberOfPlayersCellTapped = false
                closedPlayersCellDisclosureIndicator()
                serviceLevelCellTapped = false
                closedServiceLevelCellDisclosureIndicator()
                aCellIsExpanded = true
                openRow = selectedRow
            } else if (selectedRow == 2) {
                dateCellTapped = false
                closedDateCellDisclosureIndicator()
                timeCellTapped = false
                closedTimeCellDisclosureIndicator()
                numberOfPlayersCellTapped = true
                openedPlayersCellDisclosureIndicator()
                serviceLevelCellTapped = false
                closedServiceLevelCellDisclosureIndicator()
                aCellIsExpanded = true
            } else if (selectedRow == 3) {
                dateCellTapped = false
                closedDateCellDisclosureIndicator()
                timeCellTapped = false
                closedTimeCellDisclosureIndicator()
                numberOfPlayersCellTapped = false
                closedPlayersCellDisclosureIndicator()
                serviceLevelCellTapped = true
                openedServiceLevelCellDisclosureIndicator()
                aCellIsExpanded = true
            }
        }
        // If a cell is open and the index of the selected cell matches the open cell.
        else if (aCellIsExpanded == true && openRow == selectedRow) {
            if (selectedRow == 0) {
                dateCellTapped = false
                closedDateCellDisclosureIndicator()
                timeCellTapped = false
                numberOfPlayersCellTapped = false
                serviceLevelCellTapped = false
                aCellIsExpanded = false
            } else if (selectedRow == 1) {
                dateCellTapped = false
                timeCellTapped = false
                closedTimeCellDisclosureIndicator()
                numberOfPlayersCellTapped = false
                serviceLevelCellTapped = false
                aCellIsExpanded = false
            } else if (selectedRow == 2) {
                dateCellTapped = false
                timeCellTapped = false
                numberOfPlayersCellTapped = false
                closedPlayersCellDisclosureIndicator()
                serviceLevelCellTapped = false
                aCellIsExpanded = false
            } else if (selectedRow == 3) {
                dateCellTapped = false
                timeCellTapped = false
                numberOfPlayersCellTapped = false
                serviceLevelCellTapped = false
                closedServiceLevelCellDisclosureIndicator()
                aCellIsExpanded = false
            }
        }
    }
    
    // Disclosure indicator dynamic orientation/animation functions.
    func openedDateCellDisclosureIndicator() {
        UIView.animateWithDuration(0.2, animations: {
            self.chooseDateDisclosureIndicator.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        })
    }
    func closedDateCellDisclosureIndicator() {
        UIView.animateWithDuration(0.2, animations: {
            self.chooseDateDisclosureIndicator.transform = CGAffineTransformMakeRotation(CGFloat(M_PI*2))
        })
    }
    func openedTimeCellDisclosureIndicator() {
        UIView.animateWithDuration(0.2, animations: {
            self.chooseTimeDisclosureIndicator.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        })
    }
    func closedTimeCellDisclosureIndicator() {
        UIView.animateWithDuration(0.2, animations: {
            self.chooseTimeDisclosureIndicator.transform = CGAffineTransformMakeRotation(CGFloat(M_PI*2))
        })
    }
    func openedPlayersCellDisclosureIndicator() {
        UIView.animateWithDuration(0.2, animations: {
            self.chooseNumberOfPlayersDisclosureIndicator.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        })
    }
    func closedPlayersCellDisclosureIndicator() {
        UIView.animateWithDuration(0.2, animations: {
            self.chooseNumberOfPlayersDisclosureIndicator.transform = CGAffineTransformMakeRotation(CGFloat(M_PI*2))
        })
    }
    func openedServiceLevelCellDisclosureIndicator() {
        UIView.animateWithDuration(0.2, animations: {
            self.chooseServiceLevelDisclosureIndicator.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        })
    }
    func closedServiceLevelCellDisclosureIndicator() {
        UIView.animateWithDuration(0.2, animations: {
            self.chooseServiceLevelDisclosureIndicator.transform = CGAffineTransformMakeRotation(CGFloat(M_PI*2))
        })
    }
    
    
    func timeChangedValue(date: NSDate) {
        selectedDate = chooseTimePicker.date
        dateFormatter.dateFormat = "HH:mm a"
        var convertedTime = dateFormatter.stringFromDate(selectedDate)
        chooseTimeLabel.text = "\(convertedTime)"
        chooseTimeLabel.textColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)

    }
    
}

extension NSLayoutConstraint {
    
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}
