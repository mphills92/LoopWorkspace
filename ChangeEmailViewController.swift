//
//  ChangeEmailViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/18/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChangeEmailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var currentEmailTextField: UITextField!
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var confirmNewEmailTextField: UITextField!
    
    var newEmailToValidate = String()
    var newEmailIsValid = false
    var confirmedEmailToValidate = String()
    var emailHasBeenConfirmed = false
    
    var userIsNavigatingBack = Bool()
    
    let userEmail = UserEmail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEmailTextField.delegate = self
        newEmailTextField.delegate = self
        confirmNewEmailTextField.delegate = self
        newEmailTextField.becomeFirstResponder()
        
        navigationItem.title = "Change Email"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        currentEmailTextField.text = userEmail.email
        
        newEmailTextField.tag = 1
        confirmNewEmailTextField.tag = 2
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: ("saveChanges"))
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        userIsNavigatingBack = true
    }
}

extension ChangeEmailViewController {
    
    func saveChanges() {
        // Must gather the most updated version of newEmailIsValid and emailHasBeenConfirmed before entering conditional.
        validateNewEmail(newEmailToValidate)
        validateConfirmedEmail(confirmedEmailToValidate)
        
        if (newEmailIsValid == true) {
            if (emailHasBeenConfirmed == true) {
                newEmailTextField.resignFirstResponder()
                confirmNewEmailTextField.resignFirstResponder()
                // If the user has input two validated emails that match and presses Save.
                let alertController = UIAlertController(title: "Your account changes have been saved.", message:  "", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                
                let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                    self.navigationController?.popViewControllerAnimated(true)
                }
                alertController.addAction(doneAction)
                
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }
            } else {
                // If the user has input text into "new email" text field but not "confirm email" text field, or if the email inputs for the two text fields do not match.
                let alertController = UIAlertController(title: "Emails don't match.", message:  "\n Your confirmed email must match the one you entered above to save account changes.", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                
                let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                }
                alertController.addAction(doneAction)
                
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }
            }
        } else {
            // If the user is not exiting the view but the email input has been identified as invalid.
            let alertController = UIAlertController(title: "Not a valid email.", message:  "\n The email that you entered is not valid. Enter a valid email before continuing. ", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }

        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (newEmailTextField.isFirstResponder()) {
            confirmNewEmailTextField.text = ""
        }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            // Check new email input to ensure it follows the form of a valid email address.
            validateNewEmail(newEmailToValidate)
            
            // If the user is not exiting the view and if the email input has been identified as valid (above method), the first responder is passed to the next text field.
            if (userIsNavigatingBack != true) {
                if (newEmailIsValid == true) {
                    self.userEmail.newEmail = newEmailToValidate
                    self.confirmNewEmailTextField.becomeFirstResponder()
                }
            }

        case 2:
            // Check confirmed email input to capture the most recent character input as a string.
            validateConfirmedEmail(confirmedEmailToValidate)
            // If the user deselects the "confirm email" text field, it resigns first responder.
            confirmNewEmailTextField.resignFirstResponder()
        default:
            break
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            // If the user presses return (Next) for the "new email" text field, it resigns first responder status and passes first responder status along to "confirm password" text field.
            newEmailTextField.resignFirstResponder()
            confirmNewEmailTextField.becomeFirstResponder()
        case 2:
            // If the user presses return (Done) for the "confirm email" text field, it calls the method that is called to evaluate the email input and save account information, if appropriate.
            saveChanges()
        default:
            break
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func newEmailTextFieldEditingDidChange(sender: AnyObject) {
        newEmailToValidate = newEmailTextField.text!
    }
    
    func validateNewEmail(newEmailToValidate: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        newEmailIsValid = emailPredicate.evaluateWithObject(newEmailToValidate)
        return newEmailIsValid
    }
    
    @IBAction func confirmEmailTextFieldEditingDidChange(sender: AnyObject) {
        confirmedEmailToValidate = confirmNewEmailTextField.text!

    }

    func validateConfirmedEmail(confirmedEmailToValidate: String) -> Bool {
        if (newEmailIsValid == true) {
            if (confirmedEmailToValidate == newEmailToValidate) {
                emailHasBeenConfirmed = true
            }
        }
        return emailHasBeenConfirmed
    }
}
