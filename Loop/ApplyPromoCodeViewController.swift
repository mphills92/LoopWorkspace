//
//  ApplyPromoCodeViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/3/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ApplyPromoCodeViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBOutlet weak var applyPromoCodeButton: UIButton!
    @IBOutlet weak var promoCodeTextField: UITextField!
    
    let userReferralCode = UserReferralCode()
    
    var textFieldCharactersCount = Int()
    var enteredPromoCode = String()
    var promoCodeIsValid: Bool = true
    var acceptedPromoCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoCodeTextField.delegate = self
        promoCodeTextField.becomeFirstResponder()

        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        applyPromoCodeButton.layer.cornerRadius = 20
        

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "acceptedPromoCodeNotification", object: self.view.window)
        promoCodeTextField.resignFirstResponder()
    }
}

extension ApplyPromoCodeViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {

    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        evaluatePromoCode()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = promoCodeTextField.text else {return true}
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 15
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
            self.acceptedPromoCode = self.enteredPromoCode
            self.promoCodeTextField.resignFirstResponder()
            
            let doneAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                NSNotificationCenter.defaultCenter().postNotificationName("acceptedPromoCodeNotification", object: self.acceptedPromoCode)

                self.dismissViewControllerAnimated(true, completion: {})
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
