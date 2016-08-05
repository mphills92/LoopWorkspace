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
    
    var newPhoneIsValid = Bool()
    
    let userPhone = UserPhone()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPhoneTextField.delegate = self
        newPhoneTextField.delegate = self
        newPhoneTextField.becomeFirstResponder()
        
        navigationItem.title = "Change Phone"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        currentPhoneTextField.text = userPhone.phoneNumber
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: ("saveChanges"))
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.enabled = false
    }
}

extension ChangePhoneViewController {

    func saveChanges() {
        if (newPhoneIsValid == true) {
            self.newPhoneTextField.resignFirstResponder()
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
            let alertController = UIAlertController(title: "Not a valid phone number.", message:  "\n Please enter a valid phone number to save account changes. Phone numbers should be enter without any characters other than numbers.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }

        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = newPhoneTextField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        if (newLength <= 9) {
            newPhoneIsValid = false
            self.navigationItem.rightBarButtonItem?.enabled = false
        } else {
            newPhoneIsValid = true
            self.navigationItem.rightBarButtonItem?.enabled = true
        }
        return newLength <= 10
    }
}