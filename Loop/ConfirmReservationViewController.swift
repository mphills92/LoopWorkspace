//
//  ConfirmReservationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/14/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase

class ConfirmReservationViewController: UIViewController {

    @IBOutlet weak var confirmReservationButton: UIButton!
    @IBOutlet weak var reservationSnapshotView: UIView!
    @IBOutlet weak var bottomButtonHolderView: UIView!
    @IBOutlet weak var containerBottonConstraint: NSLayoutConstraint!
    
    private var dbRef : FIRDatabaseReference!
    private var userReservationsRef : FIRDatabaseReference!
    private var reservationsRef : FIRDatabaseReference!
    
    

    // Receive data from segue.
    var selectedCourseIDHasBeenSent: String?
    var selectedCourseNameHasBeenSent: String?
    var selectedLocationHasBeenSent: String?
    var selectedDateHasBeenSentAgain: String?
    var dateDBFormatHasBeenSent: NSDate?
    var selectedTimeHasBeenSentAgain: String?
    var selectedCaddieNameHasBeenSent: String?
    
    // Variables to be set to create new Firebase database entry for the reservation.
    var currentUserID = String()
    var courseID = String()
    var resDate = String()
    var resTime = String()
    
    let userReferralCode = UserReferralCode()
    let userPayment = UserPayment()
    
    var textFieldCharactersCount = Int()
    var enteredPromoCode = String()
    var promoCodeIsValid: Bool = true
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Review Reservation"
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
        
        confirmReservationButton.layer.cornerRadius = 20        
        
        // Set up NSNotifications for passed data to pass to container.
        NSNotificationCenter.defaultCenter().postNotificationName("selectedCaddieNameNotification", object: selectedCaddieNameHasBeenSent!)
        NSNotificationCenter.defaultCenter().postNotificationName("selectedCourseNameNotification", object: selectedCourseNameHasBeenSent!)
        NSNotificationCenter.defaultCenter().postNotificationName("selectedCourseLocationNotification", object: selectedLocationHasBeenSent!)
        NSNotificationCenter.defaultCenter().postNotificationName("selectedDateNotification", object: selectedDateHasBeenSentAgain!)
        NSNotificationCenter.defaultCenter().postNotificationName("selectedTimeNotification", object: selectedTimeHasBeenSentAgain!)
        
        self.dbRef = FIRDatabase.database().reference()
        self.reservationsRef = dbRef.child("reservations_table")
        
        if let user = FIRAuth.auth()?.currentUser {
            currentUserID = user.uid
            self.userReservationsRef = dbRef.child("users").child("\(currentUserID)").child("reservations")
        }
        
        if (selectedCourseIDHasBeenSent != "") {
            courseID = selectedCourseIDHasBeenSent!
        }
        
        if (dateDBFormatHasBeenSent != nil) {
            
            let formatterDateString = NSDateFormatter()
            formatterDateString.dateFormat = "yyyy-MM-dd"
            let convertedDate = formatterDateString.stringFromDate(dateDBFormatHasBeenSent!)
            resDate = convertedDate
            
            let formatterTimeString = NSDateFormatter()
            formatterTimeString.dateFormat = "HH:mm"
            formatterTimeString.timeZone = NSTimeZone(name: "UTC")
            let convertedTime = formatterTimeString.stringFromDate(dateDBFormatHasBeenSent!)
            print(convertedTime)
            resTime = convertedTime
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
        
        // Remove NSNotifications for passed data observers.
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "selectedCaddieNameNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "selectedCourseNameNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "selectedCourseLocationNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "selectedDateNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "selectedTimeNotification", object: self.view.window)
        
    }
}
    
extension ConfirmReservationViewController {
    
    @IBAction func confirmReservationButtonPressed(sender: AnyObject) {
        
        var numberOfReservations = Int()
        var resIDsArray = [String]()
        let uuid = NSUUID().UUIDString
        
        self.userReservationsRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            numberOfReservations = Int(snapshot.childrenCount)
            
            for child in snapshot.children {
                let arrayIndexSnapshot = snapshot.childSnapshotForPath(child.key)
                let reservationIDSnapshot = arrayIndexSnapshot.value
                
                if let resID = snapshot.childSnapshotForPath("\(arrayIndexSnapshot.key)").value as? String {
                    resIDsArray.append(resID)
                }
            }
            
            resIDsArray.append(uuid)
        }
        
        self.userReservationsRef.observeEventType(FIRDataEventType.ChildAdded) {
            (snapshot: FIRDataSnapshot) in
            self.userReservationsRef.updateChildValues(["\((numberOfReservations))": "\(resIDsArray[numberOfReservations] as String)" ])
        }

        let reservationDict = ["caddie": "Yf2wQFbsTnUWXNFHNYcOhLz7oCk1",
                               "course": "\(courseID)",
                               "date": "\(resDate)",
                               "time": "\(resTime)",
                               "user": "\(currentUserID)"]

        reservationsRef.updateChildValues(["\(uuid)": {reservationDict}()])

        let alertController = UIAlertController(title: "See you on the course!", message:  "\n Reservation number: \(uuid.substringFromIndex(uuid.endIndex.advancedBy(-8))) \n \n Your reservation has been received. You can now find it listed in the Reservations section of your profile, where you can also view its details or delete it. \n \n We'll send you future reminders as the date and time of your reservation approaches.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            self.closeAllReservationProcesses()
        }
        alertController.addAction(doneAction)
        
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo! as NSDictionary).objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size.height else {
            return
        }

        //self.containerBottonConstraint.constant = keyboardHeight - 120
        view.layoutIfNeeded()
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //containerBottonConstraint.constant = 0
        view.layoutIfNeeded()
    }
    
    // Implement unwind segue method in the future.
    func closeAllReservationProcesses() {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: {})

    }
}
