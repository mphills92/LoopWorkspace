//
//  RequestDetailsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/19/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class RequestDetailsViewController: UITableViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var caddieProfileImageView: UIImageView!
    @IBOutlet weak var caddieNameLabel: UILabel!
    @IBOutlet weak var caddieMembershipHistoryLabel: UILabel!
    @IBOutlet weak var golfCourseNameLabel: UILabel!
    @IBOutlet weak var golfCourseLocationLabel: UILabel!
    @IBOutlet weak var resDateLabel: UILabel!
    @IBOutlet weak var resTimeLabel: UILabel!
    @IBOutlet weak var resIDNumberLabel: UILabel!
    
    @IBOutlet weak var checkInCell: UITableViewCell!
    @IBOutlet weak var cancelReservationCell: UITableViewCell!
    
    private var dbRef : FIRDatabaseReference!
    private var resIDLocationRef : FIRDatabaseReference!
    
    var userName = UserName()
    var nextReservation = NextReservation()
    
    // Receive data via segue.
    var resIDHasBeenSent: String?
    var caddieNameHasBeenSent: String?
    var caddieMemHistHasBeenSent: String?
    var courseNameHasBeenSent: String?
    var courseLocationHasBeenSent: String?
    var dateHasBeenSent: String?
    var timeHasBeenSent: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Caddie Request"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        caddieProfileImageView.layer.cornerRadius = 50
        caddieNameLabel.text = caddieNameHasBeenSent
        
        self.dbRef = FIRDatabase.database().reference()
        if (resIDHasBeenSent != nil) {
            self.resIDLocationRef = dbRef.child("requests_reservations").child("\(resIDHasBeenSent!)")
        }
        
        if (caddieMemHistHasBeenSent != "") {
            caddieMembershipHistoryLabel.text = "Member since \(caddieMemHistHasBeenSent!)"
        }
        
        golfCourseNameLabel.text = courseNameHasBeenSent
        
        if (courseLocationHasBeenSent != "") {
            golfCourseLocationLabel.text = courseLocationHasBeenSent!
        }
        
        resDateLabel.text = dateHasBeenSent
        resTimeLabel.text = timeHasBeenSent
        
        if (resIDHasBeenSent != "") {
            resIDNumberLabel.text = resIDHasBeenSent!.substringFromIndex(resIDHasBeenSent!.endIndex.advancedBy(-8))
        }
            
        setNumberOfTableViewSections()
    }
}

extension RequestDetailsViewController {
    
    func setNumberOfTableViewSections() {
        if (nextReservation.reservationIsWithinOneHour == true) {
            checkInCell.hidden = false
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            checkInCell.hidden = true
            tableView.contentInset = UIEdgeInsetsMake(-200, 0, 0, 0)
        }
    }
    
    /*
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 32
    }*/
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 3) {
            return 45
        } else {
            return 0
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if (cellClicked == cancelReservationCell) {
            
            let actionSheetController = UIAlertController(title: "Are you sure you want to delete this reservation?", message: "Deleted reservations are final and subject to Loop's Terms of Service cancellation policy.", preferredStyle: .ActionSheet)
            actionSheetController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let cancelReservationAction = UIAlertAction(title: "Delete Reservation", style: .Destructive) { (action) in
                
                self.resIDLocationRef.observeEventType(FIRDataEventType.Value) {
                    (snapshot: FIRDataSnapshot) in
                    print(snapshot)
                }
                
                self.resIDLocationRef.setValue(nil)
                
                
                // TODO: Remove reservation from user's upcoming reservation list. Remove reservation within DB.
                self.presentingViewController!.dismissViewControllerAnimated(true, completion: {})
            }
            actionSheetController.addAction(cancelReservationAction)
            
            let keepReservationAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            }
            actionSheetController.addAction(keepReservationAction)
            
            presentViewController(actionSheetController, animated: true) {
                actionSheetController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }
        }
    }
    
    @IBAction func textCaddieButtonPressed(sender: AnyObject) {
        let textAlertController = UIAlertController(title: "Sorry, something's wrong.", message: "It looks like you can't send a text message right now. Please try again later.", preferredStyle: .Alert)
        textAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Hi, this is \(userName.firstName) " + "\(userName.lastName) and I'll be golfing with you on July 1, 2016 at 12:00 PM through Loop. I wanted to let you know that..."
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

    }
    
    
    @IBAction func emailCaddieButtonPressed(sender: AnyObject) {
        let emailAlertController = UIAlertController(title: "Sorry, something's wrong.", message: "We cannot find an email account for us to use to contact your caddie. Please make sure your email settings are correct or try again later.", preferredStyle: .Alert)
        emailAlertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        if (MFMailComposeViewController.canSendMail()) {
            let controller = MFMailComposeViewController()
            controller.setSubject("Loop Upcoming Reservation Contact Request")
            controller.setMessageBody("Hi, this is \(userName.firstName) " + "\(userName.lastName) and I'll be golfing with you on July 1, 2016 at 12:00 PM through Loop. I wanted to let you know that...", isHTML: true)
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
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: {})
    }
}