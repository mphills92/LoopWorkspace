//
//  SignUpPasswordViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/27/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpPasswordViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createAccountTableViewCell: UITableViewCell!
    
    // Variables used to populate database upon user sign up.
    var firstName = String()
    var lastName = String()
    var newEmail = String()
    var newPhone = String()
    var newPassword = String()
    var membershipHistory: String = "January 2017"
    var lifetimeRounds: Int = 0
    var credit: Int = 0
    
    //var privateCourse = String()
    
    // Receive data from segue.
    var firstNameHasBeenSent3: String?
    var lastNameHasBeenSent3: String?
    var emailHasBeenSent2: String?
    var phoneHasBeenSent2: String?
    //var privateCourseHasBeenSent1: String?
    
    var newPasswordString = String()
    
    var confirmedPasswordString = String()
    var confirmedPasswordIsValid = false
    
    var userIsNavigatingBack = Bool()
    
    var screenSize = UIScreen.mainScreen().bounds
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let activityIndicatorBackground = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.becomeFirstResponder()
        
        navigationItem.title = "Create Password"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        activityIndicator.center = self.view.center
        activityIndicatorBackground.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.25)
        activityIndicatorBackground.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height)
        activityIndicatorBackground.hidden = true
        
        passwordTextField.tag = 1
        confirmPasswordTextField.tag = 2
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        firstName = firstNameHasBeenSent3!
        lastName = lastNameHasBeenSent3!
        newEmail = emailHasBeenSent2!
        newPhone = phoneHasBeenSent2!
        //privateCourse = privateCourseHasBeenSent1!
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
            newPassword = confirmedPasswordString
            createAccount(confirmedPasswordIsValid)
        } else {
            confirmedPasswordIsValid = false
            createAccount(confirmedPasswordIsValid)
        }

    }
    
    // Firebase sign up authentication takes place in this method.
    func createAccount(confirmedPasswordInValid: Bool) {
        // Reference the Firebase database in order to create a new user.
        let dbRef = FIRDatabase.database().reference()
        
        if (confirmedPasswordIsValid == true) {
            self.view!.addSubview(activityIndicatorBackground)
            self.view!.addSubview(activityIndicator)
            
            startActivityIndicator()
            
            FIRAuth.auth()?.createUserWithEmail(newEmail, password: newPassword, completion: { (user, error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    // Set up new user in Firebase database.
                    dbRef.child("users").child(user!.uid).setValue(["first_name": self.firstName, "last_name" : self.lastName, "email" : self.newEmail, "credit" : self.credit, "lifetime_rounds" : self.lifetimeRounds, "membership_history" : self.membershipHistory])
                    
                    self.stopActivityIndicator()
                    
                    // Alert the user that sign up has been completed successfully.
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
            })
            
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
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicatorBackground.hidden = false
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicatorBackground.hidden = true
    }
}