//
//  ForgotPasswordViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/26/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var newEmailToValidate = String()
    var newEmailIsValid = Bool()
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"HelveticaNeue-Light", size: 20)!]
        
        emailTextField.becomeFirstResponder()
        
    }
}

extension ForgotPasswordViewController{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        newEmailToValidate = emailTextField.text!
        validateNewEmail(newEmailToValidate)
        
        if (newEmailIsValid == true) {
            // TO DO: Send message to server to send password reset instructions to the input email.
            print("TO DO: Send message to server to send password reset instructions to the input email.")
            emailTextField.resignFirstResponder()
            let alertController = UIAlertController(title: "Instructions sent!", message:  "\n We've sent instructions about how to reset your password to the email that you just provided.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.dismissViewControllerAnimated(true, completion: {})
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
            
        } else {
            invalidEmailMessage()
        }
        return true
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        newEmailToValidate = emailTextField.text!
        validateNewEmail(newEmailToValidate)
        
        if (newEmailIsValid == true) {
            // TO DO: Send message to server to send password reset instructions to the input email.
            print("TO DO: Send message to server to send password reset instructions to the input email.")
            emailTextField.resignFirstResponder()
            let alertController = UIAlertController(title: "Instructions sent!", message:  "\n We've sent instructions about how to reset your password to the email that you just provided.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.dismissViewControllerAnimated(true, completion: {})
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
            
        } else {
            invalidEmailMessage()
        }
    }
    
    func invalidEmailMessage() {
        let alertController = UIAlertController(title: "Not a valid email.", message:  "\n Please enter a valid email for us to send you password reset instructions.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
        alertController.addAction(doneAction)
        
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    func validateNewEmail(newEmailToValidate: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        newEmailIsValid = emailPredicate.evaluateWithObject(newEmailToValidate)
        return newEmailIsValid
    }
    
    override func viewWillDisappear(animated: Bool) {
        emailTextField.resignFirstResponder()
    }
}
