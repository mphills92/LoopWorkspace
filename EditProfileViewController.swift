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
    
    let userName = UserName()
    let userPhone = UserPhone()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        navigationItem.title = "Edit Account"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        userProfileImageView.layer.cornerRadius = 8
        
        userInformationToLoad()
        
        firstNameTextField.tag = 1
        lastNameTextField.tag = 2

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension EditProfileViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
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
    }
    
    func userInformationToLoad() {
        firstNameTextField.text = userName.firstName
        lastNameTextField.text = userName.lastName
    }
}