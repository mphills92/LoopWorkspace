//
//  LateCaddieViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/26/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class LateCaddieViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var closeTextFieldButton: UIButton!
    @IBOutlet weak var infoTextView: UITextView!
    
    @IBOutlet weak var topConstraintInfoTextFieldBackground: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintInfoTextFieldBackground: NSLayoutConstraint!
    
    var screenSize = UIScreen.mainScreen().bounds
    var bottomConstraintTextFieldDistanceMoved = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTextView.delegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        infoTextView.layer.cornerRadius = 8
        infoTextView.text = "Please enter any additional details here."
        infoTextView.textColor = UIColor.lightGrayColor()
        closeTextFieldButton.hidden = true
        
        submitButton.layer.cornerRadius = 20
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboardNotification(_:)),
                                                         name: UIKeyboardWillChangeFrameNotification,
                                                         object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        infoTextView.resignFirstResponder()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension LateCaddieViewController {
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func closeTextFieldButtonPressed(sender: AnyObject) {
        infoTextView.resignFirstResponder()
    }
    
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
// TODO: Send complaint information to Loop.
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor = UIColor.darkGrayColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (textView.text.isEmpty) {
            textView.text = "Please enter any additional details here."
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrame?.origin.y >= UIScreen.mainScreen().bounds.size.height {
                self.topConstraintInfoTextFieldBackground.constant = 285
                self.bottomConstraintTextFieldDistanceMoved = 80
                self.bottomConstraintInfoTextFieldBackground.constant = bottomConstraintTextFieldDistanceMoved
                closeTextFieldButton.hidden = true
            } else {
                self.topConstraintInfoTextFieldBackground.constant = 0
                self.bottomConstraintInfoTextFieldBackground.constant = (endFrame?.size.height)!
                closeTextFieldButton.hidden = false
            }
            UIView.animateWithDuration(duration,
                                       delay: NSTimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
    
    
}