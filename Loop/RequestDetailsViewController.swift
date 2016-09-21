//
//  RequestDetailsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/19/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase

class RequestDetailsViewController: UITableViewController {
    
    @IBOutlet weak var caddieProfileImageView: UIImageView!
    @IBOutlet weak var caddieNameLabel: UILabel!
    @IBOutlet weak var caddieMembershipHistoryLabel: UILabel!
    @IBOutlet weak var golfCourseNameLabel: UILabel!
    @IBOutlet weak var golfCourseLocationLabel: UILabel!
    @IBOutlet weak var resDateLabel: UILabel!
    @IBOutlet weak var resTimeLabel: UILabel!
    @IBOutlet weak var resIDNumberLabel: UILabel!
    
    @IBOutlet weak var requestStatusBannerCell: UITableViewCell!
    @IBOutlet weak var requestStatusBannerTitle: UILabel!
    @IBOutlet weak var requestStatusBannerDescription: UILabel!
    @IBOutlet weak var requestStatusBannerButton: UIButton!
    @IBOutlet weak var cancelReservationCell: UITableViewCell!
    
    private var dbRef : FIRDatabaseReference!
    private var resIDLocationRef : FIRDatabaseReference!
    private var userReservationRef : FIRDatabaseReference!
    
    var userID = String()
    
    var userName = UserName()
    var nextReservation = NextReservation()
    
    // Receive data via segue.
    var resIDHasBeenSent: String?
    var resStatusHasBeenSent: String?
    var caddieNameHasBeenSent: String?
    var caddieMemHistHasBeenSent: String?
    var courseNameHasBeenSent: String?
    var courseLocationHasBeenSent: String?
    var dateHasBeenSent: String?
    var timeHasBeenSent: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        requestStatusBannerButton.layer.cornerRadius = 15
        requestStatusBannerButton.layer.borderColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0).CGColor
        requestStatusBannerButton.layer.borderWidth = 1
        
        caddieProfileImageView.layer.cornerRadius = 50
        caddieNameLabel.text = caddieNameHasBeenSent
        
        self.dbRef = FIRDatabase.database().reference()
        
        if let user = FIRAuth.auth()?.currentUser {
            userID = user.uid
            self.userReservationRef = dbRef.child("users").child("\(userID)").child("resID_caddieID").child("\(resIDHasBeenSent!)")
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
        
        setAppearanceForRequestStatus(resStatusHasBeenSent!)
    }
}

extension RequestDetailsViewController {
    
    func setAppearanceForRequestStatus(resStatus: String) {
        if (resStatus == "p") {
            navigationItem.title = "Pending Request"
            requestStatusBannerTitle.text = "Your reservation request is still pending."
            requestStatusBannerTitle.textColor = UIColor.blackColor()
            requestStatusBannerDescription.text = "Your requested caddie has 12 hours to confirm or decline your reservation. You'll be updated as any status changes occur."
            requestStatusBannerButton.setTitle("    Send a reminder to this caddie    ", forState: .Normal)
        } else if (resStatus == "d") {
            navigationItem.title = "Declined Request"
            requestStatusBannerTitle.text = "Your reservation request has been declined."
            requestStatusBannerTitle.textColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
            requestStatusBannerDescription.text = "Unfortunately, your requested caddie has indicated that he or she is unable to complete your requested reservation."
            requestStatusBannerButton.setTitle("    Find a new caddie    ", forState: .Normal)
        }
    }
    
    @IBAction func requestStatusBannerButtonPressed(sender: AnyObject) {
        
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
            
            let actionSheetController = UIAlertController(title: "Are you sure you want to cancel?", message: "This action is final and will remove this reservation request from your profile. A canceled reservation request is subject to Loop's Terms of Service cancellation policy.", preferredStyle: .ActionSheet)
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
}