//
//  SignUpContactInfoViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/26/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class SignUpContactInfoViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var newEmailString = String()
    var newEmailIsValid = false
    
    var confirmedEmailString = String()
    var confirmedEmailIsValid = false
    
    var phoneString = String()
    var phoneIsValid = false
    
    var userIsNavigatingBack = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        confirmEmailTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.becomeFirstResponder()
        confirmEmailTextField.userInteractionEnabled = false
        phoneTextField.userInteractionEnabled = false
        
        //self.tableView.contentInset = UIEdgeInsetsMake(-22, 0, -22, 0)
        
        navigationItem.title = "Contact Information"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "advanceToNextSignUpStep")
        nextButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = nextButton
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        emailTextField.tag = 1
        confirmEmailTextField.tag = 2
        phoneTextField.tag = 3
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension SignUpContactInfoViewController {
    
    @IBAction func emailTextFieldEditingDidChange(sender: AnyObject) {
        newEmailString = emailTextField.text!
        
        if (newEmailString != "") {
            confirmEmailTextField.userInteractionEnabled = true
        }
    }
    
    func validateNewEmail(newEmailString: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        newEmailIsValid = emailPredicate.evaluateWithObject(newEmailString)
        return newEmailIsValid
    }
    
    @IBAction func confirmEmailTextFieldEditingDidChange(sender: AnyObject) {
        confirmedEmailString = confirmEmailTextField.text!
        
        if (confirmedEmailString != "") {
            phoneTextField.userInteractionEnabled = true
        } else {
            phoneTextField.userInteractionEnabled = false
        }
    }
    
    func validateConfirmedEmail(confirmedEmailString: String) -> Bool {
        if (confirmedEmailString == newEmailString) {
            confirmedEmailIsValid = true
        }
        return confirmedEmailIsValid
    }
    
    @IBAction func phoneTextFieldEditingDidChange(sender: AnyObject) {
        phoneString = phoneTextField.text!
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
                    self.navigationItem.rightBarButtonItem?.enabled = true
                    confirmEmailTextField.becomeFirstResponder()
                } else {
                    let alertController = UIAlertController(title: "Not a valid email.", message:  "\n The email that you entered is not valid. Enter a valid email before continuing. ", preferredStyle: .Alert)
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                    let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                        self.emailTextField.becomeFirstResponder()
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
            confirmEmailTextField.becomeFirstResponder()
        case 2:
            phoneTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = phoneTextField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        if (newLength <= 9) {
            phoneIsValid = false
        } else {
            phoneIsValid = true
        }
        return newLength <= 15
    }
    
    func advanceToNextSignUpStep() {
        validateConfirmedEmail(confirmedEmailString)
        
        if (confirmedEmailIsValid == true && phoneIsValid == true) {
            performSegueWithIdentifier("toProfilePictureSignUpSegue", sender: self)
        } else if (confirmedEmailIsValid == true && phoneIsValid == false) {
            let alertController = UIAlertController(title: "Not a valid phone number.", message:  "\n Please enter a valid phone number in order to continue. Phone numbers should be enter without any characters other than numbers.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.phoneTextField.text! = ""
                self.phoneTextField.becomeFirstResponder()
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        } else if (confirmedEmailIsValid == false && phoneIsValid == true) {
            let alertController = UIAlertController(title: "Emails don't match.", message:  "\n Your emails must match in order to continue.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.confirmEmailTextField.text! = ""
                self.confirmEmailTextField.becomeFirstResponder()
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
            

        }
    }
}
