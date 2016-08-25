//
//  EditProfileViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/16/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    var firstNameAtLoad = String()
    var lastNameAtLoad = String()
    
    var firstNameString = String()
    var lastNameString = String()
    
    var aTextFieldHasChangedValueSinceLoad = Bool()
    var userIsNavigatingBack = Bool()
    
    let userName = UserName()
    let userPhone = UserPhone()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        navigationItem.title = "Edit Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-32, 0, 0, 0)
        
        userProfileImageView.layer.cornerRadius = 50
        
        userInformationToLoad()
        
        firstNameTextField.tag = 1
        lastNameTextField.tag = 2
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: ("saveChanges"))
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.enabled = false

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        userIsNavigatingBack = true
    }
}

extension EditProfileViewController {
    
    func userInformationToLoad() {
        firstNameTextField.text = userName.firstName
        firstNameAtLoad = userName.firstName
        lastNameTextField.text = userName.lastName
        lastNameAtLoad = userName.lastName
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }

    func saveChanges() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        
        if (firstNameString != firstNameAtLoad) {
            firstNameAtLoad = firstNameString
        }
        
        if (lastNameString != lastNameAtLoad) {
            lastNameAtLoad = lastNameString
        }
        
        let alertController = UIAlertController(title: "Your account changes have been saved.", message:  "", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
        }
        alertController.addAction(doneAction)
        
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    @IBAction func firstNameTextFieldEditingDidChange(sender: AnyObject) {
        firstNameString = firstNameTextField.text!
    }
    
    @IBAction func lastNameTextFieldEditingDidChange(sender: AnyObject) {
        lastNameString = lastNameTextField.text!
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        navigationItem.rightBarButtonItem?.enabled = false
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if ((firstNameString != firstNameAtLoad) || (lastNameString != lastNameAtLoad)) {
            navigationItem.rightBarButtonItem?.enabled = true
        } else {
            navigationItem.rightBarButtonItem?.enabled = false
        }
        
        switch (textField.tag) {
        case 1:
            firstNameTextField.resignFirstResponder()
        case 2:
            lastNameTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            firstNameTextField.resignFirstResponder()
        case 2:
            lastNameTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    /*
    func saveChanges() {
        if (firstNameTextField.text != "" && lastNameTextField.text != "") {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.resignFirstResponder()
            
            let alertController = UIAlertController(title: "Your account changes have been saved.", message:  "", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
            
        } else {
            let alertController = UIAlertController(title: "Missing first or last name.", message:  "\n Please enter a first and last name to save changes to your account.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            userName.firstName = firstNameTextField.text!
            firstNameTextField.resignFirstResponder()
        case 2:
            userName.lastName = lastNameTextField.text!
            lastNameTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }*/
    

}