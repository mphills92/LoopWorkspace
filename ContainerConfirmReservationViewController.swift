//
//  ContainerConfirmReservationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/15/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerConfirmReservationViewController: UITableViewController {

    @IBOutlet weak var caddieProfileImageView: UIImageView!
    @IBOutlet weak var caddieNameLabel: UILabel!
    @IBOutlet weak var membershipHistoryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var golfCourseNameLabel: UILabel!
    @IBOutlet weak var courseLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var noPaymentMethodLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var paymentCardNumberLabel: UILabel!
    @IBOutlet weak var paymentMethodCell: UITableViewCell!
    
    @IBOutlet weak var promoCodeLabel: UILabel!
    
    var selectedCaddieNameHasBeenSent = String()
    var selectedCourseNameHasBeenSent = String()
    var selectedLocationHasBeenSent = String()
    var selectedDateHasBeenSentAgain = String()
    var selectedTimeHasBeenSentAgain = String()
    
    var acceptedPromoCode = String()
    
    let userPayment = UserPayment()
    
    var paymentMethodCellHasBeenTappedBefore = false
    var reservationFeeInformationCellHasBeenTappedBefore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)

        caddieProfileImageView.layer.cornerRadius = 50

        // Set up NSNotifications to receive data from container's parent view controller.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUpCaddieNameToDisplay:", name: "selectedCaddieNameNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUpCourseNameToDisplay:", name: "selectedCourseNameNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUpCourseLocationToDisplay:", name: "selectedCourseLocationNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUpDateToDisplay:", name: "selectedDateNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUpTimeToDisplay:", name: "selectedTimeNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayAcceptedPromoCode:", name: "acceptedPromoCodeNotification", object: nil)
        
        displayPaymentMethod()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        displayReservationInformation()
    }
    
}

extension ContainerConfirmReservationViewController {
    // \u{25CF}
    
    
    func setUpCaddieNameToDisplay(notification: NSNotification) {
        selectedCaddieNameHasBeenSent = notification.object! as! String
        caddieNameLabel.text = "\(selectedCaddieNameHasBeenSent)"
    }
    
    func setUpCourseNameToDisplay(notification: NSNotification) {
        selectedCourseNameHasBeenSent = notification.object! as! String
        golfCourseNameLabel.text = "\(selectedCourseNameHasBeenSent)"
    }
    
    func setUpDateToDisplay(notification: NSNotification) {
        selectedDateHasBeenSentAgain = notification.object! as! String
        dateLabel.text = "\(selectedDateHasBeenSentAgain)"
    }
    
    func setUpTimeToDisplay(notification: NSNotification) {
        selectedTimeHasBeenSentAgain = notification.object! as! String
        timeLabel.text = "\(selectedTimeHasBeenSentAgain)"
    }
    
    func setUpCourseLocationToDisplay(notification: NSNotification) {
        selectedLocationHasBeenSent = notification.object! as! String
        courseLocationLabel.text = "\(selectedLocationHasBeenSent)"
    }
    
    func displayAcceptedPromoCode(notification: NSNotification) {
        acceptedPromoCode = notification.object! as! String
        promoCodeLabel.text = "\(acceptedPromoCode)"
        
    }
    
    func displayReservationInformation() {
        golfCourseNameLabel.text = "\(selectedCourseNameHasBeenSent)"
        timeLabel.text = "\(selectedTimeHasBeenSentAgain)"
    }
    
    /*
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }*/
    
    @IBAction func infoButtonPressed(sender: AnyObject) {
        reservationFeeInformationCellHasBeenTappedBefore = true
        performSegueWithIdentifier("toReservationFeeInformationSegue", sender: self)
    }
    
    func displayPaymentMethod() {
        if (userPayment.paymentMethod == "") {
            noPaymentMethodLabel.hidden = false
            paymentMethodLabel.hidden = true
            paymentCardNumberLabel.hidden = true
        } else {
            noPaymentMethodLabel.hidden = true
            paymentMethodLabel.hidden = false
            paymentCardNumberLabel.hidden = false
        }
    }
    
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        
        if (cellClicked == paymentMethodCell) {
            paymentMethodCellHasBeenTappedBefore = true
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let paymentsViewController = storyboard.instantiateViewControllerWithIdentifier("PaymentsNavigationController") as! UIViewController
            self.presentViewController(paymentsViewController, animated: true, completion: nil)
        }
    }*/
 
}
