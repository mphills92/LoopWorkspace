//
//  ConfirmReservationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/14/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ConfirmReservationViewController: UIViewController {
    
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var confirmReservationButton: UIButton!
    
    @IBAction func cancelViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        popoverView.layer.cornerRadius = 8
        popoverView.layer.shadowColor = UIColor.blackColor().CGColor
        popoverView.layer.shadowOpacity = 0.5
        popoverView.layer.shadowOffset = CGSizeZero
        popoverView.layer.shadowRadius = 5
        popoverView.layer.shouldRasterize = true
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0), NSFontAttributeName: UIFont.systemFontOfSize(20, weight: UIFontWeightRegular)]
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        confirmReservationButton.layer.cornerRadius = confirmReservationButton.bounds.height / 2
    }
    
    
    @IBAction func confirmReservationButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "See you on the course!", message:  "\n Your reservation has been received. You can now find it listed in the Reservations section of your profile, where you can also edit or cancel it. \n \n We'll send you future reminders as the date and time of your reservation approaches.", preferredStyle: .Alert)
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
        self.presentingViewController!.presentingViewController!.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: {})

    }
    
}
