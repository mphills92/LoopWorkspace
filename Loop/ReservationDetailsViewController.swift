//
//  ReservationDetailsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/24/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class ReservationDetailsViewController: UITableViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    
    @IBOutlet weak var caddieProfileImageView: UIImageView!
    @IBOutlet weak var caddieNameLabel: UILabel!
    @IBOutlet weak var caddieMembershipHistoryLabel: UILabel!
    @IBOutlet weak var golfCourseNameLabel: UILabel!
    @IBOutlet weak var golfCourseLocationLabel: UILabel!
    @IBOutlet weak var resDateLabel: UILabel!
    @IBOutlet weak var resTimeLabel: UILabel!
    @IBOutlet weak var resIDNumberLabel: UILabel!
    
    @IBOutlet weak var activeReservationBannerCell: UITableViewCell!

    @IBOutlet weak var cancelReservationCell: UITableViewCell!
    
    private var dbRef : FIRDatabaseReference!
    private var resIDLocationRef : FIRDatabaseReference!
    private var userReservationRef : FIRDatabaseReference!
    private var userRef : FIRDatabaseReference!
    
    var userID = String()
    var userFirstName = String()
    var userLastName = String()
    
    // Receive data via segue.
    var resIDHasBeenSent: String?
    var resStatusHasBeenSent: String?
    var caddieNameHasBeenSent: String?
    var caddieMemHistHasBeenSent: String?
    var courseNameHasBeenSent: String?
    var courseLocationHasBeenSent: String?
    var dateHasBeenSent: String?
    var timeHasBeenSent: String?

    
    var previousReservation = PreviousReservation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Upcoming Reservation"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        caddieProfileImageView.layer.cornerRadius = 50
        caddieNameLabel.text = caddieNameHasBeenSent
        
        
        self.dbRef = FIRDatabase.database().reference()
        
        if let user = FIRAuth.auth()?.currentUser {
            userID = user.uid
            self.userReservationRef = dbRef.child("users").child("\(userID)").child("resID_caddieID").child("\(resIDHasBeenSent!)")
            self.userRef = dbRef.child("users").child("\(userID)")
            
        }
        
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
        
        evaluateForActiveReservation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        usersDB.getUserInformation() {
            (true) -> Void in
            
            self.userFirstName = self.usersDB.firstName
            self.userLastName = self.usersDB.lastName
        }
    }
    
}

extension ReservationDetailsViewController {
    
    func evaluateForActiveReservation() {
        // If time of reservation is within 1 hour of current time...
        if (previousReservation.reviewHasBeenSubmitted == false) {
            activeReservationBannerCell.hidden = false
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            // else
            activeReservationBannerCell.hidden = true
            tableView.contentInset = UIEdgeInsetsMake(-212, 0, 0, 0)
        }
    }
    
    func removeReservationFromDB(completion: ((Bool -> Void))) {
        self.resIDLocationRef.child("status").setValue("invalid")
        completion(true)
    }
    
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
            
            let actionSheetController = UIAlertController(title: "Are you sure you want to cancel?", message: "This action is final and will delete this reservation from your profile. A canceled reservation is subject to Loop's Terms of Service cancellation policy.", preferredStyle: .ActionSheet)
            actionSheetController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let cancelReservationAction = UIAlertAction(title: "Cancel Reservation", style: .Destructive) { (action) in
                
                self.removeReservationFromDB() {
                    (true) -> Void in
                    self.presentingViewController!.dismissViewControllerAnimated(true, completion: {})
                }
                
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
            controller.body = "Hi, this is \(userFirstName) " + "\(userLastName) and I'll be golfing with you on \(dateHasBeenSent!) at \(timeHasBeenSent!) using Loop. I wanted to let you know that..."
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
            controller.setMessageBody("Hi, this is \(userFirstName) " + "\(userLastName) and I'll be golfing with you on \(dateHasBeenSent!) at \(timeHasBeenSent!) using Loop. I wanted to let you know that...", isHTML: true)
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

