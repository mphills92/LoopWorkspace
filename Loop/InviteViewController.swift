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

class InviteViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
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
        
        viaTextButton.layer.cornerRadius = 20 //viaTextButton.bounds.height / 2
        viaEmailButton.layer.cornerRadius = 20 //viaEmailButton.bounds.height / 2
        viaFacebookButton.layer.cornerRadius = 20 //viaFacebookButton.bounds.height / 2
        viaTwitterButton.layer.cornerRadius = 20 //viaTwitterButton.bounds.height / 2
    }
}

extension InviteViewController {
    
    @IBAction func sendSMSTextMessage(sender: AnyObject) {
        let textAlertController = UIAlertController(title: "Sorry, something's wrong.", message: "It looks like you can't send a text message right now. Please try again later.", preferredStyle: .Alert)
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
    
    @IBAction func sendEmail(sender: AnyObject) {
        let emailAlertController = UIAlertController(title: "Sorry, something's wrong.", message: "We cannot find an email account for us to send your invitation. Please make sure your email settings are correct or try again later.", preferredStyle: .Alert)
        emailAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        if (MFMailComposeViewController.canSendMail()) {
            let controller = MFMailComposeViewController()
            controller.setSubject("Join Loop: my invitation to you!")
            controller.setMessageBody("Start golfing with Loop to see how great having a caddie can be. Use my referral code \(userReferralCode.referralCode) to receive $10 credit toward your first round of golf. Because every golfer deserves a caddie.", isHTML: true)
            controller.mailComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: {})
        } else {
            let closeAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
            emailAlertController.addAction(closeAction)
            
            presentViewController(emailAlertController, animated: true) {
                emailAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func sendFacebook(sender: AnyObject) {
        let facebookAlertController = UIAlertController(title: "Are you logged into Facebook?", message: "Please make sure you're logged into your Facebook account to share your code with friends.", preferredStyle: .Alert)
        facebookAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbShare.setInitialText("Start golfing with Loop to see how great having a caddie can be. Use my referral code \(userReferralCode.referralCode) to receive $10 credit toward your first round of golf. Because every golfer deserves a caddie.")
            self.presentViewController(fbShare, animated: true, completion: nil)
        } else {
            let closeAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            }
            facebookAlertController.addAction(closeAction)
            
            presentViewController(facebookAlertController, animated: true) {
                facebookAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
            
        }    }
    
    @IBAction func sendTwitter(sender: AnyObject) {
        let twitterAlertController = UIAlertController(title: "Are you signed into Twitter?", message: "Please make sure you're signed into your Twitter account to tweet your code for your followers.", preferredStyle: .Alert)
        twitterAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetShare.setInitialText("Start golfing with Loop to see how great having a caddie can be. Use referral code \(userReferralCode.referralCode) to get $10 credit for your first round of golf.")
            self.presentViewController(tweetShare, animated: true, completion: nil)
        } else {
            let closeAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            }
            twitterAlertController.addAction(closeAction)
            
            presentViewController(twitterAlertController, animated: true) {
                twitterAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        }
    }
    
}
