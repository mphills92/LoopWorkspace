//
//  DatesDatabase.swift
//  Loop
//
//  Created by Matt Hills on 9/9/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import Foundation
import Firebase

class DatesDatabase {
    private var dbRef : FIRDatabaseReference
    private var calendarDatesRef : FIRDatabaseReference
    private var caddiesRef : FIRDatabaseReference
    private var reservationsRef : FIRDatabaseReference
    
    init() {
        self.dbRef = FIRDatabase.database().reference()
        self.calendarDatesRef = self.dbRef.child("calendar_dates")
        self.caddiesRef = self.dbRef.child("caddies")
        self.reservationsRef = self.dbRef.child("reservations_table")
    }
    
    func getAvailableCaddieIDsForDate(selectedDateNSDate: NSDate) {
        
        let formatterToDateString = NSDateFormatter()
        formatterToDateString.dateFormat = "yyyy-MM-dd"
        let convertedDateString = formatterToDateString.stringFromDate(selectedDateNSDate)
        
        let formatterToTimeString = NSDateFormatter()
        formatterToTimeString.dateFormat = "HH:mm"
        formatterToTimeString.timeZone = NSTimeZone(name: "UTC")
        let convertedTimeString = formatterToTimeString.stringFromDate(selectedDateNSDate)
        
        var availableCaddieIDsForDateArray = [String]()
        var completionCounter = [Double]()
        
        self.calendarDatesRef.child("\(convertedDateString)").observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            for child in snapshot.children {
                let datesSnapshot = snapshot.childSnapshotForPath(child.key)
                let availableCaddieIDForDate = datesSnapshot.key
                
                var caddieID = availableCaddieIDForDate
                var unavailableTimes = UInt()
                
                self.caddiesRef.child("\(availableCaddieIDForDate)").child("reservations").observeEventType(FIRDataEventType.Value) {
                    (snapshot: FIRDataSnapshot) in
                    
                    for child in snapshot.children {
                        let reservationsSnapshot = snapshot.childSnapshotForPath(child.key)
                        if (reservationsSnapshot.value as? Int) != nil {
                            let resIDsSnapshot = reservationsSnapshot.value!
                            
                            self.reservationsRef.child("\(resIDsSnapshot)").observeEventType(FIRDataEventType.Value) {
                                (snapshot: FIRDataSnapshot) in
                                
                                for child in snapshot.children {
                                    let timesSnapshot = snapshot.childSnapshotForPath(child.key)
                                    
                                    
                                    if (timesSnapshot.value as? String) != nil {
                                        let unavailableTimesSnapshot = timesSnapshot.value!
                                        unavailableTimes = timesSnapshot.childrenCount
                                    }
                                }
                            }
                        }
                    }
                }
                
                var dictionary = [caddieID : unavailableTimes]
                print(dictionary)
            }
        }
    }
}
