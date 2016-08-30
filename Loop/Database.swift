//
//  Database.swift
//  Loop
//
//  Created by Matt Hills on 8/24/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import Foundation
import Firebase


// Class reference to all users in Firebase database.
class UsersDatabase {
    // Reference to the Firebase data store.
    private var dbRef : FIRDatabaseReference
    
    // Where all users will be stored.
    private var userIDRef : FIRDatabaseReference
    
    // Empty variables to be populated by the database and referenced by other view controllers.
    var userID = String()
    var firstName = String()
    var lastName = String()
    var currentEmail = String()
    var currentPhone = String()
    var membershipHistory = String()
    var lifetimeRounds = Int()
    var credit = Int()
    
    init() {
        self.dbRef = FIRDatabase.database().reference()
        
        if let user = FIRAuth.auth()?.currentUser {
            userID = user.uid
            currentEmail = user.email!
        }
        
        // Sets the reference to the user by utilizing the Firebase 'uid' associated with the account to set a path to the correct database node.
        self.userIDRef = self.dbRef.child("users").child("\(userID)")
        print(self.dbRef.child("users").child("\(userID)"))
        getUserInformation()
    }
    
    func getUserInformation() {
        self.userIDRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            let first_name = snapshot.value?.objectForKey("first_name") as! String
            let last_name = snapshot.value?.objectForKey("last_name") as! String
            //let currentEmail = snapshot.value?.objectForKey("email") as! String
            let phone = snapshot.value?.objectForKey("phone") as! String
            let membership_history = snapshot.value?.objectForKey("membership_history") as! String
            let lifetime_rounds = snapshot.value?.objectForKey("lifetime_rounds") as! Int
            let credit = snapshot.value?.objectForKey("credit") as! Int
            
            self.firstName = first_name
            self.lastName = last_name
            //self.email = email
            self.currentPhone = phone
            self.membershipHistory = membership_history
            self.lifetimeRounds = lifetime_rounds
            self.credit = credit
        }
    }
    
    func resetPassword(email: String) {
        
        FIRAuth.auth()?.sendPasswordResetWithEmail(email, completion: { (error) in
            if error == nil {
                
            }
        })
    }
}

// Class reference to all golf courses in Firebase database.
class GolfCoursesDatabase {
    // Reference to the Firebase data store.
    private var dbRef : FIRDatabaseReference
    
    // Where all golf courses will be stored.
    private var golfCourseRef : FIRDatabaseReference
    
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
        self.golfCourseRef = self.dbRef.child("golf_courses")
    }

    func getGolfCourseInformation(completion: (([String] -> Void))) {
        
        var courseNamesArray = [String]()
        var courseIDsArray = [String]()
        var courseLocationsArray = [String]()
        
        self.golfCourseRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            for child in snapshot.children {
                let golfCourseSnapshot = snapshot.childSnapshotForPath(child.key)
                let courseID = golfCourseSnapshot.key
                courseIDsArray.append(courseID)
                print("courseID: \(courseID)")
                
                if let name = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("name") as? String {
                    courseNamesArray.append(name)
                    print("name: \(name)")
                }
                
                if let location = snapshot.childSnapshotForPath("\(courseID)").value?.objectForKey("city_state") as? String {
                    courseLocationsArray.append(location)
                    print("location: \(location)")
                }
                
                print("-------------------------")

            }
            
            self.courseNames = courseNamesArray
            self.courseIDs = courseIDsArray
            self.courseLocations = courseLocationsArray
            
            
            if courseNamesArray.count == Int(snapshot.childrenCount) {
                completion(courseNamesArray)
            }
        }
    }

            /*
            let name = snapshot.value?.objectForKey("name") as! String
            let region = snapshot.value?.objectForKey("region") as! String
            let city = snapshot.value?.objectForKey("city") as! String
            let state = snapshot.value?.objectForKey("state") as! String
            let zip = snapshot.value?.objectForKey("zip") as! String
            let membership_history = snapshot.value?.objectForKey("membership_history") as! String
            let op_hrs_open = snapshot.value?.objectForKey("op_hrs_open") as! String
            let op_hrs_close = snapshot.value?.objectForKey("op_hrs_close") as! String
            let price = snapshot.value?.objectForKey("price") as! String
            let description = snapshot.value?.objectForKey("description") as! String
            let facilities_highlight_1 = snapshot.value?.objectForKey("facilities_highlight_1") as! String
            let facilities_highlight_2 = snapshot.value?.objectForKey("facilities_highlight_2") as! String
            let facilities_highlight_3 = snapshot.value?.objectForKey("facilities_highlight_3") as! String
            let amenities_highlight_1 = snapshot.value?.objectForKey("amenities_highlight_1") as! String
            let amenities_highlight_2 = snapshot.value?.objectForKey("amenities_highlight_2") as! String
            let amenities_highlight_3 = snapshot.value?.objectForKey("amenities_highlight_3") as! String
            let current_offer = snapshot.value?.objectForKey("current_offer") as! String
            
            self.name = name
            self.region = region
            self.city = city
            self.state = state
            self.zip = zip
            self.membershipHistory = membership_history
            self.operatingHoursOpen = op_hrs_open
            self.operatingHoursClose = op_hrs_close
            self.price = price
            self.description = description
            self.facilitiesHighlight1 = facilities_highlight_1
            self.facilitiesHighlight2 = facilities_highlight_2
            self.facilitiesHighlight3 = facilities_highlight_3
            self.amenitiesHighlight1 = amenities_highlight_1
            self.amenitiesHighlight2 = amenities_highlight_2
            self.amenitiesHighlight3 = amenities_highlight_3
            self.currentOffer = current_offer
            
            print(self.name, self.region, self.city, self.state, self.zip, self.membershipHistory, self.operatingHoursOpen, self.operatingHoursClose, self.price, self.description, self.facilitiesHighlight1, self.facilitiesHighlight2, self.facilitiesHighlight3, self.amenitiesHighlight1, self.amenitiesHighlight2, self.amenitiesHighlight3, self.currentOffer)*/

}