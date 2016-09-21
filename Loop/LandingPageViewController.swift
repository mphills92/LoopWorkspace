//
//  LandingPageViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 4/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import Firebase

class LandingPageViewController: UIViewController, SWRevealViewControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var reservationInProgressBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var startReservationButton: UIButton!
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    let reservationsDB = ReservationsDatabase()
    let golfCoursesDB = CoursesBasicInfoDatabase()
    
    private var dbRef : FIRDatabaseReference!
    private var reservationsRef : FIRDatabaseReference!
    private var userRef : FIRDatabaseReference!
    private var caddiesRef : FIRDatabaseReference!
    private var coursesRef : FIRDatabaseReference!
    
    // Variables for location services.
    var locationManager: CLLocationManager!
    
    var screenSize = UIScreen.mainScreen().bounds
    var nextReservation = NextReservation()
    
    var userID = String()
    
    // Reservation information loaded everytime the view appears.
    var resIDsCaddieIDs = [[String:String]]()
    var resInProgressID = String()
    var resInProgressCaddieID = String()
    
    // Send data via segue.
    var userLatitudeToSend = Double()
    var userLongitudeToSend = Double()
    var resIDToSend = String()
    
    // Data for Loop In Progress
    var caddieName = String()
    var caddieMemHist = String()
    var reservationStartTime = String()
    var courseName = String()
    var courseLocation = String()
    
    
    var dateToSend = String()
    var timeToSend = String()
    var timeNSTimeToSend = NSDate()
    
    var dateNSDateToSend = NSDate()
    
    
    ////////////
    var timestampNSDate = NSDate()
    var timestampNSTime = NSDate()
