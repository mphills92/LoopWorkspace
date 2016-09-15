//
//  UpcomingReservationsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase

class UpcomingReservationsViewController: UITableViewController {
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    
    private var dbRef : FIRDatabaseReference!
    private var reservationsRef : FIRDatabaseReference!
    private var caddiesRef : FIRDatabaseReference!
    private var coursesRef : FIRDatabaseReference!
    
    var reservationIDsToStore = [String]()
    var numberOfReservations = Int()
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
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, -200, 0)
        
        self.dbRef = FIRDatabase.database().reference()
        self.reservationsRef = dbRef.child("reservations_table")
        self.caddiesRef = dbRef.child("caddies")
        self.coursesRef = dbRef.child("courses_basic_info")
        
        usersDB.getUserReservationInformation() {
            (reservationIDsSentFromDB) -> Void in
            
            self.reservationIDsToStore = reservationIDsSentFromDB
            self.numberOfReservations = reservationIDsSentFromDB.count
            
            self.reservationsRef.observeEventType(FIRDataEventType.Value) {
                (snapshot: FIRDataSnapshot) in
                
                var caddieNamesArray = [String]()
                var caddiesMemHistArray = [String]()
                var courseNamesArray = [String]()
                var courseLocationsArray = [String]()
                var datesArray = [String]()
                var timesArray = [String]()
                
                for var i = 0; i < self.numberOfReservations; i++ {
                    if let caddieID = snapshot.childSnapshotForPath("\(reservationIDsSentFromDB[i])").value?.objectForKey("caddie") as? String {
                        
                        self.caddiesRef.observeEventType(FIRDataEventType.Value) {
                            (snapshot: FIRDataSnapshot) in
                            
                            // Receive names of reserved caddies. Create array of names.
                            var caddieName = String()
                            if let first_name = snapshot.childSnapshotForPath("\(caddieID)").value?.objectForKey("first_name") as? String {
                                if let last_name = snapshot.childSnapshotForPath("\(caddieID)").value?.objectForKey("last_name") as? String {
                                    caddieName = "\(first_name) \(last_name)"
                                }
                                caddieNamesArray.append(caddieName)
                            }
                            
                            // Receive membership history of reserved caddies. Create an array of membership histories.
                            if let membership_history = snapshot.childSnapshotForPath("\(caddieID)").value?.objectForKey("membership_history") as? String {
                                caddiesMemHistArray.append(membership_history)
                            }
                            
                            self.caddieNamesToDisplay = caddieNamesArray
                            self.caddieMemHistToStore = caddiesMemHistArray
                        }
                    }
                }
                
                for var g = 0; g < self.numberOfReservations; g++ {
                    if let courseID = snapshot.childSnapshotForPath("\(reservationIDsSentFromDB[g])").value?.objectForKey("course") as? String {
                        
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
                
                for var d = 0; d < self.numberOfReservations; d++ {
                    if let date = snapshot.childSnapshotForPath("\(reservationIDsSentFromDB[d])").value?.objectForKey("date") as? String {
                    
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
                
                for var t = 0; t < self.numberOfReservations; t++ {
                    if let time = snapshot.childSnapshotForPath("\(reservationIDsSentFromDB[t])").value?.objectForKey("time") as? String {
                        
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

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
}

extension UpcomingReservationsViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (numberOfReservations > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "You have no upcoming reservations."
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
        return numberOfReservations
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reservationRecapCell", forIndexPath: indexPath) as! ReservationRecapCell
        
        cell.userProfileImage.layer.cornerRadius = 50
        
        if (caddieNamesToDisplay.count != 0) {
            cell.caddieNameLabel.text = caddieNamesToDisplay[indexPath.row]
            
            if (courseNamesToDisplay.count != 0) {
                cell.golfCourseNameLabel.text = courseNamesToDisplay[indexPath.row]
            }
            
            if (datesToDisplay.count != 0) {
                cell.reservationDateLabel.text = datesToDisplay[indexPath.row]
            }
            
            if (timesToDisplay.count != 0) {
                cell.reservationTimeLabel.text = timesToDisplay[indexPath.row]
            }
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
        
        self.performSegueWithIdentifier("toUpcomingReservationOverviewSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "toUpcomingReservationOverviewSegue") {
            let destinationVC = segue.destinationViewController as! OverviewUpcomingReservationViewController
            
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