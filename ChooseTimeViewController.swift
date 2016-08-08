//
//  ChooseTimeViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/14/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChooseTimeViewController: UIViewController {
    
    // Dummy data!!!!
    var validStartTimeAsString = "23:59:00"
    var validStartTimeAsNSDate = NSDate()
    
    var validEndTimeAsString = "12:00:00"
    var validEndTimeAsNSDate = NSDate()
    
    @IBOutlet weak var searchCaddiesButton: UIButton!
    @IBOutlet weak var chooseTimePicker: UIDatePicker!
    @IBOutlet weak var pickerBackgroundView: UIView!
    @IBOutlet weak var reservationSnapshotView: UIView!
    @IBOutlet weak var bottomButtonHolderView: UIView!
    @IBOutlet weak var selectedCourseNameLabel: UILabel!
    
    // Pass data via segue.
    var selectedCourseNameToSendAgain = String()
    var selectedLocationToSendAgain = String()
    var selectedTimeToSend = String()
    
    // Receive data from segue.
    var selectedCourseNameHasBeenSent: String?
    var selectedLocationHasBeenSent: String?
    
    var selectedDate = NSDate()
    var dateFormatter = NSDateFormatter()
    
    let timeComponents = NSCalendar.currentCalendar().componentsInTimeZone(NSTimeZone.localTimeZone(), fromDate: NSDate())

    @IBAction func searchAvailableCaddiesButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toChooseCaddieSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose Time"
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        reservationSnapshotView.layer.shadowColor = UIColor.blackColor().CGColor
        reservationSnapshotView.layer.shadowOpacity = 0.25
        reservationSnapshotView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        bottomButtonHolderView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomButtonHolderView.layer.shadowOpacity = 0.25
        bottomButtonHolderView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        pickerBackgroundView.layer.cornerRadius = 8
        pickerBackgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        pickerBackgroundView.layer.shadowOpacity = 0.5
        pickerBackgroundView.layer.shadowOffset = CGSizeZero
        pickerBackgroundView.layer.shadowRadius = 5

        searchCaddiesButton.layer.cornerRadius = 20
        
        timestampOnLoad()
        validHours()
        
        selectedCourseNameLabel.text = selectedCourseNameHasBeenSent
        
        chooseTimePicker.addTarget(self, action: "timeChangedValue:", forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension ChooseTimeViewController {
    
    func timestampOnLoad() {
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle, timeStyle: .ShortStyle)
        selectedTimeToSend = timestamp
    }
    
    func timeChangedValue(date: NSDate) {
        selectedDate = chooseTimePicker.date
        //dateFormatter.dateFormat = "HH:mm a"
        dateFormatter.timeStyle = .ShortStyle
        let convertedTime = dateFormatter.stringFromDate(selectedDate)
        selectedTimeToSend = convertedTime
        
        
    }
    
    func validHours() {
        dateFormatter.dateFormat = "HH:mm:ss"
        validStartTimeAsNSDate = dateFormatter.dateFromString(validStartTimeAsString)!
        validEndTimeAsNSDate = dateFormatter.dateFromString(validEndTimeAsString)!
    }
    
    func evaluateSelectedTime(selectedTime: NSDate, validStartTime: NSDate, validEndTime: NSDate) -> Bool {
        if ((selectedTime.earlierDate(validEndTime) == selectedTime) && (selectedTime.laterDate(validStartTime) == selectedTime)) {
            return true
        }
        return false
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toChooseCaddieSegue") {
            let destinationVC = segue.destinationViewController as! CaddiesAvailableViewController
            selectedCourseNameToSendAgain = selectedCourseNameHasBeenSent!
            selectedLocationToSendAgain = selectedLocationHasBeenSent!

            destinationVC.selectedCourseNameHasBeenSentAgain = selectedCourseNameToSendAgain
            destinationVC.selectedLocationHasBeenSentAgain = selectedLocationToSendAgain
            destinationVC.selectedTimeHasBeenSent = selectedTimeToSend
        }
    }
}