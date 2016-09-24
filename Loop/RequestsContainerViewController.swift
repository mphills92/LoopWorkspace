//
//  RequestsContainerViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase

class RequestsContainerViewController: UITableViewController {
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    let reservationsDB = ReservationsDatabase()
    
    private var dbRef : FIRDatabaseReference!
    private var reservationsRef : FIRDatabaseReference!
    private var userRef : FIRDatabaseReference!
    private var caddiesRef : FIRDatabaseReference!
    private var coursesRef : FIRDatabaseReference!
    
    var userID = String()
    
    var resIDsCaddieIDs = [[String:String]]()
    var requestIDsToStore = [String]()
    
    var caddieNamesToDisplay = [String]()
    var caddieMemHistToStore = [String]()
    var courseNamesToDisplay = [String]()
    var courseLocationsToStore = [String]()
    var datesToDisplay = [String]()
    var timesToDisplay = [String]()
    var requestStatusesToDisplay = [String]()
    
    // Send data via segue.
    var resIDToSend = String()
    var resStatusToSend = String()
    var caddieNameToSend = String()
    var caddieMemHistToSend = String()
    var courseNameToSend = String()
    var courseLocationToSend = String()
    var dateToSend = String()
    var timeToSend = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, -200, 0)
        
        
        self.dbRef = FIRDatabase.database().reference()
        self.reservationsRef = dbRef.child("requests_reservations")
        self.caddiesRef = dbRef.child("caddies")
        self.coursesRef = dbRef.child("courses_basic_info")
        
        if let user = FIRAuth.auth()?.currentUser {
            userID = user.uid
            self.userRef = dbRef.child("users").child("\(userID)")
        }
    
        usersDB.getUserReservationInformation() {
            (resIDsCaddieIDsSentFromDB) -> Void in
            
            self.resIDsCaddieIDs = resIDsCaddieIDsSentFromDB
            var requestResIDs = [String]()
            var caddieRequestIDs = [String]()
            
            for var y=0; y < self.resIDsCaddieIDs.count; y++ {
                var resIDCaddieIDDict = self.resIDsCaddieIDs[y]
                requestResIDs.append(resIDCaddieIDDict["resID"]!)
                caddieRequestIDs.append(resIDCaddieIDDict["caddieID"]!)
            }
            
            self.reservationsDB.getRequestsIDs(requestResIDs) {
                (requestsIDs) -> Void in
                
                self.requestIDsToStore = requestsIDs
               
                self.userRef.child("resID_caddieID").observeEventType(FIRDataEventType.Value) {
                    (snapshot: FIRDataSnapshot) in
                    
                    var caddieIDsArray = [String]()

                    for var r=0; r < requestsIDs.count; r++ {
                        if let caddieID = snapshot.childSnapshotForPath("\(requestsIDs[r])").value as? String {
                            caddieIDsArray.append(caddieID)
                        }
                    }
                                        
                    self.caddiesRef.observeEventType(FIRDataEventType.Value) {
                        (snapshot: FIRDataSnapshot) in
                        
                        var caddieNamesArray = [String]()
                        var caddiesMemHistArray = [String]()
                        
                        for var i = 0; i < requestsIDs.count; i++ {
                            
                            // Receive names of reserved caddies. Create array of names.
                            var caddieName = String()
                            if let first_name = snapshot.childSnapshotForPath("\(caddieIDsArray[i])").value?.objectForKey("first_name") as? String {
                                if let last_name = snapshot.childSnapshotForPath("\(caddieIDsArray[i])").value?.objectForKey("last_name") as? String {
                                    caddieName = "\(first_name) \(last_name)"
                                }
                                caddieNamesArray.append(caddieName)
                            }
                            
                            // Receive membership history of reserved caddies. Create an array of membership histories.
                            if let membership_history = snapshot.childSnapshotForPath("\(caddieIDsArray[i])").value?.objectForKey("membership_history") as? String {
                                caddiesMemHistArray.append(membership_history)
                            }
                            
                            self.caddieNamesToDisplay = caddieNamesArray
                            self.caddieMemHistToStore = caddiesMemHistArray
                        }
                    }
                }
                
                self.reservationsRef.observeEventType(FIRDataEventType.Value) {
                    (snapshot: FIRDataSnapshot) in
                    
                    var courseNamesArray = [String]()
                    var courseLocationsArray = [String]()
                    var datesArray = [String]()
                    var timesArray = [String]()
                    var requestStatusesArray = [String]()
                    
                    for var g = 0; g < requestsIDs.count; g++ {
                        if let courseID = snapshot.childSnapshotForPath("\(requestsIDs[g])").value?.objectForKey("course") as? String {
                            
                            self.coursesRef.observeEventType(FIRDataEventType.Value) {
                                (snapshot: FIRDataSnapshot) in
                                
                                // Receive names of reserved courses. Create an array of golf course names.
                                if let course_name = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("name") as? String {
                                    courseNamesArray.append(course_name)
                                }
                                
                                // Receive locations of reserved courses. Create an array of golf course locations.
                                if let course_location = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("city_state") as? String {
                                    courseLocationsArray.append(course_location)
                                }
                                
                                self.courseNamesToDisplay = courseNamesArray
                                self.courseLocationsToStore = courseLocationsArray
                            }
                        }
                    }
                    
                    for var d = 0; d < requestsIDs.count; d++ {
                        if let date = snapshot.childSnapshotForPath("\(requestsIDs[d])").value?.objectForKey("date") as? String {
                            
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            dateFormatter.timeZone = NSTimeZone(name: "UTC")
                            
                            let formattedNSDate = dateFormatter.dateFromString(date)
                            
                            let dateStringFormatter = NSDateFormatter()
                            dateStringFormatter.dateStyle = .LongStyle
                            dateStringFormatter.timeStyle = .NoStyle
                            dateStringFormatter.timeZone = NSTimeZone(name: "UTC")
                            
                            let formattedDateToDisplay = dateStringFormatter.stringFromDate(formattedNSDate!)
                            
                            datesArray.append(formattedDateToDisplay)
                        }
                        self.datesToDisplay = datesArray
                    }

                    for var t = 0; t < requestsIDs.count; t++ {
                        if let time = snapshot.childSnapshotForPath("\(requestsIDs[t])").value?.objectForKey("time") as? String {
                            
                            let timeFormatter = NSDateFormatter()
                            timeFormatter.dateFormat = "HH:mm"
                            timeFormatter.timeZone = NSTimeZone(name: "UTC")
                            
                            let formattedNSDateTime = timeFormatter.dateFromString(time)
                            
                            let timeStringFormatter = NSDateFormatter()
                            timeStringFormatter.dateStyle = .NoStyle
                            timeStringFormatter.timeStyle = .ShortStyle
                            timeStringFormatter.timeZone = NSTimeZone(name: "UTC")
                            
                            let formattedTimeToDisplay = timeStringFormatter.stringFromDate(formattedNSDateTime!)
                            
                            timesArray.append(formattedTimeToDisplay)
                        }
                        self.timesToDisplay = timesArray
                    }
                    
                    for var x = 0; x < requestsIDs.count; x++ {
                        if let status = snapshot.childSnapshotForPath("\(requestsIDs[x])").value?.objectForKey("status") as? String {
                            
                            if (status == "pending") {
                                requestStatusesArray.append("p")
                            } else if (status == "declined") {
                                requestStatusesArray.append("d")
                            }
                            self.requestStatusesToDisplay = requestStatusesArray
                        }
                    }
                }
            }
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
}

