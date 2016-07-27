//
//  ContainerGolferRoundInProgressViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/20/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import MessageUI

class ContainerGolferRoundInProgressViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var caddieProfileImageView: UIImageView!
    @IBOutlet weak var textCaddieCell: UITableViewCell!
    @IBOutlet weak var callCaddieCell: UITableViewCell!
    @IBOutlet weak var lateCaddieCell: UITableViewCell!
    @IBOutlet weak var caddieProfessionalComplaintCell: UITableViewCell!
    @IBOutlet weak var loopContactRequestCell: UITableViewCell!
    
    
    var userName = UserName()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(-33, 0, -38, 0)
        
        caddieProfileImageView.layer.cornerRadius = 8
        
    }
}

extension ContainerGolferRoundInProgressViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (cellClicked == textCaddieCell) {
            let textAlertController = UIAlertController(title: "Sorry, something's wrong.", message: "It looks like you can't send a text message right now. Please try again later.", preferredStyle: .Alert)
            textAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            if (MFMessageComposeViewController.canSendText()) {
                let controller = MFMessageComposeViewController()
                controller.body = "Hi, this is \(userName.firstName) " + "\(userName.lastName) and I've recently checked in for my Loop reservation with you."
                controller.recipients = ["caddiePhoneNumber"]
                
// TODO: Set caddie phone information as recipient.
                
                controller.messageComposeDelegate = self
                self.presentViewController(controller, animated: true, completion: {})
            } else {
                let closeAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
                textAlertController.addAction(closeAction)
                
                presentViewController(textAlertController, animated: true) {
                    textAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }
            }
        } else if (cellClicked == callCaddieCell) {
            print("call caddie initiated")
// TODO: Launch phone call to caddie phone number.
        } else if (cellClicked == lateCaddieCell) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let lateCaddieViewController = storyboard.instantiateViewControllerWithIdentifier("LateCaddieNavigationController") as! UIViewController
            self.presentViewController(lateCaddieViewController, animated: true, completion: nil)
        } else if (cellClicked == caddieProfessionalComplaintCell) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let caddieComplaintViewController = storyboard.instantiateViewControllerWithIdentifier("CaddieComplaintNavigationController") as! UIViewController
            self.presentViewController(caddieComplaintViewController, animated: true, completion: nil)
        } else if (cellClicked == loopContactRequestCell) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loopContactRequestViewController = storyboard.instantiateViewControllerWithIdentifier("LoopContactRequestNavigationController") as! UIViewController
            self.presentViewController(loopContactRequestViewController, animated: true, completion: nil)
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