//
//  LandingPageViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 4/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController, SWRevealViewControllerDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var reservationInProgressBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var startReservationButton: UIButton!
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    let golfCoursesDB = GolfCoursesDatabase()
    
    var screenSize = UIScreen.mainScreen().bounds
    var nextReservation = NextReservation()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //-----------------------------------------------------------------------------------------
        // Call database class methods to populate data to be utilized by other view controllers.
        usersDB.getUserInformation()

        golfCoursesDB.getGolfCourseInformation {
            (courseNames) -> () in
            //print(self.golfCoursesDB.courseNames)
            //print(self.golfCoursesDB.courseIDs)
        }
        //-----------------------------------------------------------------------------------------

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
}


