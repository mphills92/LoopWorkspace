//
//  LoginViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/25/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBackgroundViewCenterYConstraint: NSLayoutConstraint!

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelButtonCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButtonCenterConstraint: NSLayoutConstraint!
    
    
    var screenSize = UIScreen.mainScreen().bounds
    
    var userWantsToCancel = Bool()
    var userHasStartedLoginProcess = Bool()
    var emailToValidate = String()
    var emailFieldHasEditedPrior = Bool()
    var passwordToValidate = String()
    
    var logoImageViewTransformHeight = CGFloat()
    
    let userEmail = UserEmail()
    let userPassword = UserPassword()
    let emailAuthentication = EmailAuthentication()
    let passwordAuthentication = PasswordAuthentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        backgroundView.layer.cornerRadius = 8
        
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor
        signUpButton.layer.borderColor = UIColor.whiteColor().CGColor
        signUpButton.layer.borderWidth = 1
        
        cancelButton.layer.cornerRadius = 15
        cancelButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor
        cancelButton.layer.borderColor = UIColor.whiteColor().CGColor
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.shadowColor = UIColor.blackColor().CGColor
        cancelButton.layer.shadowOpacity = 0.5
        cancelButton.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        loginButton.layer.cornerRadius = 20
        loginButton.layer.shadowColor = UIColor.blackColor().CGColor
        loginButton.layer.shadowOpacity = 0.5
        loginButton.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        imageViewBackground.image = UIImage(named: "LandingPageBackground")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSForegroundColorAttributeName: UIColor.blackColor()])
        
        //self.loginButtonCenterConstraint.constant = screenSize.width
        //self.cancelButtonCenterConstraint.constant = screenSize.width
        self.loginButton.alpha = 0
        self.cancelButton.alpha = 0
        
        userHasStartedLoginProcess = false
        
        emailFieldHasEditedPrior = false
        
        emailTextField.tag = 1
        passwordTextField.tag = 2
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension LoginViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        cancelButtonEnters()
        loginButtonEnters()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch (textField.tag) {
        case 1:
            if (userWantsToCancel == true) {
                emailTextField.resignFirstResponder()
                userHasStartedLoginProcess = false
                cancelButtonExits()
                loginButtonExits()
                
            } else {
                emailToValidate = emailTextField.text!
                passwordTextField.becomeFirstResponder()
                userHasStartedLoginProcess = true
                emailFieldHasEditedPrior = true
                userWantsToCancel = false
            }
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
        
        //rotateLayerInfinite(logoImageView.layer)
        
        if (emailTextField.text! == "" || passwordTextField.text! == "") {
            let alertController = UIAlertController(title: "You forgot to enter either an email or password.", message:  "\n Please enter your full email and password before attempting to login.", preferredStyle: .Alert)
            
            
                self.emailTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
                self.clearTextFields()
                self.cancelButtonExits()
                self.loginButtonExits()
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.userHasStartedLoginProcess = false
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
            
                self.emailTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
                self.clearTextFields()
                self.cancelButtonExits()
                self.loginButtonExits()
            
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                self.userHasStartedLoginProcess = false
            }
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        } else {
            performSegueWithIdentifier("loginSuccessfulSegue", sender: self)
        }
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        userWantsToCancel = true
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        userHasStartedLoginProcess = false
        clearTextFields()
        cancelButtonExits()
        loginButtonExits()
        
    }
    
    @IBAction func forgotPasswordButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("toForgotPasswordSegue", sender: self)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo! as NSDictionary).objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size.height else {
            return
        }
        
        if (userHasStartedLoginProcess == false) {
            loginBackgroundViewCenterYConstraint.constant -= ((screenSize.height - keyboardHeight) / 4)
            logoImageViewTransformHeight = ((((screenSize.height - keyboardHeight) / 4) - 50) / 100) * 1.25
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.logoImageView.transform = CGAffineTransformMakeScale(self.logoImageViewTransformHeight, self.logoImageViewTransformHeight)
            self.mainTitle.alpha = 0
            self.view.layoutIfNeeded()
            }, completion: nil)
        
            view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        loginBackgroundViewCenterYConstraint.constant = 0
        UIView.animateWithDuration(0.5, delay: 0.16, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.logoImageView.transform = CGAffineTransformMakeScale(1, 1)
            self.mainTitle.alpha = 1.0
            self.view.layoutIfNeeded()
            }, completion: nil)
        view.layoutIfNeeded()
    }
    
    
    // Cancel button slides into view from right to left.
    func cancelButtonEnters() {
        userWantsToCancel = false
        //self.cancelButtonCenterConstraint.constant = self.screenSize.width
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.cancelButton.alpha = 1.0
            //self.cancelButtonCenterConstraint.constant -= self.screenSize.width
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    // Cancel button slides out of view from left to right.
    func cancelButtonExits() {
        userWantsToCancel = false
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.cancelButton.alpha = 0
            //self.cancelButtonCenterConstraint.constant = self.screenSize.width
            self.view.layoutIfNeeded()
            }, completion: nil)
    }

    // Login button slides into view from right to left.
    func loginButtonEnters() {
        //self.loginButtonCenterConstraint.constant = self.screenSize.width
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.loginButton.alpha = 1.0
            //self.loginButtonCenterConstraint.constant -= self.screenSize.width
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    // Login button slides out of view from left to right.
    func loginButtonExits() {
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.loginButton.alpha = 0
            //self.loginButtonCenterConstraint.constant = self.screenSize.width
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
    
    func clearTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func rotateLayerInfinite(layer: CALayer) {
        var rotation: CABasicAnimation
        rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = Int(0)
        rotation.toValue = Int((2 * M_PI))
        rotation.duration = 1.0
        rotation.repeatCount = HUGE
        layer.removeAllAnimations()
        layer.addAnimation(rotation, forKey: "Spin")
        
    }
}
