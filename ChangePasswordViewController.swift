//
//  ChangePasswordViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/18/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var saveChangesButton: UIButton!
    
    var confirmedPasswordToValidateMatch = String()
    
    let userPassword = UserPassword()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        confirmNewPasswordTextField.delegate = self
        
        navigationItem.title = "Change Password"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        saveChangesButtonDisabledState()
        
        currentPasswordTextField.tag = 1
        newPasswordTextField.tag = 2
        confirmNewPasswordTextField.tag = 3
        
    }
}

extension ChangePasswordViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveChangesButtonDisabledState()
        
        switch (textField.tag) {
        case 1:
            currentPasswordTextField.userInteractionEnabled = true
            newPasswordTextField.userInteractionEnabled = false
            confirmNewPasswordTextField.userInteractionEnabled = false
        case 2:
            currentPasswordTextField.userInteractionEnabled = false
            newPasswordTextField.userInteractionEnabled = true
            confirmNewPasswordTextField.userInteractionEnabled = false
        case 3:
            currentPasswordTextField.userInteractionEnabled = false
            newPasswordTextField.userInteractionEnabled = true
            confirmNewPasswordTextField.userInteractionEnabled = true
        default:
            break
        }
    }
 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            if (currentPasswordTextField.text == userPassword.password) {
                newPasswordTextField.userInteractionEnabled = true
                self.newPasswordTextField.becomeFirstResponder()
            } else {
                let alertController = UIAlertController(title: "That's not your current password.", message:  "\n You must enter your current password correctly before proceeding to change your password.", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                alertController.addAction(doneAction)
                
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }
            }
        case 2:
            userPassword.newPassword = newPasswordTextField.text!
            confirmNewPasswordTextField.userInteractionEnabled = true
            self.confirmNewPasswordTextField.becomeFirstResponder()
        case 3:
            confirmedPasswordToValidateMatch = confirmNewPasswordTextField.text!
            
            if (confirmedPasswordToValidateMatch == userPassword.newPassword) {
                self.userPassword.confirmedNewPassword = confirmedPasswordToValidateMatch
                saveChangesButtonEnabledState()
                self.confirmNewPasswordTextField.resignFirstResponder()
            } else {
                let alertController = UIAlertController(title: "Oops, passwords don't match.", message:  "\n Your confirmed password must match the one you entered above.", preferredStyle: .Alert)
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

    func saveChangesButtonEnabledState() {
        self.saveChangesButton.enabled = true
        self.saveChangesButton.setTitleColor(UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0), forState: .Normal)
    }
    
    func saveChangesButtonDisabledState() {
        self.saveChangesButton.enabled = false
        self.saveChangesButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }
    
    
    @IBAction func saveChangesButtonPressed(sender: AnyObject) {
        // Save confirmed password as user's primary password in database.
        self.userPassword.password = confirmedPasswordToValidateMatch
        
        navigationController?.popViewControllerAnimated(true)
    }
    
}