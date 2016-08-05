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
    
    var currentPasswordString = String()
    var currentPasswordIsValid = false
    
    var newPasswordString = String()
    
    var confirmedPasswordString = String()
    var confirmedPasswordIsValid = false
    
    var userIsNavigatingBack = Bool()
    
    let userPassword = UserPassword()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        confirmNewPasswordTextField.delegate = self
        currentPasswordTextField.becomeFirstResponder()
        newPasswordTextField.userInteractionEnabled = false
        confirmNewPasswordTextField.userInteractionEnabled = false
        
        navigationItem.title = "Change Password"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
                
        currentPasswordTextField.tag = 1
        newPasswordTextField.tag = 2
        confirmNewPasswordTextField.tag = 3
        
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

extension ChangePasswordViewController {
    
    func saveChanges() {
        validateConfirmedPassword(confirmedPasswordString)
        
        if (confirmedPasswordIsValid == true) {
            confirmNewPasswordTextField.resignFirstResponder()
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
            let alertController = UIAlertController(title: "Passwords don't match.", message:  "\n Your confirmed password must match the one you entered above.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.confirmNewPasswordTextField.becomeFirstResponder()
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        }
    }
    
    @IBAction func currentPasswordTextFieldDidChange(sender: AnyObject) {
        currentPasswordString = currentPasswordTextField.text!
        
        if (currentPasswordString != "") {
            newPasswordTextField.userInteractionEnabled = true
        }
    }
    
    func validateCurrentPassword(currentPasswordString: String) -> Bool {
        if (currentPasswordTextField.text! == userPassword.password) {
            currentPasswordIsValid = true
        }
        return currentPasswordIsValid
    }
    
    @IBAction func confirmedPasswordTextFieldDidChange(sender: AnyObject) {
        confirmedPasswordString = confirmNewPasswordTextField.text!
        
        if (confirmedPasswordString != "") {
            self.navigationItem.rightBarButtonItem?.enabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
    }
    
    func validateConfirmedPassword(confirmedPasswordString: String) -> Bool {
        if (confirmedPasswordString == newPasswordString) {
            confirmedPasswordIsValid = true
        }
        return confirmedPasswordIsValid
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch (textField.tag) {
        case 2:
            confirmedPasswordString = ""
            confirmNewPasswordTextField.userInteractionEnabled = true
            self.navigationItem.rightBarButtonItem?.enabled = false
        default:
            break
        }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            validateCurrentPassword(currentPasswordString)
            
            if (userIsNavigatingBack == false) {
                if (currentPasswordIsValid == true) {
                    newPasswordTextField.becomeFirstResponder()
                    currentPasswordTextField.userInteractionEnabled = false
                } else {
                    let alertController = UIAlertController(title: "That's not your current password.", message:  "\n You must enter your current password correctly before proceeding to change your password.", preferredStyle: .Alert)
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                    let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                        self.currentPasswordTextField.becomeFirstResponder()
                        self.newPasswordTextField.userInteractionEnabled = false
                        self.confirmNewPasswordTextField.userInteractionEnabled = false
                    }
                    alertController.addAction(doneAction)
                
                    self.presentViewController(alertController, animated: true) {
                        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                    }
                }
            }
        case 2:
            newPasswordString = newPasswordTextField.text!
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            newPasswordTextField.becomeFirstResponder()
        case 2:
            confirmNewPasswordTextField.becomeFirstResponder()
        case 3:
            saveChanges()
        default:
            break
        }
        return true
    }
}