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

class LandingPageViewController: UIViewController, SWRevealViewControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var reservationInProgressBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var startReservationButton: UIButton!
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    let golfCoursesDB = CoursesBasicInfoDatabase()
    
    // Variables for location services.
    var locationManager: CLLocationManager!
    
    var screenSize = UIScreen.mainScreen().bounds
    var nextReservation = NextReservation()
    
    // Reservation information loaded everytime the view appears.
    var resIDsCaddieIDs = [[String:String]]()
    
    // Passed data via segue.
    var userLatitudeToSend = Double()
    var userLongitudeToSend = Double()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        /*usersDB.getUserReservationInformation() {
            (resIDsCaddieIDsSentFromDB) -> Void in
            
            self.resIDsCaddieIDs = resIDsCaddieIDsSentFromDB
            
            var resIDsArray = [String]()
            var caddieIDsArray = [String]()
            
            for var i=0; i < self.resIDsCaddieIDs.count; i++ {
                var resIDCaddieIDDict = self.resIDsCaddieIDs[i]
                resIDsArray.append(resIDCaddieIDDict["resID"]!)
                caddieIDsArray.append(resIDCaddieIDDict["caddieID"]!)
            }
        }*/
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        revealViewController().delegate = self
        definesPresentationContext = true
        
        positionAndDisplayViewButtons()
        
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
        
        
        
        positionAndDisplayViewButtons()
        
        if (nextReservation.reservationIsWithinOneHour == true) {
            self.revealViewController().rightViewRevealWidth = 280
        } else {
            self.revealViewController().rightViewRevealWidth = 0
        }
    }
}

extension LandingPageViewController {
    
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
    
        /*let geoCoder = CLGeocoder()
        
         geoCoder.reverseGeocodeLocation(location) {
         (placemarks, error) -> Void in
         let placeArray = placemarks as [CLPlacemark]!
         var placeMark: CLPlacemark!
         placeMark = placeArray?[0]
         
         if let city = placeMark.addressDictionary?["City"] as? NSString {
         print(city)
         }
         }*/
        
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

    func positionAndDisplayViewButtons() {
        if (nextReservation.reservationIsWithinOneHour == false) {
            // Hide Check In and In Progress Buttons
            reservationInProgressBarButtonItem.enabled = false
            reservationInProgressBarButtonItem.tintColor = UIColor.clearColor()

        } else if (nextReservation.reservationIsWithinOneHour == true) {
            // Display In Progress button
            reservationInProgressBarButtonItem.enabled = true
            reservationInProgressBarButtonItem.tintColor = UIColor.whiteColor()
        }
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


