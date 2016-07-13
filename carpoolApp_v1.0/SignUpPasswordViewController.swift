//
//  SignUpPasswordViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/27/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class SignUpPasswordViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    @IBAction func createAccountButtonPressed(sender: AnyObject) {
        // TO DO: Write confirmed password to DB.
        print("TO DO: Write confirmed password to DB.")
        // TO DO: Create user account based on all inputs from sign up flow.
        print("TO DO: Create user account based on all inputs from signup process flow.")
        
        let alertController = UIAlertController(title: "Welcome to the club!", message:  "\n We're excited that you decided to become a part of the Loop community. Now let's get golfing!", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        let doneAction = UIAlertAction(title: "Continue to Home", style: .Cancel) { (action) in
            self.performSegueWithIdentifier("successfulSignUpSegue", sender: self)
        }
        alertController.addAction(doneAction)
        
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    var passwordToSave = String()
    var confirmedPasswordToValidateMatch = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        navigationItem.title = "Create Password"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        createAccountButtonDisabledState()
        
        passwordTextField.becomeFirstResponder()
        
        passwordTextField.tag = 1
        confirmPasswordTextField.tag = 2
    }
}

extension SignUpPasswordViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        createAccountButtonDisabledState()
        
        switch (textField.tag) {
        case 1:
            confirmPasswordTextField.userInteractionEnabled = false
        case 2:
            confirmPasswordTextField.userInteractionEnabled = true
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            passwordToSave = passwordTextField.text!
            confirmPasswordTextField.userInteractionEnabled = true
            confirmPasswordTextField.becomeFirstResponder()
        case 2:
            confirmedPasswordToValidateMatch = confirmPasswordTextField.text!
            
            if (confirmedPasswordToValidateMatch == passwordToSave) {
                createAccountButtonEnabledState()
                confirmPasswordTextField.resignFirstResponder()
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
    
    func createAccountButtonEnabledState() {
        self.createAccountButton.enabled = true
        self.createAccountButton.setTitleColor(UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0), forState: .Normal)
    }
    
    func createAccountButtonDisabledState() {
        self.createAccountButton.enabled = false
        self.createAccountButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }
}
