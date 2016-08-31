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
    }
    
    func getGolfCourseIDsInRadius(setPointLat: Double, setPointLon: Double, searchRadiusFromSetPoint: Double, completion: (([String] -> Void))) {
        
        var courseIDsArray = [String]()
        var courseLocationsArray = [String]()
        
        let setPointLocation = CLLocation(latitude: setPointLat, longitude: setPointLon)
        
        self.courseBasicInfoRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            for child in snapshot.children {
                let golfCourseSnapshot = snapshot.childSnapshotForPath(child.key)
                let courseID = golfCourseSnapshot.key
                
                if let latitude = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("lat") as? Double {
                    if let longitude = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("lon") as? Double {
                        
                        var courseLocation = CLLocation(latitude: latitude, longitude: longitude)
                        
                        var distance = (setPointLocation.distanceFromLocation(courseLocation))*0.000621371    // Conversion from meters to miles.
                        
                        if (distance <= searchRadiusFromSetPoint) {
                            courseIDsArray.append(courseID)
                            
                            /*
                            if let name = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("name") as? String {
                                courseNamesArray.append(name)
                            }
                            
                            if let location = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("city_state") as? String {
                             courseLocationsArray.append(location)
                            }*/
                        }
                    }
                }
            }
            
            self.courseIDs = courseIDsArray
            self.courseLocations = courseLocationsArray
                        
            if courseIDsArray.count == Int(snapshot.childrenCount) {
                completion(courseIDsArray)
            }
        }
    }
    
    func getGolfCourseBasicInfoForIDs(courseIDs: [String], completion: (([String] -> Void))) {
        
        var courseNamesArray = [String]()
        
        self.courseBasicInfoRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
        
            for var i = 0; i < courseIDs.count; i++ {
                if let name = snapshot.childSnapshotForPath("\(courseIDs[i])").value?.objectForKey("name") as? String {
                    courseNamesArray.append(name)
                }
            }
            
            self.courseNames = courseNamesArray
            
            if courseNamesArray.count == Int(snapshot.childrenCount) {
                completion(courseNamesArray)
            }
        }
    }
}