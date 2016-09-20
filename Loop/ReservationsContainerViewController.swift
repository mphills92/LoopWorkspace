//
//  ReservationsContainerViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase

class ReservationsContainerViewController: UITableViewController {
    
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
    var reservationIDsToStore = [String]()
    
    var caddieNamesToDisplay = [String]()
    var caddieMemHistToStore = [String]()
    var courseNamesToDisplay = [String]()
    var courseLocationsToStore = [String]()
    var datesToDisplay = [String]()
    var timesToDisplay = [String]()
    
    // Send data via segue.
    var resIDToSend = String()
    var caddieNameToSend = String()
    var caddieMemHistToSend = String()
    var courseNameToSend = String()
    var courseLocationToSend = String()
    var dateToSend = String()
    var timeToSend = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, -36, 0)
        
        
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
            var resIDs = [String]()
            var caddieIDs = [String]()
            
            for var y=0; y < self.resIDsCaddieIDs.count; y++ {
                var resIDCaddieIDDict = self.resIDsCaddieIDs[y]
                resIDs.append(resIDCaddieIDDict["resID"]!)
                caddieIDs.append(resIDCaddieIDDict["caddieID"]!)
            }
            
            self.reservationsDB.getConfirmedReservationsIDs(resIDs) {
                (reservationIDs) -> Void in
                
                self.reservationIDsToStore = reservationIDs
                
                self.userRef.child("resID_caddieID").observeEventType(FIRDataEventType.Value) {
                    (snapshot: FIRDataSnapshot) in
                    
                    var caddieIDsArray = [String]()
                    
                    for var r=0; r < reservationIDs.count; r++ {
                        if let caddieID = snapshot.childSnapshotForPath("\(reservationIDs[r])").value as? String {
                            caddieIDsArray.append(caddieID)
                        }
                    }
                                        
                    self.caddiesRef.observeEventType(FIRDataEventType.Value) {
                        (snapshot: FIRDataSnapshot) in
                        
                        var caddieNamesArray = [String]()
                        var caddiesMemHistArray = [String]()
                        
                        for var i = 0; i < reservationIDs.count; i++ {
                            
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
                    
                    for var g = 0; g < reservationIDs.count; g++ {
                        if let courseID = snapshot.childSnapshotForPath("\(reservationIDs[g])").value?.objectForKey("course") as? String {
                            
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
                    
                    for var d = 0; d < reservationIDs.count; d++ {
                        if let date = snapshot.childSnapshotForPath("\(reservationIDs[d])").value?.objectForKey("date") as? String {
                            
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
                    
                    for var t = 0; t < reservationIDs.count; t++ {
                        if let time = snapshot.childSnapshotForPath("\(reservationIDs[t])").value?.objectForKey("time") as? String {
                            
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
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
}

extension ReservationsContainerViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (reservationIDsToStore.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "You have no reservations to show."
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
        return reservationIDsToStore.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reservationCell", forIndexPath: indexPath) as! ReservationCell
        
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
        
        resIDToSend = reservationIDsToStore[indexPath.row]
        caddieNameToSend = caddieNamesToDisplay[indexPath.row]
        caddieMemHistToSend = caddieMemHistToStore[indexPath.row]
        courseNameToSend = courseNamesToDisplay[indexPath.row]
        courseLocationToSend = courseLocationsToStore[indexPath.row]
        dateToSend = datesToDisplay[indexPath.row]
        timeToSend = timesToDisplay[indexPath.row]
        
        self.performSegueWithIdentifier("toReservationDetailsSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "toReservationDetailsSegue") {
            let destinationVC = segue.destinationViewController as! ReservationDetailsViewController
            
            destinationVC.resIDHasBeenSent = resIDToSend
            destinationVC.caddieNameHasBeenSent = caddieNameToSend
            destinationVC.caddieMemHistHasBeenSent = caddieMemHistToSend
            destinationVC.courseNameHasBeenSent = courseNameToSend
            destinationVC.courseLocationHasBeenSent = courseLocationToSend
            destinationVC.dateHasBeenSent = dateToSend
            destinationVC.timeHasBeenSent = timeToSend
        }
    }

}