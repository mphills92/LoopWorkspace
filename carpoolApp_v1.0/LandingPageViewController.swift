//
//  OurViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 4/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var startReservationButton: UIButton!
    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var reservationInProgressButton: UIButton!
    
    var screenSize = UIScreen.mainScreen().bounds
    var nextReservation = NextReservation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        checkInButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        startReservationButton.layer.cornerRadius = 20
        startReservationButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        startReservationButton.layer.borderColor = UIColor.whiteColor().CGColor
        startReservationButton.layer.borderWidth = 1
        startReservationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
 
    }
}

extension LandingPageViewController {
    
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
            reservationInProgressButton.hidden = true

        } else if (nextReservation.reservationIsWithinOneHour == true) {
            if (nextReservation.userHasCheckedInForNextReservation == false) {
                // Display Check In button
                checkInButton.hidden = false
                
                // Hide In Progress button
                reservationInProgressButton.hidden = true

                
            } else if (nextReservation.userHasCheckedInForNextReservation == true) {
                // Display In Progress button
                reservationInProgressButton.hidden = false
                // Hide Check In button
                checkInButton.hidden = true

            }
        }
    }
    
    
}


