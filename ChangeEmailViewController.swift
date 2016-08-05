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
    
    var newEmailString = String()
    var newEmailIsValid = false
    
    var confirmedEmailString = String()
    var confirmedEmailIsValid = false
    
    var userIsNavigatingBack = Bool()
    
    let userEmail = UserEmail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEmailTextField.delegate = self
        newEmailTextField.delegate = self
        confirmNewEmailTextField.delegate = self
        newEmailTextField.becomeFirstResponder()
        confirmNewEmailTextField.userInteractionEnabled = false
        
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
        self.navigationItem.rightBarButtonItem?.enabled = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        userIsNavigatingBack = true
    }
}

extension ChangeEmailViewController {
    
    func saveChanges() {
        validateConfirmedEmail(confirmedEmailString)
        
        if (confirmedEmailIsValid == true) {
            confirmNewEmailTextField.resignFirstResponder()
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
            let alertController = UIAlertController(title: "Emails don't match.", message:  "\n Your confirmed email must match the one you entered above to save account changes.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.confirmNewEmailTextField.becomeFirstResponder()
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }

        }
    }
    
    @IBAction func newEmailTextFieldEditingDidChange(sender: AnyObject) {
        newEmailString = newEmailTextField.text!
        
        if (newEmailString != "") {
            confirmNewEmailTextField.userInteractionEnabled = true
        }
    }
    
    func validateNewEmail(newEmailString: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        newEmailIsValid = emailPredicate.evaluateWithObject(newEmailString)
        return newEmailIsValid
    }
    
    @IBAction func confirmEmailTextFieldEditingDidChange(sender: AnyObject) {
        confirmedEmailString = confirmNewEmailTextField.text!
        
        if (confirmedEmailString != "") {
            self.navigationItem.rightBarButtonItem?.enabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
    }
    
    func validateConfirmedEmail(confirmedEmailString: String) -> Bool {
        if (confirmedEmailString == newEmailString) {
            confirmedEmailIsValid = true
        }
        return confirmedEmailIsValid
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch (textField.tag) {
        case 1:
            confirmedEmailString = ""
            self.navigationItem.rightBarButtonItem?.enabled = false
        default:
            break
        }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            validateNewEmail(newEmailString)
            
            if (userIsNavigatingBack == false) {
                if (newEmailIsValid == true) {
                    confirmNewEmailTextField.becomeFirstResponder()
                } else {
                    let alertController = UIAlertController(title: "Not a valid email.", message:  "\n The email that you entered is not valid. Enter a valid email before continuing. ", preferredStyle: .Alert)
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                    let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                        self.newEmailTextField.becomeFirstResponder()
                    }
                    alertController.addAction(doneAction)
                    
                    self.presentViewController(alertController, animated: true) {
                        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                    }
                }
            }
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            confirmNewEmailTextField.becomeFirstResponder()
        case 2:
            saveChanges()
        default:
            break
        }
        return true
    }
}
