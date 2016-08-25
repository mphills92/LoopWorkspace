//
//  SignUpNameInfoViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/26/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class SignUpNameInfoViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    var firstNameToSave = String()
    var lastNameToSave = String()
    
    var firstNameHasBeenEntered = Bool()
    var lastNameHasBeenEntered = Bool()
    var allTextFieldsArePopulated = false
    
    // Pass data via segue.
    var firstNameToSend1 = String()
    var lastNameToSend1 = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        firstNameTextField.becomeFirstResponder()

        navigationItem.title = "Who Are You?"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "advanceToNextSignUpStep")
        nextButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = nextButton
        
        firstNameTextField.tag = 1
        lastNameTextField.tag = 2
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension SignUpNameInfoViewController {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            lastNameTextField.becomeFirstResponder()
        case 2:
            advanceToNextSignUpStep()
        default:
            break
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            firstNameToSave = ""
        case 2:
            lastNameToSave = ""
        default:
            break
        }
        return true
    }
    
    @IBAction func firstNameTextFieldEditingDidChange(sender: AnyObject) {
        firstNameToSave = firstNameTextField.text!
    }
    
    @IBAction func lastNameTextFieldEditingDidChange(sender: AnyObject) {
        lastNameToSave = lastNameTextField.text!
        
    }
    
    func validateFirstName(firstNameToSave: String) -> Bool {
        if (firstNameToSave != "") {
            firstNameHasBeenEntered = true
        } else {
            firstNameHasBeenEntered = false
        }
        return firstNameHasBeenEntered
    }
    
    func validateLastName(lastNameToSave: String) -> Bool {
        if (lastNameToSave != "") {
            lastNameHasBeenEntered = true
        } else {
            lastNameHasBeenEntered = false
        }
        return lastNameHasBeenEntered
    }
    
    func advanceToNextSignUpStep() {
        validateFirstName(firstNameToSave)
        validateLastName(lastNameToSave)
        
        if (firstNameHasBeenEntered == true && lastNameHasBeenEntered == true) {
            
            firstNameToSend1 = firstNameTextField.text!
            lastNameToSend1 = lastNameTextField.text!
            
            performSegueWithIdentifier("toEmailSignUpSegue", sender: self)
        } else {
            let alertController = UIAlertController(title: "You must include both first and last name in order to continue.", message:  "", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toEmailSignUpSegue") {
            let destinationVC = segue.destinationViewController as! SignUpContactInfoViewController
            
            destinationVC.firstNameHasBeenSent1 = firstNameToSend1
            destinationVC.lastNameHasBeenSent1 = lastNameToSend1
        }

    }
}
