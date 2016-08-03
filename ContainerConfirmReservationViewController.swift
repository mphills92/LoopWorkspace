//
//  ContainerConfirmReservationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/15/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerConfirmReservationViewController: UITableViewController, UITextFieldDelegate {

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
    
    @IBOutlet weak var cancelPromoCodeButton: UIButton!
    @IBOutlet weak var applyPromoCodeButton: UIButton!
    @IBOutlet weak var promoCodeTextField: UITextField!
    
    @IBOutlet weak var paymentMethodCell: UITableViewCell!
    
    
    var selectedCourseNameHasBeenSent = String()
    var selectedLocationHasBeenSent = String()
    var selectedTimeHasBeenSentAgain = String()
    
    let userReferralCode = UserReferralCode()
    let userPayment = UserPayment()
    
    var textFieldCharactersCount = Int()
    var enteredPromoCode = String()
    var promoCodeIsValid: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoCodeTextField.delegate = self
        
        self.tableView.contentInset = UIEdgeInsetsMake(-32, 0, -8, 0)

        caddieProfileImageView.layer.cornerRadius = 8
        
        cancelPromoCodeButton.hidden = true
        applyPromoCodeButton.hidden = true
        applyPromoCodeButton.layer.cornerRadius = 15

        
        // Set up NSNotifications to receive data from container's parent view controller.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUpCourseNameToDisplay:", name: "selectedCourseNameNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUpCourseLocationToDisplay:", name: "selectedCourseLocationNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUpTimeToDisplay:", name: "selectedTimeNotification", object: nil)
        
        displayPaymentMethod()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        displayReservationInformation()
    }
    
}

extension ContainerConfirmReservationViewController {
    // \u{25CF}
    
    
    func setUpCourseNameToDisplay(notification: NSNotification) {
        selectedCourseNameHasBeenSent = notification.object! as! String
        golfCourseNameLabel.text = "\(selectedCourseNameHasBeenSent)"
    }
    
    func setUpTimeToDisplay(notification: NSNotification) {
        selectedTimeHasBeenSentAgain = notification.object! as! String
        timeLabel.text = "\(selectedTimeHasBeenSentAgain)"

    }
    
    func setUpCourseLocationToDisplay(notification: NSNotification) {
        selectedLocationHasBeenSent = notification.object! as! String
        courseLocationLabel.text = "\(selectedLocationHasBeenSent)"
    }
    
    func displayReservationInformation() {
        golfCourseNameLabel.text = "\(selectedCourseNameHasBeenSent)"
        timeLabel.text = "\(selectedTimeHasBeenSentAgain)"
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 115, 0)
            //self.tableView.contentOffset = CGPointMake(0, 100)
            self.applyPromoCodeButton.hidden = false
            self.cancelPromoCodeButton.hidden = false
            }, completion: {
                (value: Bool) in
                self.tableView.scrollEnabled = false
                self.paymentMethodCell.userInteractionEnabled = false
            })
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.tableView.contentInset = UIEdgeInsetsMake(-32, 0, -8, 0)
            self.applyPromoCodeButton.hidden = true
            self.cancelPromoCodeButton.hidden = true
            }, completion: {
                (value: Bool) in
                self.tableView.scrollEnabled = true
                self.paymentMethodCell.userInteractionEnabled = true
            })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        evaluatePromoCode()
        promoCodeTextField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = promoCodeTextField.text else {return true}
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 15
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }
    
    @IBAction func infoButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Why am I charged 10% of my reservation now?", message:  "\n Our caddies need assurance in return for blocking off a 5 hour time window within their schedules. \n \n Between now and your reservation date, the 10% reservation cost that you are charged remains securely held by Loop. If you choose to cancel your reservation prior to 48 hours before your reservation, the amount will be fully refunded to your payment method. If you choose to cancel your reservation within 48 hours of the reservation or if you decide not show up to your reservation, you forfeit the amount and it is paid to the caddie you had reserved.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
        alertController.addAction(doneAction)
        
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
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
    
    @IBAction func cancelPromoCodeButtonPressed(sender: AnyObject) {
        if (enteredPromoCode == "") {
            promoCodeTextField.text = ""
        } else {
            promoCodeTextField.text = enteredPromoCode
        }
        promoCodeTextField.resignFirstResponder()
    }
    
    @IBAction func applyPromoCodeButtonPressed(sender: AnyObject) {
        evaluatePromoCode()
    }
    
    func evaluatePromoCode() {
        enteredPromoCode = promoCodeTextField.text!
        
        if (enteredPromoCode == userReferralCode.referralCode) {
            promoCodeIsValid == true
            
            let alertController = UIAlertController(title: "Happy golfing!", message: "Your promo code has been applied.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                self.promoCodeTextField.text = self.enteredPromoCode
                self.promoCodeTextField.resignFirstResponder()
            
            let doneAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            }
            
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
            
        } else {
            promoCodeTextField == false
            let alertController = UIAlertController(title: "", message: "The promo code you entered is invalid. Please try something else.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let tryAgainAction = UIAlertAction(title: "Try Again", style: .Cancel) { (action) in
                self.promoCodeTextField.text = ""
            }
            
            alertController.addAction(tryAgainAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        
        if (cellClicked == paymentMethodCell) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let paymentsViewController = storyboard.instantiateViewControllerWithIdentifier("PaymentsNavigationController") as! UIViewController
            self.presentViewController(paymentsViewController, animated: true, completion: nil)
        }
    }


}
