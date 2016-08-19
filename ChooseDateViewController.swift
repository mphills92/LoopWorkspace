//
//  ChooseDateViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/7/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController, UIPickerViewDelegate {
    
    // Dummy data!!!!
    var validStartTimeAsString = "23:59:00"
    var validStartTimeAsNSDate = NSDate()
    var validEndTimeAsString = "12:00:00"
    var validEndTimeAsNSDate = NSDate()
    ////////////////////
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var chooseDateButton: UIButton!
    @IBOutlet weak var reservationSnapshotView: UIView!
    @IBOutlet weak var bottomButtonHolderView: UIView!
    @IBOutlet weak var selectedCourseNameLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerBackgroundView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var chooseTimeSlideUpView: UIView!
    @IBOutlet weak var bottomConstraintChooseTimeSlideUpView: NSLayoutConstraint!
    @IBOutlet weak var coverSubviewsButton: UIButton!
    
    // Necessary for NSNotificationCenter with multiple page views sending information.
    var senderPageViewID = Int()

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
 
    
    
    @IBAction func chooseDateButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toChooseCaddieSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Choose Date"
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        bottomConstraintChooseTimeSlideUpView.constant = -360
        datePickerBackgroundView.layer.borderColor = UIColor.lightGrayColor().CGColor
        datePickerBackgroundView.layer.borderWidth = 1
        coverSubviewsButton.alpha = 0
        coverSubviewsButton.hidden = true
        chooseDateButton.layer.cornerRadius = 20
        
        reservationSnapshotView.layer.shadowColor = UIColor.blackColor().CGColor
        reservationSnapshotView.layer.shadowOpacity = 0.25
        reservationSnapshotView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        bottomButtonHolderView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomButtonHolderView.layer.shadowOpacity = 0.25
        bottomButtonHolderView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        chooseTimeSlideUpView.layer.shadowColor = UIColor.blackColor().CGColor
        chooseTimeSlideUpView.layer.shadowOpacity = 0.25
        chooseTimeSlideUpView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        navigationBar.barTintColor = UIColor.whiteColor()
        navigationBar.barStyle = UIBarStyle.Default
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        selectedCourseNameLabel.text = selectedCourseNameHasBeenSent
        
        timestampOnLoad()
        validHours()
        datePicker.addTarget(self, action: "timeChangedValue:", forControlEvents: UIControlEvents.ValueChanged)
 

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userHasSelectedADate:", name: "userHasSelectedADateNotification", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSelectedADateNotification", object: self.view.window)

    }
}

extension ChooseDateViewController {
    
    func userHasSelectedADate(notification: NSNotification) {
        senderPageViewID = notification.object! as! Int
        displayChooseTimeSlideUpView()
    }
    
    @IBAction func cancelTimeSelectionButtonPressed(sender: AnyObject) {
        closeChooseTimeSlideUpView()
    }
    
    @IBAction func coverSubviewsButtonPressed(sender: AnyObject) {
        closeChooseTimeSlideUpView()
    }
    
    func displayChooseTimeSlideUpView() {
        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.bottomConstraintChooseTimeSlideUpView.constant = -60
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.coverSubviewsButton.alpha = 0.5
            self.coverSubviewsButton.hidden = false
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func closeChooseTimeSlideUpView() {
        
        switch (senderPageViewID) {
        case 1:
            NSNotificationCenter.defaultCenter().postNotificationName("userCanceledTimeSelectionNotificationMonthOne", object: nil)
        case 2:
            NSNotificationCenter.defaultCenter().postNotificationName("userCanceledTimeSelectionNotificationMonthTwo", object: nil)
        case 3:
            NSNotificationCenter.defaultCenter().postNotificationName("userCanceledTimeSelectionNotificationMonthThree", object: nil)
        default:
            break
        }
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.bottomConstraintChooseTimeSlideUpView.constant = -360
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.1, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.coverSubviewsButton.alpha = 0
            self.coverSubviewsButton.hidden = true
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    
    func timestampOnLoad() {
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle, timeStyle: .ShortStyle)
        selectedTimeToSend = timestamp
    }
    
    func timeChangedValue(date: NSDate) {
        selectedDate = datePicker.date
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
