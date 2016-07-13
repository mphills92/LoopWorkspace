//
//  InviteViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/9/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import MessageUI
import Social

class InviteViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var referralCodeLabel: UILabel!
    @IBOutlet weak var viaTextButton: UIButton!
    @IBOutlet weak var viaEmailButton: UIButton!
    @IBOutlet weak var viaFacebookButton: UIButton!
    @IBOutlet weak var viaTwitterButton: UIButton!
    
    var userReferralCode = UserReferralCode()
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        
        referralCodeLabel.text = "\(userReferralCode.referralCode)"
        
        viaTextButton.layer.cornerRadius = viaTextButton.bounds.height / 2
        viaEmailButton.layer.cornerRadius = viaEmailButton.bounds.height / 2
        viaFacebookButton.layer.cornerRadius = viaFacebookButton.bounds.height / 2
        viaTwitterButton.layer.cornerRadius = viaTwitterButton.bounds.height / 2
    }
}

extension InviteViewController {
    
    @IBAction func sendSMSTextMessage(sender: AnyObject) {
        let textAlertController = UIAlertController(title: "Sorry, something's wrong.", message: "Our system detects that you can't send a text message right now. Please try again later.", preferredStyle: .Alert)
        textAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Start golfing with Loop to see how great having a caddie can be. Use my referral code \(userReferralCode.referralCode) to receive $10 credit toward your first round of golf. Because every golfer deserves a caddie."
            //controller.recipients = [""]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: {})
        } else {
            let closeAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
            textAlertController.addAction(closeAction)
            
            presentViewController(textAlertController, animated: true) {
                textAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            self.dismissViewControllerAnimated(true, completion: {})
        case MessageComposeResultFailed.rawValue:
            self.dismissViewControllerAnimated(true, completion: {})
        case MessageComposeResultSent.rawValue:
            self.dismissViewControllerAnimated(true, completion: {})
        default:
            break
        }
    }
}
