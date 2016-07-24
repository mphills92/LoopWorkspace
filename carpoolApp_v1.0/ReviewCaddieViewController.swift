//
//  ReviewCaddieViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/19/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ReviewCaddieViewController: UIViewController {
    

    @IBOutlet weak var submitReviewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()

        submitReviewButton.layer.cornerRadius = 20
    }
}

extension ReviewCaddieViewController {
    
    @IBAction func submitReviewButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Review submitted!", message: "Thanks very much for your feedback.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        let doneAction = UIAlertAction(title: "OK", style: .Default) { (action) in
// TODO: Set nextReservation.reservationIsWithinOneHour to 'false' and store in DB
// TODO: Set completed reservation ID as previousReservation.previousReservationID and store in DB
            self.presentingViewController!.dismissViewControllerAnimated(true, completion: {})
        }
        alertController.addAction(doneAction)
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    @IBAction func skipReviewButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Please remember to review your caddie soon.", message: "We highly value your reviews because they help to ensure that Loop customers have the best possible caddie ratings when making reservation decisions.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        let doneAction = UIAlertAction(title: "OK", style: .Default) { (action) in
// TODO: Set nextReservation.reservationIsWithinOneHour to 'false' and store in DB
// TODO: Set completed reservation ID as previousReservation.previousReservationID and store in DB
            self.presentingViewController!.dismissViewControllerAnimated(true, completion: {})
        }
        alertController.addAction(doneAction)
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
        
    }
    
    
}
