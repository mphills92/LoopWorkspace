//
//  ContainerConfirmReservationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/15/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerConfirmReservationViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var cancelPromoCodeButton: UIButton!
    @IBOutlet weak var applyPromoCodeButton: UIButton!
    @IBOutlet weak var promoCodeTextField: UITextField!
    
    let userReferralCode = UserReferralCode()
    
    var textFieldCharactersCount = Int()
    var enteredPromoCode = String()
    var promoCodeIsValid: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoCodeTextField.delegate = self
        
        self.tableView.contentInset = UIEdgeInsetsMake(-32, 0, -37, 0)
        
        cancelPromoCodeButton.hidden = true
        applyPromoCodeButton.hidden = true
        applyPromoCodeButton.layer.cornerRadius = 15
    }
}

extension ContainerConfirmReservationViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.tableView.contentOffset = CGPointMake(0, 100)
            self.applyPromoCodeButton.hidden = false
            self.cancelPromoCodeButton.hidden = false
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.applyPromoCodeButton.hidden = true
            self.cancelPromoCodeButton.hidden = true
            }, completion: nil)
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


}
