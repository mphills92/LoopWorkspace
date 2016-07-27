//
//  LateCaddieViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/26/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class LateCaddieViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var closeTextFieldButton: UIButton!
    @IBOutlet weak var extraInfoTextField: UITextField!
    
    @IBOutlet weak var thirdParagraphToTopReferenceConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraintInfoTextFieldBackground: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintInfoTextFieldBackground: NSLayoutConstraint!
    
    var screenSize = UIScreen.mainScreen().bounds
    var bottomConstraintTextFieldDistanceMoved = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extraInfoTextField.delegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        extraInfoTextField.layer.cornerRadius = 8
        closeTextFieldButton.hidden = true
        
        submitButton.layer.cornerRadius = 20
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
}

extension LateCaddieViewController {
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func closeTextFieldButtonPressed(sender: AnyObject) {
        extraInfoTextField.resignFirstResponder()
    }
    
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
// TODO: Send complaint information to Loop.
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo! as NSDictionary).objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size.height else {
            return
        }
        closeTextFieldButton.hidden = false
        topConstraintInfoTextFieldBackground.constant -= 270
        bottomConstraintTextFieldDistanceMoved = ((screenSize.height - keyboardHeight) - (screenSize.height - 80))
        bottomConstraintInfoTextFieldBackground.constant -= bottomConstraintTextFieldDistanceMoved
        
        view.layoutIfNeeded()
    }
    
    func keyboardWillHide(notification: NSNotification) {
        closeTextFieldButton.hidden = true
        topConstraintInfoTextFieldBackground.constant += 270
        bottomConstraintInfoTextFieldBackground.constant += bottomConstraintTextFieldDistanceMoved
        view.layoutIfNeeded()
    }
    
}