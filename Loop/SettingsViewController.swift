//
//  SettingsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/9/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var sendFeedbackCell: UITableViewCell!
    @IBOutlet weak var signOutCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension SettingsViewController {
    
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    /*
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }*/
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 3) {
            return 65
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if cellClicked == sendFeedbackCell {
            let emailAlertController = UIAlertController(title: "Sorry, something's wrong.", message: "We cannot find an email account for us to send your invitation. Please make sure your email settings are correct or try again later.", preferredStyle: .Alert)
            emailAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            if (MFMailComposeViewController.canSendMail()) {
                let controller = MFMailComposeViewController()
                controller.setSubject("Feedback for Loop")
                controller.setToRecipients(["feedback@loopgolf.com"])
                controller.setMessageBody("", isHTML: true)
                controller.mailComposeDelegate = self
                self.presentViewController(controller, animated: true, completion: {})
            } else {
                let closeAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                emailAlertController.addAction(closeAction)
                
                presentViewController(emailAlertController, animated: true) {
                    emailAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }
            }
        } else if cellClicked == signOutCell {
            
            let actionSheetController = UIAlertController(title: "Are you sure you want to sign out?", message: "", preferredStyle: .ActionSheet)
            actionSheetController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let signOutAction = UIAlertAction(title: "Sign Out", style: .Destructive) { (action) in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! UIViewController
                    self.presentViewController(loginViewController, animated: true, completion: nil)
                    print("TO DO: Sign out user from Loop and release credentials to require new login.")
// TO DO: Sign out user from Loop and release credentials. Pop view back to login page.
            }
            actionSheetController.addAction(signOutAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            }
            actionSheetController.addAction(cancelAction)
            
            presentViewController(actionSheetController, animated: true) {
                actionSheetController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }

            
            
            
            
            
            

        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
}
