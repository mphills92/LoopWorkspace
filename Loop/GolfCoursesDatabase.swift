//
//  GolfCoursesDatabase.swift
//  Loop
//
//  Created by Matt Hills on 8/30/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import Foundation
import Firebase

// Class reference to golf courses basic information in Firebase database.
class CoursesBasicInfoDatabase {
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
    var description = String()
    var facilitiesHighlight1 = String()
    var facilitiesHighlight2 = String()
    var facilitiesHighlight3 = String()
    var amenitiesHighlight1 = String()
    var amenitiesHighlight2 = String()
    var amenitiesHighlight3 = String()
    var currentOffer = String()
    
    init() {
        self.dbRef = FIRDatabase.database().reference()
        self.courseBasicInfoRef = self.dbRef.child("courses_basic_info")
    }
    
    func getBasicInfoForGolfCoursesInRadius(completion: (([String] -> Void))) {

        var courseNamesArray = [String]()
        var courseIDsArray = [String]()
        var courseLocationsArray = [String]()
        
        self.courseBasicInfoRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            for child in snapshot.children {
                let golfCourseSnapshot = snapshot.childSnapshotForPath(child.key)
                let courseID = golfCourseSnapshot.key
                courseIDsArray.append(courseID)
                
                if let latitude = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("lat") as? Double {
                    if let longitude = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("lon") as? Double {
                        
                    }
                }
                
                if let name = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("name") as? String {
                    courseNamesArray.append(name)
                }
                
                if let location = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("city_state") as? String {
                    courseLocationsArray.append(location)
                }
            }
            
            self.courseNames = courseNamesArray
            self.courseIDs = courseIDsArray
            self.courseLocations = courseLocationsArray
            
            
            if courseNamesArray.count == Int(snapshot.childrenCount) {
                completion(courseNamesArray)
            }
        }
    }
}