extension RequestsContainerViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (requestIDsToStore.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "You have no requested caddies to show."
            noDataLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
            noDataLabel.textColor = UIColor.darkGrayColor()
            noDataLabel.textAlignment = NSTextAlignment.Center
            tableView.backgroundView = noDataLabel
            tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return numOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestIDsToStore.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("requestCell", forIndexPath: indexPath) as! RequestCell
        
        if (requestStatusesToDisplay.count != 0) {
            if (requestStatusesToDisplay[indexPath.row] == "p") {
                cell.requestStatusBadge.text = "PENDING"
                cell.requestStatusBadge.textColor = UIColor(red: 255/255, green: 180/255, blue: 0/255, alpha: 1.0)
                cell.requestStatusBadge.layer.borderColor = UIColor(red: 255/255, green: 180/255, blue: 0/255, alpha: 1.0).CGColor
                cell.requestStatusBadge.layer.borderWidth = 1
                cell.requestStatusBadge.layer.cornerRadius = 8
            } else if (requestStatusesToDisplay[indexPath.row] == "d") {
                cell.requestStatusBadge.text = "UNAVAILABLE"
                cell.requestStatusBadge.textColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
                cell.requestStatusBadge.layer.borderColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0).CGColor
                cell.requestStatusBadge.layer.borderWidth = 1
                cell.requestStatusBadge.layer.cornerRadius = 8
            }
        }
        
        if (courseNamesToDisplay.count != 0) {
            cell.golfCourseNameLabel.text = courseNamesToDisplay[indexPath.row]
        }

        if (caddieNamesToDisplay.count != 0) {
            cell.caddieNameLabel.text = caddieNamesToDisplay[indexPath.row]
        }
        
        if (datesToDisplay.count != 0) {
            cell.reservationDateLabel.text = datesToDisplay[indexPath.row]
        }
        
        if (timesToDisplay.count != 0) {
            cell.reservationTimeLabel.text = timesToDisplay[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        resIDToSend = requestIDsToStore[indexPath.row]
        resStatusToSend = requestStatusesToDisplay[indexPath.row]
        caddieNameToSend = caddieNamesToDisplay[indexPath.row]
        caddieMemHistToSend = caddieMemHistToStore[indexPath.row]
        courseNameToSend = courseNamesToDisplay[indexPath.row]
        courseLocationToSend = courseLocationsToStore[indexPath.row]
        dateToSend = datesToDisplay[indexPath.row]
        timeToSend = timesToDisplay[indexPath.row]
        
        self.performSegueWithIdentifier("toRequestDetailsSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "toRequestDetailsSegue") {
            let destinationVC = segue.destinationViewController as! RequestDetailsViewController
            
            destinationVC.resIDHasBeenSent = resIDToSend
            destinationVC.resStatusHasBeenSent = resStatusToSend
            destinationVC.caddieNameHasBeenSent = caddieNameToSend
            destinationVC.caddieMemHistHasBeenSent = caddieMemHistToSend
            destinationVC.courseNameHasBeenSent = courseNameToSend
            destinationVC.courseLocationHasBeenSent = courseLocationToSend
            destinationVC.dateHasBeenSent = dateToSend
            destinationVC.timeHasBeenSent = timeToSend
        }
    }
    
    
        
}