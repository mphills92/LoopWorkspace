//
//  StartReservationContainerViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/7/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class StartReservationContainerViewController: UITableViewController {
    
    var dateCellTapped = false
    var timeCellTapped = false
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(-36, 0, -36, 0)
        
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
                return (view.frame.height) - 88
            } else if (timeCellTapped == true) {
                return (view.frame.height) - 88
            } else {
                return 44
            }
        }
    return 44
        
    }

    func selectedCellIndex() {
        // If no cells are open, set tapped cell identifier as true and store the index of the newly openned row as openRow.
        if (aCellIsExpanded == false) {
            if (selectedRow == 0) {
                dateCellTapped = true
                openedDateCellDisclosureIndicator()
                timeCellTapped = false
                aCellIsExpanded = true
                openRow = selectedRow
            } else if (selectedRow == 1) {
                dateCellTapped = false
                timeCellTapped = true
                openedTimeCellDisclosureIndicator()
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
                aCellIsExpanded = true
                openRow = selectedRow
            } else if (selectedRow == 1) {
                dateCellTapped = false
                closedDateCellDisclosureIndicator()
                timeCellTapped = true
                openedTimeCellDisclosureIndicator()
                aCellIsExpanded = true
                openRow = selectedRow
            }
        }
        // If a cell is open and the index of the selected cell matches the open cell.
        else if (aCellIsExpanded == true && openRow == selectedRow) {
            if (selectedRow == 0) {
                dateCellTapped = false
                closedDateCellDisclosureIndicator()
                timeCellTapped = false
                aCellIsExpanded = false
            } else if (selectedRow == 1) {
                dateCellTapped = false
                timeCellTapped = false
                closedTimeCellDisclosureIndicator()
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
