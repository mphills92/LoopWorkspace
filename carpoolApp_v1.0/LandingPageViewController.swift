//
//  OurViewController.swift
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
    @IBOutlet weak var checkInButton: UIButton!
    
    var screenSize = UIScreen.mainScreen().bounds
    var nextReservation = NextReservation()
        
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
        
        checkInButton.layer.borderColor = UIColor.yellowColor().CGColor
        checkInButton.layer.borderWidth = 1
        checkInButton.layer.cornerRadius = 20
        checkInButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor

        if (nextReservation.reservationIsWithinOneHour == true && nextReservation.userHasCheckedInForNextReservation == true) {
            //self.revealViewController().rightRevealToggleAnimated(true)
            self.revealViewController().rightViewRevealWidth = 280
            print("right swipe should be available")
        } else {
            self.revealViewController().rightViewRevealWidth = 0
            //self.revealViewController().rightRevealToggleAnimated(false)
            print("right swipe should be disabled")
        }
        
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
            self.checkInButton.enabled = true
        } else {
            self.startReservationButton.enabled = false
            self.checkInButton.enabled = false
        }
    }
    
    @IBAction func startReservationButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toChooseCourseSegue", sender: self)
    }
    
    @IBAction func checkInButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toCheckInSegue", sender: self)
    }
    
    @IBAction func reservationInProgressButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toRoundInProgressSegue", sender: self)
    }
    
    @IBAction func reservationInProgressButtonSwipedUp(sender: AnyObject) {
        performSegueWithIdentifier("toRoundInProgressSegue", sender: self)
    }
    
    
    /*
    @IBAction func activeReservationButtonPressed(sender: AnyObject) {
        if (nextReservation.userHasCheckedInForNextReservation == false) {
            performSegueWithIdentifier("toCheckInSegue", sender: self)
        } else {
            performSegueWithIdentifier("toRoundInProgressSegue", sender: self)
        }
    }

    func showOrHideActiveLoopButton() {
        if (nextReservation.reservationIsWithinOneHour == true) {
            
            if (nextReservation.userHasCheckedInForNextReservation == false) {
                activeLoopButton.setTitle("Check in for reservation", forState: .Normal)
            } else {
                activeLoopButton.setTitle("Reservation in progress ...", forState: .Normal)
            }
            
        } else {
            activeLoopButton.hidden = true
        }
    }
 */
 
    func positionAndDisplayViewButtons() {
        if (nextReservation.reservationIsWithinOneHour == false) {
            // Hide Check In and In Progress Buttons
            checkInButton.hidden = true
            reservationInProgressBarButtonItem.enabled = false
            reservationInProgressBarButtonItem.tintColor = UIColor.clearColor()

        } else if (nextReservation.reservationIsWithinOneHour == true) {
            if (nextReservation.userHasCheckedInForNextReservation == false) {
                // Display Check In button
                checkInButton.hidden = false
                
                // Hide In Progress button
                reservationInProgressBarButtonItem.enabled = false
                reservationInProgressBarButtonItem.tintColor = UIColor.clearColor()
                
            } else if (nextReservation.userHasCheckedInForNextReservation == true) {
                // Display In Progress button
                reservationInProgressBarButtonItem.enabled = true
                reservationInProgressBarButtonItem.tintColor = UIColor.whiteColor()
                // Hide Check In button
                checkInButton.hidden = true

            }
        }
    }
    
    
}


