//
//  ConfirmReservationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/14/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ConfirmReservationViewController: UIViewController {

    @IBOutlet weak var confirmReservationButton: UIButton!
    @IBOutlet weak var reservationSnapshotView: UIView!
    @IBOutlet weak var bottomButtonHolderView: UIView!

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
        // Unicode character for cells...black large dot... \u{25CF}
    }
    
    
    @IBAction func confirmReservationButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "See you on the course!", message:  "\n Your reservation has been received. You can now find it listed in the Reservations section of your profile, where you can also view its details or delete it. \n \n We'll send you future reminders as the date and time of your reservation approaches.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            self.closeAllReservationProcesses()
        }
        alertController.addAction(doneAction)
        
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    // Implement unwind segue method in the future.
    func closeAllReservationProcesses() {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: {})

    }
    
}
