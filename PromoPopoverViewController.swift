//
//  PromoPopoverViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/18/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class PromoPopoverViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var blackBackground: UIButton!
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var promoCodeTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    let userReferralCode = UserReferralCode()
    
    var textFieldCharactersCount = Int()
    var enteredPromoCode = String()
    var promoCodeIsValid: Bool = true
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        closeView()
    }
    
    @IBAction func blackBackgroundPressed(sender: AnyObject) {
        closeView()
    }
    
    @IBAction func applyCodeButtonPressed(sender: AnyObject) {
        evaluatePromoCode()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoCodeTextField.delegate = self

        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 20)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        //blackBackground.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        
        popoverView.layer.cornerRadius = 8
        popoverView.layer.shadowColor = UIColor.blackColor().CGColor
        popoverView.layer.shadowOpacity = 0.5
        popoverView.layer.shadowOffset = CGSizeZero
        popoverView.layer.shadowRadius = 5
        popoverView.layer.shouldRasterize = true
        
        applyButton.layer.cornerRadius = 20
        
        promoCodeTextField.becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        promoCodeTextField.resignFirstResponder()
        
    }
}

extension PromoPopoverViewController {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        evaluatePromoCode()
        return true
    }
    
    func evaluatePromoCode() {
        enteredPromoCode = promoCodeTextField.text!
        
        if (enteredPromoCode == userReferralCode.referralCode) {
            promoCodeIsValid == true
            
            let alertController = UIAlertController(title: "Happy golfing!", message: "Your promo code has been applied.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let tryAgainAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.promoCodeTextField.text = ""
                self.dismissViewControllerAnimated(true, completion: {})
                self.closeView()
            }
            
            alertController.addAction(tryAgainAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 19/255, green: 86/255, blue: 99/255, alpha: 1.0)
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
                alertController.view.tintColor = UIColor(red: 19/255, green: 86/255, blue: 99/255, alpha: 1.0)
            }
        }
    }
    
    func closeView() {
        promoCodeTextField.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: {})
    }
}
