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
    @IBOutlet weak var saveChangesButton: UIButton!
    
    
    
    var newEmailToValidate = String()
    var newEmailIsValid = Bool()
    var confirmedEmailToValidateMatch = String()
    
    let userEmail = UserEmail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEmailTextField.delegate = self
        newEmailTextField.delegate = self
        confirmNewEmailTextField.delegate = self
        
        navigationItem.title = "Change Email"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        saveChangesButtonDisabledState()
        
        currentEmailTextField.text = userEmail.email
        
        newEmailTextField.tag = 1
        confirmNewEmailTextField.tag = 2
    }
}

extension ChangeEmailViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveChangesButtonDisabledState()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            newEmailToValidate = newEmailTextField.text!
            validateNewEmail(newEmailToValidate)
            
            if (newEmailIsValid == true) {
                self.userEmail.newEmail = newEmailToValidate
                self.confirmNewEmailTextField.becomeFirstResponder()
            } else {
                let alertController = UIAlertController(title: "Not a valid email.", message:  "\n Please enter a valid email to change your current email.", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                alertController.addAction(doneAction)
                
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }
            }
        case 2:
            confirmedEmailToValidateMatch = confirmNewEmailTextField.text!
            
            if (confirmedEmailToValidateMatch == userEmail.newEmail) {
                self.userEmail.confirmedNewEmail = confirmedEmailToValidateMatch
                saveChangesButtonEnabledState()
                self.confirmNewEmailTextField.resignFirstResponder()
            } else {
                let alertController = UIAlertController(title: "Oops, emails don't match.", message:  "\n Your confirmed email must match the one you entered above.", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                alertController.addAction(doneAction)
                
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }
            }
        default:
            break
        }
        textField.resignFirstResponder()
        return true
    }
    
    func validateNewEmail(newEmailToValidate: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        newEmailIsValid = emailPredicate.evaluateWithObject(newEmailToValidate)
        return newEmailIsValid
    }
    
    func saveChangesButtonEnabledState() {
        self.saveChangesButton.enabled = true
        self.saveChangesButton.setTitleColor(UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0), forState: .Normal)
    }
    
    func saveChangesButtonDisabledState() {
        self.saveChangesButton.enabled = false
        self.saveChangesButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }
    
    @IBAction func saveChangesButtonPressed(sender: AnyObject) {
        // Save confirmed email as user's primary email in database.
        self.userEmail.email = confirmedEmailToValidateMatch
    
        navigationController?.popViewControllerAnimated(true)
    }
    

}
