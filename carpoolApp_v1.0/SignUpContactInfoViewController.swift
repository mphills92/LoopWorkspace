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
    @IBOutlet weak var continueButton: UIButton!
    
    var emailToValidate = String()
    var newEmailIsValid = Bool()
    var emailToSave = String()
    var confirmedEmailToValidateMatch = String()
    var phoneNumberToSave = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        confirmEmailTextField.delegate = self
        phoneTextField.delegate = self
        
        self.tableView.contentInset = UIEdgeInsetsMake(-22, 0, -22, 0)
        
        navigationItem.title = "Contact Information"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"HelveticaNeue-Light", size: 20)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        continueButtonDisabledState()
        
        emailTextField.becomeFirstResponder()
        
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        continueButtonDisabledState()
        
        switch (textField.tag) {
        case 1:
            emailTextField.userInteractionEnabled = true
            confirmEmailTextField.userInteractionEnabled = false
            phoneTextField.userInteractionEnabled = false
        case 2:
            confirmEmailTextField.userInteractionEnabled = true
            phoneTextField.userInteractionEnabled = false
        case 3:
            phoneTextField.userInteractionEnabled = true
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            emailToValidate = emailTextField.text!
            validateEmail(emailToValidate)
            // TO DO: Verify that email doesn't already exist for an account in DB. Alert user if it does exist.
            print("TO DO: Verify that email doesn't already exist for an account in DB. Alert user if it does exist.")
            
            if (newEmailIsValid == true) {
                emailToSave = emailToValidate
                confirmEmailTextField.userInteractionEnabled = true
                confirmEmailTextField.becomeFirstResponder()
            } else {
                let alertController = UIAlertController(title: "Not a valid email.", message:  "\n Please enter a valid email.", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                alertController.addAction(doneAction)
                
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }
            }
        case 2:
            confirmedEmailToValidateMatch = confirmEmailTextField.text!
            if (confirmedEmailToValidateMatch == emailToSave) {
                phoneTextField.userInteractionEnabled = true
                phoneTextField.becomeFirstResponder()
            } else {
                let alertController = UIAlertController(title: "Oops, emails don't match.", message:  "\n Your confirmed email must match the one you entered above.", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                alertController.addAction(doneAction)
                
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }
            }
        case 3:
            continueButtonEnabledState()
            phoneTextField.resignFirstResponder()
        default:
            break
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = phoneTextField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        if (newLength <= 9) {
            continueButtonDisabledState()
        } else {
            continueButtonEnabledState()
        }
        return newLength <= 10
    }
    
    func continueButtonEnabledState() {
        self.continueButton.enabled = true
        self.continueButton.setTitleColor(UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0), forState: .Normal)
    }
    
    func continueButtonDisabledState() {
        self.continueButton.enabled = false
        self.continueButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }
    
    func validateEmail(emailToValidate: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        newEmailIsValid = emailPredicate.evaluateWithObject(emailToValidate)
        return newEmailIsValid
    }
    
}
