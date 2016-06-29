//
//  LoginViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/25/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButtonCenterConstraint: NSLayoutConstraint!
    
    var screenSize = UIScreen.mainScreen().bounds
    
    var emailToValidate = String()
    var emailFieldHasEditedPrior = Bool()
    var passwordToValidate = String()

    
    let userEmail = UserEmail()
    let userPassword = UserPassword()
    let emailAuthentication = EmailAuthentication()
    let passwordAuthentication = PasswordAuthentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        backgroundView.layer.cornerRadius = 8
        loginButton.layer.cornerRadius = loginButton.bounds.height / 2
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        imageViewBackground.image = UIImage(named: "LandingPageBackground")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
        
        self.loginButtonCenterConstraint.constant = screenSize.width
        
        emailFieldHasEditedPrior = false
        
        emailTextField.tag = 1
        passwordTextField.tag = 2
    }
}

extension LoginViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch (textField.tag) {
        case 1:
            if (emailFieldHasEditedPrior == false) {
                loginButtonOutOfView()
                emailFieldHasEditedPrior = true
            } else {
                loginButtonOutOfView()
            }
        case 2:
            emailTextField.resignFirstResponder()
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch (textField.tag) {
        case 1:
            emailToValidate = emailTextField.text!
            passwordTextField.becomeFirstResponder()
            emailFieldHasEditedPrior = true
            loginButtonInView()
        case 2:
            passwordToValidate = passwordTextField.text!
            passwordTextField.resignFirstResponder()
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 1:
            passwordTextField.becomeFirstResponder()
        case 2:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        textField.resignFirstResponder()
        return true
    }
    
    // Evaluate credentials upon pressing Login button.
    @IBAction func loginButtonPressed(sender: AnyObject) {
    
        validatedEmail()
        validatedPassword()
        
        passwordTextField.resignFirstResponder()
        
        if (emailTextField.text! == "" || passwordTextField.text! == "") {
            let alertController = UIAlertController(title: "You forgot to enter either an email or password.", message:  "\n Please enter your full email and password before attempting to login.", preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.passwordTextField.becomeFirstResponder()
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
            
        } else if (validatedEmail() == false || validatedPassword() == false) {
            let alertController = UIAlertController(title: "Trouble logging you in.", message:  "\n We can't find an account with the email and password combination that you entered. Please try again.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            let forgotPasswordAction = UIAlertAction(title: "Forgot your password?", style: .Default) { (action) in
                self.performSegueWithIdentifier("toForgotPasswordSegue", sender: self)
            }
            alertController.addAction(forgotPasswordAction)
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.passwordTextField.becomeFirstResponder()
            }
            alertController.addAction(doneAction)
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        } else {
            performSegueWithIdentifier("loginSuccessfulSegue", sender: self)
        }
        
    }
    
    // Login button slides into view from right to left.
    func loginButtonInView() {
        self.loginButtonCenterConstraint.constant = self.screenSize.width
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.loginButtonCenterConstraint.constant -= self.screenSize.width
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    // Login button slides out of view from left to right.
    func loginButtonOutOfView() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.loginButtonCenterConstraint.constant = self.screenSize.width
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func validatedEmail() -> Bool {
        if (emailAuthentication.emailExistsInDatabase == true) {
            return true
        } else {
            return false
        }
    }
    
    func validatedPassword() -> Bool {
        if (passwordAuthentication.passwordExistsInDatabase  == true && passwordAuthentication.passwordMatchesEmailAccount == true) {
            return true
        } else {
            return false
        }
    }
}