//////////
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //timestampOnAppearance()
        
        self.dbRef = FIRDatabase.database().reference()
        self.reservationsRef = dbRef.child("requests_reservations")
        self.caddiesRef = dbRef.child("caddies")
        self.coursesRef = dbRef.child("courses_basic_info")
        
        if let user = FIRAuth.auth()?.currentUser {
            userID = user.uid
            self.userRef = dbRef.child("users").child("\(userID)")
        }
        
        evaluateAllReservationsForLoopInProgress() {
            (reservationInProgressID) -> Void in
            
            if (reservationInProgressID != "" && self.resInProgressCaddieID != "") {
                self.retrieveCaddieInformationForLoopInProgress(self.resInProgressCaddieID) {
                    (true) -> Void in
                    print(self.caddieName)
                    print(self.caddieMemHist)
                    
                    self.retrieveReservationInformationForLoopInProgress(reservationInProgressID) {
                         (true) -> Void in
                        print(self.courseName)
                        print(self.courseLocation)
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        revealViewController().delegate = self
        definesPresentationContext = true
        self.view.updateConstraints()
        self.view.layoutIfNeeded()

        let navBarLogo = UIImage(named: "LoopLogoNavBarWhite")! as UIImage
        let imageView = UIImageView(image: navBarLogo)
        imageView.frame.size.width = 35.0
        imageView.frame.size.height = 35.0
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        imageViewBackground.image = UIImage(named: "LandingPageBackground")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)

        // SWRevealViewController targets and actions.
        self.revealViewController().tapGestureRecognizer()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            reservationInProgressBarButtonItem.target = self.revealViewController()
            reservationInProgressBarButtonItem.action = "rightRevealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        startReservationButton.layer.cornerRadius = 20
        startReservationButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor
        startReservationButton.layer.borderColor = UIColor.whiteColor().CGColor
        startReservationButton.layer.borderWidth = 1
        startReservationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reservationHasCompleted:", name: "reservationHasCompletedNotification", object: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

        // Register the user's current location upon appearance of the landing page.
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        // Determine if reservation is within 1 hour or ongoing and display Loop In Progress bar button item appropriately.
        if (nextReservation.reservationIsWithinOneHour == true) {
            self.revealViewController().rightViewRevealWidth = 280
        } else {
            self.revealViewController().rightViewRevealWidth = 0
        }
    }
}

extension LandingPageViewController {
    
    func timestamp() {
        let formatterToEvaluateDate = NSDateFormatter()
        formatterToEvaluateDate.dateFormat = "yyyy-MM-dd"
        let dateStampString = formatterToEvaluateDate.stringFromDate(NSDate())
        let formatterToNSDate = NSDateFormatter()
        formatterToNSDate.dateFormat = "yyyy-MM-dd"
        formatterToNSDate.timeZone = NSTimeZone(name: "UTC")
        
        timestampNSDate = formatterToNSDate.dateFromString(dateStampString)!
        
        let formatterToEvaluateTime = NSDateFormatter()
        formatterToEvaluateTime.dateFormat = "HH:mm"
        let timestampString = formatterToEvaluateTime.stringFromDate(NSDate())
        let formatterToNSTime = NSDateFormatter()
        formatterToNSTime.dateFormat = "HH:mm"
        formatterToNSTime.timeZone = NSTimeZone(name: "UTC")
        
        timestampNSTime = formatterToNSTime.dateFromString(timestampString)!
    }
    
    func evaluateAllReservationsForLoopInProgress(completion: ((String -> Void))) {
        usersDB.getUserReservationInformation() {
            (resIDsCaddieIDsSentFromDB) -> Void in
            
            self.timestamp()
            self.resInProgressID = ""
            self.resIDsCaddieIDs = resIDsCaddieIDsSentFromDB
            var resIDs = [String]()
            var caddieIDs = [String]()
            var completionCounter = 0
            
            for var y=0; y < self.resIDsCaddieIDs.count; y++ {
                var resIDCaddieIDDict = self.resIDsCaddieIDs[y]
                resIDs.append(resIDCaddieIDDict["resID"]!)
                caddieIDs.append(resIDCaddieIDDict["caddieID"]!)
            }
            
            self.reservationsDB.getConfirmedReservationsIDs(resIDs) {
                (reservationIDs) -> Void in
            
                self.reservationsRef.observeEventType(FIRDataEventType.Value) {
                    (snapshot: FIRDataSnapshot) in
                    var datesNSDatesArray = [NSDate]()

                    for var d = 0; d < reservationIDs.count; d++ {
                        if let date = snapshot.childSnapshotForPath("\(reservationIDs[d])").value?.objectForKey("date") as? String {
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            dateFormatter.timeZone = NSTimeZone(name: "UTC")
                            let formattedNSDate = dateFormatter.dateFromString(date)
                            
                            if (formattedNSDate!.compare(self.timestampNSDate) == NSComparisonResult.OrderedSame) {
                                if let time = snapshot.childSnapshotForPath("\(reservationIDs[d])").value?.objectForKey("time") as? String {
                                    let timeFormatter = NSDateFormatter()
                                    timeFormatter.dateFormat = "HH:mm"
                                    timeFormatter.timeZone = NSTimeZone(name: "UTC")
                                    let formattedNSTime = timeFormatter.dateFromString(time)
                                    
                                    let hourRemovedFromResTime = formattedNSTime?.dateByAddingTimeInterval(-3600)
                                    let fiveHoursAheadOfResTime = formattedNSTime?.dateByAddingTimeInterval(60*60*5)
                                    
                                    if (hourRemovedFromResTime!.compare(self.timestampNSTime) == NSComparisonResult.OrderedAscending) {
                                        if (fiveHoursAheadOfResTime!.compare(self.timestampNSTime) == NSComparisonResult.OrderedDescending) {
                                            self.resInProgressID = reservationIDs[d]
                                            self.resInProgressCaddieID = caddieIDs[d]
                                        }
                                    }
                                }
                            }
                            completionCounter++
                        }
                    }
                    if (completionCounter == reservationIDs.count) {
                        completion(self.resInProgressID)
                    }
                }
            }
        }
    }
    
    func retrieveCaddieInformationForLoopInProgress(resInProgressCaddieID: String, completion: ((Bool -> Void))) {
        var completionCounter = 0
        self.caddiesRef.child("\(resInProgressCaddieID)").observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
             if let first_name = snapshot.value?.objectForKey("first_name") as? String {
                if let last_name = snapshot.value?.objectForKey("last_name") as? String {
                    self.caddieName = "\(first_name) \(last_name)"
                    completionCounter++
                }
             }
            if let membership_history = snapshot.value?.objectForKey("membership_history") as? String {
                self.caddieMemHist = membership_history
                completionCounter++
            }
            if (completionCounter == 2) {
                completion(true)
            }
        }
    }
    
    func retrieveReservationInformationForLoopInProgress(reservationInProgressID: String, completion: ((Bool -> Void))) {
        var completionCounter = 0
        self.reservationsRef.child("\(reservationInProgressID)").observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            if let courseID = snapshot.value?.objectForKey("course") as? String {
                self.coursesRef.child("\(courseID)").observeEventType(FIRDataEventType.Value) {
                    (snapshot: FIRDataSnapshot) in
                    
                    if let course_name = snapshot.value?.objectForKey("name") as? String {
                        self.courseName = course_name
                        completionCounter++
                    }
                    
                    if let course_location = snapshot.value?.objectForKey("city_state") as? String {
                        self.courseLocation = course_location
                        completionCounter++
                    }
                    if (completionCounter == 2) {
                        completion(true)
                    }
                }
            }
        }
    }
    
    /*
    func evaluateActiveReservation() {
        if (nextReservation.reservationIsWithinOneHour == false) {
            // Hide In Progress Buttons
            reservationInProgressBarButtonItem.enabled = false
            reservationInProgressBarButtonItem.tintColor = UIColor.clearColor()
            
        } else if (nextReservation.reservationIsWithinOneHour == true) {
            // Display In Progress button
            reservationInProgressBarButtonItem.enabled = true
            reservationInProgressBarButtonItem.tintColor = UIColor.whiteColor()
        }
    }*/
    
    func revealController(revealController: SWRevealViewController, animateToPosition position: FrontViewPosition) {
        if position == FrontViewPosition.Left {
            self.view.alpha = 1.0
        } else if position == FrontViewPosition.RightMost {
            self.view.alpha = 1.0
        } else {
            self.view.alpha = 0.6
        }
    }
    
    func revealController(revealController: SWRevealViewController, panGestureMovedToLocation location: CGFloat, progress: CGFloat) {
        if progress > 1 {
            self.view.alpha = 0.6
        }
        else if progress == 0 {
            self.view.alpha = 1
        }
        else {
            self.view.alpha = 1 - (0.4 * progress)
        }        
    }
    
    func revealController(revealController: SWRevealViewController!, didMoveToPosition position: FrontViewPosition) {
        if (position == FrontViewPosition.Left || position == FrontViewPosition.RightMost) {
            self.startReservationButton.enabled = true
        } else {
            self.startReservationButton.enabled = false
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        var userLat = location.coordinate.latitude
        userLatitudeToSend = userLat
        var userLon = location.coordinate.longitude
        userLongitudeToSend = userLon
        
        usersDB.setUserLocation(userLat, userLon: userLon)

        self.locationManager.stopUpdatingLocation()
    }
    
    
    @IBAction func startReservationButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toChooseCourseSegue", sender: self)
    }


    
    func reservationHasCompleted(notification: NSNotification) {
            self.revealViewController().rightRevealToggleAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toChooseCourseSegue") {
            let navigationController = segue.destinationViewController as? UINavigationController
            let destinationVC = navigationController!.topViewController as! ReservationChooseCourseViewController   
            
            destinationVC.userLatitudeHasBeenSent = userLatitudeToSend
            destinationVC.userLongitudeHasBeenSent = userLongitudeToSend
        }
    }
}


