//
//  ChangePhoneViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/19/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChangePhoneViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var currentPhoneTextField: UITextField!
    @IBOutlet weak var newPhoneTextField: UITextField!
    @IBOutlet weak var saveChangesButton: UIButton!
    
    let userPhone = UserPhone()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPhoneTextField.delegate = self
        newPhoneTextField.delegate = self
        
        navigationItem.title = "Change Phone"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        saveChangesButtonDisabledState()
        
        currentPhoneTextField.text = userPhone.phoneNumber
    }
}

extension ChangePhoneViewController {

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = newPhoneTextField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        if (newLength <= 9) {
            saveChangesButtonDisabledState()
        } else {
            saveChangesButtonEnabledState()
        }
        return newLength <= 10
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
        navigationController?.popViewControllerAnimated(true)
    }
}