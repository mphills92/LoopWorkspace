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
    @IBOutlet weak var continueButton: UIButton!
    
    var firstNameToSave = String()
    var lastNameToSave = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        navigationItem.title = "Who Are You?"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        continueButtonDisabledState()
        
        firstNameTextField.becomeFirstResponder()
        
        firstNameTextField.tag = 1
        lastNameTextField.tag = 2
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension SignUpNameInfoViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        continueButtonDisabledState()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            firstNameToSave = firstNameTextField.text!
            lastNameTextField.becomeFirstResponder()
        case 2:
            lastNameToSave = lastNameTextField.text!
            continueButtonEnabledState()
            lastNameTextField.resignFirstResponder()
        default:
            break
        }
        textField.resignFirstResponder()
        return true
    }
    
    func continueButtonEnabledState() {
        self.continueButton.enabled = true
        self.continueButton.setTitleColor(UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0), forState: .Normal)
    }
    
    func continueButtonDisabledState() {
        self.continueButton.enabled = false
        self.continueButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }
}
