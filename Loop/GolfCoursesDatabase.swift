//
//  GolfCoursesDatabase.swift
//  Loop
//
//  Created by Matt Hills on 8/30/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

// Class reference to golf courses basic information in Firebase database.
class CoursesBasicInfoDatabase: NSObject, CLLocationManagerDelegate {
    private var dbRef : FIRDatabaseReference
    private var courseBasicInfoRef : FIRDatabaseReference
    private var courseDetailedInfoRef : FIRDatabaseReference
    
    // Empty arrays to be populated by the database.
    var courseNames = [String]()
    var courseIDs = [String]()
    var courseLocations = [String]()
    
    var region = String()
    var city = String()
    var state = String()
    var zip = String()
    var membershipHistory = String()
    var operatingHoursOpen = String()
    var operatingHoursClose = String()
    var price = String()
    //var description = String()
    var facilitiesHighlight1 = String()
    var facilitiesHighlight2 = String()
    var facilitiesHighlight3 = String()
    var amenitiesHighlight1 = String()
    var amenitiesHighlight2 = String()
    var amenitiesHighlight3 = String()
    var currentOffer = String()
    
    override init() {
        self.dbRef = FIRDatabase.database().reference()
        self.courseBasicInfoRef = self.dbRef.child("courses_basic_info")
        self.courseDetailedInfoRef = self.dbRef.child("courses_detailed_info")
        
    }
    
    func getGolfCourseIDsInRadius(setPointLat: Double, setPointLon: Double, searchRadiusFromSetPoint: Double, completion: (([String] -> Void))) {
        
        var courseIDsArray = [String]()
        var courseLocationsArray = [String]()
        var completionCounter = [Double]()

        
        let setPointLocation = CLLocation(latitude: setPointLat, longitude: setPointLon)
        
        self.courseBasicInfoRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            for child in snapshot.children {
                let golfCourseSnapshot = snapshot.childSnapshotForPath(child.key)
                let courseID = golfCourseSnapshot.key
                
                if let latitude = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("lat") as? Double {
                    if let longitude = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("lon") as? Double {
                        
                        var courseLocation = CLLocation(latitude: latitude, longitude: longitude)
                        
                        var distance = (setPointLocation.distanceFromLocation(courseLocation))*0.000621371    // Conversion from m to mi.
                        
                        completionCounter.append(distance)
                        
                        if (distance <= searchRadiusFromSetPoint) {
                            courseIDsArray.append(courseID)
                        }
                    }
                }
            }
            
            self.courseIDs = courseIDsArray
            self.courseLocations = courseLocationsArray
                        
            if completionCounter.count == Int(snapshot.childrenCount) {
                completion(courseIDsArray)
            }
        }
    }
}

// Class reference to golf courses detailed information in Firebase database.
class CoursesDetailedInfoDatabase {
    private var dbRef : FIRDatabaseReference
    private var courseDetailedInfoRef : FIRDatabaseReference
    
    var membershipHistory = String()
    var detailedInformation = [String]()

    init() {
        self.dbRef = FIRDatabase.database().reference()
        self.courseDetailedInfoRef = self.dbRef.child("courses_detailed_info")
    }

    func getDetailedInformationForCourseID(selectedCourseIDToSend: String, completion: (([String] -> Void))) {
        
        var detailedInformationArray = [String]()

        self.courseDetailedInfoRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            if let street = snapshot.childSnapshotForPath("\(selectedCourseIDToSend)").value?.objectForKey("street") as? String {
                detailedInformationArray.append(street)
            }
            
            if let city_state = snapshot.childSnapshotForPath("\(selectedCourseIDToSend)").value?.objectForKey("city_state") as? String {
                detailedInformationArray.append(city_state)
            }
            
            if let zip = snapshot.childSnapshotForPath("\(selectedCourseIDToSend)").value?.objectForKey("zip") as? Int {
                detailedInformationArray.append("\(zip)")
            }
            
            if let membership_history = snapshot.childSnapshotForPath("\(selectedCourseIDToSend)").value?.objectForKey("membership_history") as? String {
                detailedInformationArray.append(membership_history)
            }
            
            if let description = snapshot.childSnapshotForPath("\(selectedCourseIDToSend)").value?.objectForKey("description") as? String {
                detailedInformationArray.append(description)
            }
            
            if let price = snapshot.childSnapshotForPath("\(selectedCourseIDToSend)").value?.objectForKey("price") as? Int {
                detailedInformationArray.append("\(price)")
            }
            
            if let op_hrs_open = snapshot.childSnapshotForPath("\(selectedCourseIDToSend)").value?.objectForKey("op_hrs_open") as? String {
                detailedInformationArray.append(op_hrs_open)
            }
            
            if let op_hrs_close = snapshot.childSnapshotForPath("\(selectedCourseIDToSend)").value?.objectForKey("op_hrs_close") as? String {
                detailedInformationArray.append(op_hrs_close)
            }
            
            self.detailedInformation = detailedInformationArray
        
            if (detailedInformationArray.count == 8) {
                completion(detailedInformationArray)
            }
        }
    }
}