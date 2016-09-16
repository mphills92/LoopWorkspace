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
    let datesDB = DatesDatabase()
    
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
    var selectedCourseIDToSendAgain = String()
    var selectedCourseNameToSendAgain = String()
    var selectedLocationToSendAgain = String()
    var selectedDateToSend = NSDate()
    var selectedTimeToSend = String()
    
    // Receive data from segue.
    var selectedCourseNameHasBeenSent: String?
    var selectedLocationHasBeenSent: String?
    var selectedCourseIDHasBeenSent: String?
    
    var selectedTime = String()
    var selectedTimeToEvaluate = String()
    var dateFormatter = NSDateFormatter()
    let timeComponents = NSCalendar.currentCalendar().componentsInTimeZone(NSTimeZone.localTimeZone(), fromDate: NSDate())
 

    
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
        validHours()
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
    
    func validHours() {
        // Format valid hours (from database) from strings to NSDates.
        let validHoursDateFormatter = NSDateFormatter()
        validHoursDateFormatter.dateFormat = "HH:mm"
        let operatingHoursOpenNSDate = validHoursDateFormatter.dateFromString(operatingHoursOpen)
        let operatingHoursCloseNSDate = validHoursDateFormatter.dateFromString(operatingHoursClose)
        
        // Format valid hours NSDates back to strings to achieve 12 hour format.
        let validHoursStringFormatter = NSDateFormatter()
        validHoursStringFormatter.dateFormat = "h:mm"
        let operatingHoursOpenString = validHoursStringFormatter.stringFromDate(operatingHoursOpenNSDate!)
        let operatingHoursCloseString = validHoursStringFormatter.stringFromDate(operatingHoursCloseNSDate!)
        
        validHoursLabel.text = "\(operatingHoursOpenString) AM - \(operatingHoursCloseString) PM"
    }
    
    // Method called upon initial load in order to collect current time.
    func timestampOnLoad() {
        // Format timestamp to send as string via segue.
        let timestampToDisplay = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle, timeStyle: .ShortStyle)
        selectedTimeToSend = timestampToDisplay
        
        // Format timestamp to evaluate as string against valid hours.
        let formatterToEvaluateTime = NSDateFormatter()
        formatterToEvaluateTime.dateFormat = "HH:mm"
        let timestampToEvaluate = formatterToEvaluateTime.stringFromDate(NSDate())
        selectedTimeToEvaluate = timestampToEvaluate
    }
    
    // Method called upon change of datePicker value.
    func timeChangedValue(date: NSDate) {
        var pickerTime = datePicker.date
        
        // Format selected time to send as string via segue.
        let formatterToDisplayString = NSDateFormatter()
        formatterToDisplayString.dateFormat = "H:mm a"
        formatterToDisplayString.dateStyle = .NoStyle
        formatterToDisplayString.timeStyle = .ShortStyle
        let convertedTimeToDisplay = formatterToDisplayString.stringFromDate(pickerTime)
        selectedTimeToSend = convertedTimeToDisplay
        
        // Format selected time to evaluate as string against valid hours.
        let formatterToEvaluateTime = NSDateFormatter()
        formatterToEvaluateTime.dateFormat = "HH:mm"
        let convertedTimeToEvaluate = formatterToEvaluateTime.stringFromDate(pickerTime)
        selectedTimeToEvaluate = convertedTimeToEvaluate
    }
    

    
    // User has pressed the button to select the time and date.
    @IBAction func chooseDateButtonPressed(sender: AnyObject) {
        // Calls method to evaluate string value for selected time against string values for valid operating hours.
        evaluateSelectedTime(selectedTimeToEvaluate, operatingHoursOpen: operatingHoursOpen, operatingHoursClose: operatingHoursClose)
        
    }
    
    // Method to evaluate string value for selected time against string values for valid operating hours. Converts the string values to NSDates to evaluate against each other.
    func evaluateSelectedTime(selectedTimeToEvaluate: String, operatingHoursOpen: String, operatingHoursClose: String) -> Bool {
        let formatterToNSDate = NSDateFormatter()
        formatterToNSDate.dateFormat = "HH:mm"
        formatterToNSDate.timeZone = NSTimeZone(name: "UTC")
        
        let selectedTimeConvertedToNSDate = formatterToNSDate.dateFromString(selectedTimeToEvaluate)
        validStartTimeAsNSDate = formatterToNSDate.dateFromString(operatingHoursOpen)!
        validEndTimeAsNSDate = formatterToNSDate.dateFromString(operatingHoursClose)!
        
        if (selectedTimeConvertedToNSDate!.compare(validStartTimeAsNSDate) == NSComparisonResult.OrderedDescending) {
            if (selectedTimeConvertedToNSDate!.compare(validEndTimeAsNSDate) == NSComparisonResult.OrderedAscending) {
                selectedTime = selectedTimeToEvaluate
                createSelectedDateString(selectedDay, selectedMonth: selectedMonth, selectedTime: selectedTime)
                performSegueWithIdentifier("toChooseCaddieSegue", sender: self)
                return true
            }
        } else if (selectedTimeConvertedToNSDate!.compare(validStartTimeAsNSDate) == NSComparisonResult.OrderedSame) || (selectedTimeConvertedToNSDate!.compare(validEndTimeAsNSDate) == NSComparisonResult.OrderedSame) {
            selectedTime = selectedTimeToEvaluate
            createSelectedDateString(selectedDay, selectedMonth: selectedMonth, selectedTime: selectedTime)
            performSegueWithIdentifier("toChooseCaddieSegue", sender: self)
            return true
        }
        let alertController = UIAlertController(title: "Please choose a valid time.", message:  "\n The start time for your caddie reservation must be within the operating hours of your selected course.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        let doneAction = UIAlertAction(title: "Try Again", style: .Cancel) { (action) in
        }
        alertController.addAction(doneAction)
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
        return false
    }
    
    func createSelectedDateString(selectedDay: Int, selectedMonth: Int, selectedTime: String) -> NSDate {
        let stringYear = String(currentYear)
        let stringMonth = String(selectedMonth)
        let stringDay = String(selectedDay)
        let stringTime = selectedTime
        
        let dateString = "\(currentYear)" + "-\(selectedMonth)" + "-\(selectedDay) \(stringTime):00"

        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateStringFormatter.timeZone = NSTimeZone(name: "UTC")
        
        selectedDateToSend = dateStringFormatter.dateFromString(dateString)!

        return selectedDateToSend
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toChooseCaddieSegue") {
            let destinationVC = segue.destinationViewController as! CaddiesAvailableViewController
            selectedCourseIDToSendAgain = selectedCourseIDHasBeenSent!
            selectedCourseNameToSendAgain = selectedCourseNameHasBeenSent!
            selectedLocationToSendAgain = selectedLocationHasBeenSent!

            datesDB.getAvailableCaddieIDsForDate(selectedDateToSend)
            
            destinationVC.selectedCourseIDHasBeenSentAgain = selectedCourseIDToSendAgain
            destinationVC.selectedCourseNameHasBeenSentAgain = selectedCourseNameToSendAgain
            destinationVC.selectedLocationHasBeenSentAgain = selectedLocationToSendAgain
            destinationVC.selectedDateHasBeenSent = selectedDateToSend
            destinationVC.selectedTimeHasBeenSent = selectedTimeToSend
        }
    }
}