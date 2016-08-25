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
    @IBOutlet weak var createAccountTableViewCell: UITableViewCell!
    
    var newPasswordString = String()
    
    var confirmedPasswordString = String()
    var confirmedPasswordIsValid = false
    
    var userIsNavigatingBack = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.becomeFirstResponder()
        
        navigationItem.title = "Create Password"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        passwordTextField.tag = 1
        confirmPasswordTextField.tag = 2
    }
}

extension SignUpPasswordViewController {
    
    
    @IBAction func newPasswordTextFieldEditingDidChange(sender: AnyObject) {
        newPasswordString = passwordTextField.text!
    }
    
    @IBAction func confirmPasswordTextFieldEditingDidChange(sender: AnyObject) {
        confirmedPasswordString = confirmPasswordTextField.text!
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            confirmPasswordTextField.becomeFirstResponder()
        case 2:
            validateConfirmedPassword(confirmedPasswordString)
        default:
            break
        }
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if cellClicked == createAccountTableViewCell {
            validateConfirmedPassword(confirmedPasswordString)
        }
    }
    
    func validateConfirmedPassword(confirmedPasswordString: String) {

        if (confirmedPasswordString == newPasswordString) {
            confirmedPasswordIsValid = true
            createAccount(confirmedPasswordIsValid)
        } else {
            confirmedPasswordIsValid = false
            createAccount(confirmedPasswordIsValid)
        }

    }
    
    func createAccount(confirmedPasswordInValid: Bool) {
        if (confirmedPasswordIsValid == true) {
            let alertController = UIAlertController(title: "Welcome to the club!", message:  "\n We're excited that you decided to become a part of the Loop community. Now let's get golfing!", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            let doneAction = UIAlertAction(title: "Continue to Home", style: .Cancel) { (action) in
                self.performSegueWithIdentifier("successfulSignUpSegue", sender: self)
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
            
        } else {
            let alertController = UIAlertController(title: "Passwords don't match.", message:  "\n Unlike your socks, the passwords entered here must match before you may create your account. ", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        }
    }
}
