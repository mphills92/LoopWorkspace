//
//  CaddiesAvailableViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/8/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class CaddiesAvailableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var reservationSnapshotView: UIView!
    @IBOutlet weak var selectedCourseNameLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var selectedTimeLabel: UILabel!

    var caddiesFound = true
    
    let caddiesAvailable = Caddies.caddiesAvailable()

    // Pass data via segue.
    var selectedCourseNameToSend = String()
    var selectedLocationToSend = String()
    var selectedDateToSendAgain = String()
    var selectedTimeToSendAgain = String()
    var selectedCaddieNameToSend = String()    
    
    // Receive data from segue.
    var selectedCourseNameHasBeenSentAgain: String?
    var selectedLocationHasBeenSentAgain: String?
    var selectedDateHasBeenSent: NSDate?
    var selectedTimeHasBeenSent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Available Caddies"
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //tableView.contentInset = UIEdgeInsetsMake(-36, 0, -36, 0)
        
        reservationSnapshotView.layer.shadowColor = UIColor.blackColor().CGColor
        reservationSnapshotView.layer.shadowOpacity = 0.25
        reservationSnapshotView.layer.shadowOffset = CGSizeMake(0.0, 0.0)

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        var convertedDate = dateFormatter.stringFromDate(selectedDateHasBeenSent!)
        selectedDateToSendAgain = convertedDate
        
        selectedCourseNameLabel.text = selectedCourseNameHasBeenSentAgain
        selectedDateLabel.text = convertedDate
        selectedTimeLabel.text = selectedTimeHasBeenSent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension CaddiesAvailableViewController {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (caddiesFound == true) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "No caddies found that match your criteria."
            noDataLabel.textColor = UIColor.darkGrayColor()
            noDataLabel.textAlignment = NSTextAlignment.Center
            tableView.backgroundView = noDataLabel
            tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return numOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caddiesAvailable.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ChooseAvailableCaddiesCell
        
        cell.caddiesAvailable = caddiesAvailable[indexPath.item]
        cell.profileImageView.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = self.tableView?.cellForRowAtIndexPath(indexPath) as! ChooseAvailableCaddiesCell
        
        selectedCaddieNameToSend = cell.caddieNameLabel.text!
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("caddieSelectedSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "caddieSelectedSegue") {
            let destinationVC = segue.destinationViewController as! ConfirmReservationViewController
            selectedCourseNameToSend = selectedCourseNameHasBeenSentAgain!
            selectedLocationToSend = selectedLocationHasBeenSentAgain!
            selectedTimeToSendAgain = selectedTimeHasBeenSent!
            
            destinationVC.selectedCourseNameHasBeenSent = selectedCourseNameToSend
            destinationVC.selectedLocationHasBeenSent = selectedLocationToSend
            destinationVC.selectedDateHasBeenSentAgain = selectedDateToSendAgain
            destinationVC.selectedTimeHasBeenSentAgain = selectedTimeToSendAgain
            destinationVC.selectedCaddieNameHasBeenSent = selectedCaddieNameToSend
        }
    }
}

