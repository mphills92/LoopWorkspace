//
//  ChooseDateViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/7/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase

class ChooseDateViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var chooseDateButton: UIButton!
    @IBOutlet weak var reservationSnapshotView: UIView!
    @IBOutlet weak var bottomButtonHolderView: UIView!
    @IBOutlet weak var selectedCourseNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerBackgroundView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var chooseTimeSlideUpView: UIView!
    @IBOutlet weak var validHoursLabel: UILabel!
    @IBOutlet weak var bottomConstraintChooseTimeSlideUpView: NSLayoutConstraint!
    @IBOutlet weak var coverSubviewsButton: UIButton!
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    let golfCoursesDB = CoursesBasicInfoDatabase()
    let coursesDetailedInfoDB = CoursesDetailedInfoDatabase()
    
    var dbRef : FIRDatabaseReference!
    var courseBasicInfoRef : FIRDatabaseReference!
    
    var detailedInformation = [String]()
    var cityState = String()
    var courseIDForDetails = String()
    var membershipHistory = String()
    var coursePrice = String()
    var operatingHoursOpen = String()
    var operatingHoursClose = String()
    
    var validStartTimeAsNSDate = NSDate()
    var validEndTimeAsNSDate = NSDate()
    
    // Necessary for NSNotificationCenter with multiple calendar page views sending information.
    var senderPageViewID = Int()
    var senderDayID = Int()
    var generalCalendarData = GeneralCalendarData()
    var currentDay = Int()
    var currentMonth = Int()
    var currentYear = Int()
    var selectedMonth = Int()
    var selectedDay = Int()

    // Pass data via segue.
    var selectedCourseNameToSendAgain = String()
    var selectedLocationToSendAgain = String()
    var selectedDateToSend = NSDate()
    var selectedTimeToSend = String()
    
    // Receive data from segue.
    var selectedCourseNameHasBeenSent: String?
    var selectedLocationHasBeenSent: String?
    var selectedCourseIDHasBeenSent: String?
    
    var selectedTime = NSDate()
    var dateFormatter = NSDateFormatter()
    let timeComponents = NSCalendar.currentCalendar().componentsInTimeZone(NSTimeZone.localTimeZone(), fromDate: NSDate())
 
    @IBAction func chooseDateButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toChooseCaddieSegue", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userHasSelectedAMonth:", name: "userHasSelectedAMonthNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userHasSelectedADay:", name: "userHasSelectedADayNotification", object: nil)
        
        

        
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
        //courseIDForDetails = selectedCourseIDHasBeenSent!
        
        currentDay = generalCalendarData.getCurrentDateInfo().currentDay
        currentMonth = generalCalendarData.getCurrentDateInfo().currentMonth
        currentYear = generalCalendarData.getCurrentDateInfo().currentYear
        
        timestampOnLoad()
        datePicker.addTarget(self, action: "timeChangedValue:", forControlEvents: UIControlEvents.ValueChanged)
        
        coursesDetailedInfoDB.getDetailedInformationForCourseID(selectedCourseIDHasBeenSent!) {
         (detailedInformationArray) -> Void in
         
            self.detailedInformation = detailedInformationArray
         
         
            self.coursePrice = self.detailedInformation[5]
            self.operatingHoursOpen = self.detailedInformation[6]
            self.operatingHoursClose = self.detailedInformation[7]
            
            self.priceLabel.text = "$\(self.coursePrice)"
         }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        coursesDetailedInfoDB.getDetailedInformationForCourseID(courseIDForDetails) {
            (detailedInformationArray) -> Void in
            self.detailedInformation = detailedInformationArray
            
            self.coursePrice = self.detailedInformation[4]
            self.operatingHoursOpen = self.detailedInformation[5]
            self.operatingHoursClose = self.detailedInformation[6]
            
        }*/
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSelectedAMonthNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSelectedADayNotification", object: self.view.window)

    }
}

extension ChooseDateViewController {
    
    func userHasSelectedAMonth(notification: NSNotification) {
        senderPageViewID = notification.object! as! Int
        
        switch (senderPageViewID) {
        case 1:
            selectedMonth = currentMonth
        case 2:
            selectedMonth = currentMonth + 1
        case 3:
            selectedMonth = currentMonth + 2
        default:
            break
        }
        
        validHours()
        displayChooseTimeSlideUpView()
    }
    
    func userHasSelectedADay(notification: NSNotification) {
        senderDayID = notification.object! as! Int
        selectedDay = senderDayID
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
        selectedTime = datePicker.date
        //dateFormatter.dateFormat = "HH:mm a"
        dateFormatter.timeStyle = .ShortStyle
        let convertedTime = dateFormatter.stringFromDate(selectedTime)
        selectedTimeToSend = convertedTime
    }
    
    func validHours() {
        dateFormatter.dateFormat = "HH:mm:ss"
        validHoursLabel.text = "\(operatingHoursOpen) AM - \(operatingHoursClose) PM"
        //validStartTimeAsNSDate = dateFormatter.dateFromString(operatingHoursOpen)!
        //validEndTimeAsNSDate = dateFormatter.dateFromString(operatingHoursClose)!
        
        //print(validStartTimeAsNSDate)
    }
    
    func evaluateSelectedTime(selectedTime: NSDate, validStartTime: NSDate, validEndTime: NSDate) -> Bool {
        if ((selectedTime.earlierDate(validEndTime) == selectedTime) && (selectedTime.laterDate(validStartTime) == selectedTime)) {
            return true
        }
        return false
    }
    
    func createSelectedDateString(selectedDay: Int, selectedMonth: Int) -> NSDate {
        let stringYear = String(currentYear)
        let stringMonth = String(selectedMonth)
        let stringDay = String(selectedDay)
        
        let dateString = "\(currentYear)" + "-\(selectedMonth)" + "-\(selectedDay)"

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") //Messes up the dateString conversion somehow...makes it think it's a day earlier than it is when selectedDateToSend is passed to the next view controller
        
        selectedDateToSend = dateFormatter.dateFromString(dateString)!
        
        return selectedDateToSend
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toChooseCaddieSegue") {
            let destinationVC = segue.destinationViewController as! CaddiesAvailableViewController
            selectedCourseNameToSendAgain = selectedCourseNameHasBeenSent!
            selectedLocationToSendAgain = selectedLocationHasBeenSent!
            
            createSelectedDateString(selectedDay, selectedMonth: selectedMonth)
            
            destinationVC.selectedCourseNameHasBeenSentAgain = selectedCourseNameToSendAgain
            destinationVC.selectedLocationHasBeenSentAgain = selectedLocationToSendAgain
            destinationVC.selectedDateHasBeenSent = selectedDateToSend
            destinationVC.selectedTimeHasBeenSent = selectedTimeToSend
        }
    }
}
