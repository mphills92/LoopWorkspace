//
//  UsersDatabase.swift
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
    var userLatitude = Double()
    var userLongitude = Double()
    var reservationIDs = [String]()
    var reservationsAndCaddies = [[String:String]]()
    
    init() {
        self.dbRef = FIRDatabase.database().reference()
        
        if let user = FIRAuth.auth()?.currentUser {
            userID = user.uid
            currentEmail = user.email!
        }
        
        // Sets the reference to the user by utilizing the Firebase 'uid' associated with the account to set a path to the correct database node.
        self.userIDRef = self.dbRef.child("users").child("\(userID)")
    }
    
    func setUserLocation(userLat: Double, userLon: Double) {
        
        let latRef = userIDRef.child("lat")
        latRef.setValue("\(userLat)")
        userLatitude = userLat
        
        let lonRef = userIDRef.child("lon")
        lonRef.setValue("\(userLon)")
        userLongitude = userLon
    }
    
    func getUserInformation(completion: ((Bool -> Void))) {
        
        //var reservationIDsArray = [String]()
        
        self.userIDRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            let first_name = snapshot.value?.objectForKey("first_name") as! String
            let last_name = snapshot.value?.objectForKey("last_name") as! String
            let phone = snapshot.value?.objectForKey("phone") as! String
            let membership_history = snapshot.value?.objectForKey("membership_history") as! String
            let lifetime_rounds = snapshot.value?.objectForKey("lifetime_rounds") as! Int
            let credit = snapshot.value?.objectForKey("credit") as! Int
            
            self.firstName = first_name
            self.lastName = last_name
            self.currentPhone = phone
            self.membershipHistory = membership_history
            self.lifetimeRounds = lifetime_rounds
            self.credit = credit
            //self.reservationIDs = reservationIDsArray
            
            if (self.firstName != "" && self.lastName != "" && self.currentPhone != "" && self.membershipHistory != "" && "\(self.lifetimeRounds)" != "" && "\(self.credit)" != "") {
                completion(true)
            }
        }
    }
    
    
    func getUserReservationInformation(completion: (([[String:String]] -> Void))) {
        
        var reservationIDsArray = [String]()
        var reservationAndCaddieDict = [[String:String]]()
        var completionCounter = 0
        
        self.userIDRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            let resIDCaddieIDSnapshot = snapshot.childSnapshotForPath("resID_caddieID")
            
            for child in resIDCaddieIDSnapshot.children {
                let reservationIDSnapshot = resIDCaddieIDSnapshot.childSnapshotForPath(child.key)
                let reservationID = reservationIDSnapshot.key
                
                let caddieID = resIDCaddieIDSnapshot.value?.objectForKey("\(reservationID)")
                
                if (reservationID != "0") {
                    //reservationIDsArray.append(reservationID)
                    reservationAndCaddieDict.append(["resID": "\(reservationID)", "caddieID": "\(caddieID!)"])
                    
                    completionCounter++
                }
            }
            
            if (reservationAndCaddieDict.count == completionCounter) {
                
                /*
                if (reservationIDsArray[0] == "null_value") {
                    reservationIDsArray.removeFirst()
                    self.reservationIDs = reservationIDsArray
                    completion(self.reservationIDs)
                } else {
                    self.reservationIDs = reservationIDsArray
                    completion(self.reservationIDs)
                }*/
                
                //self.reservationIDs = reservationIDsArray
                self.reservationsAndCaddies = reservationAndCaddieDict
                completion(self.reservationsAndCaddies)
                //completion(self.reservationIDs)
            }
            
            /*
            let reservationsSnapshot = snapshot.childSnapshotForPath("reservations")
            
            for child in reservationsSnapshot.children {
                let reservationIDsSnapshot = reservationsSnapshot.childSnapshotForPath(child.key)
                print(reservationIDsSnapshot)
                let reservationIDKey = reservationIDsSnapshot.key
                
                if let reservation = reservationsSnapshot.childSnapshotForPath("\(reservationIDKey)").value as? String {
                    reservationIDsArray.append(reservation)
                }
            }

            if (reservationIDsArray.count == Int(reservationsSnapshot.childrenCount)) {
                
                if (reservationIDsArray[0] == "null_value") {
                    reservationIDsArray.removeFirst()
                    self.reservationIDs = reservationIDsArray
                    completion(self.reservationIDs)
                } else {
                    self.reservationIDs = reservationIDsArray
                    completion(self.reservationIDs)
                }
            }*/
        }
    }
        
    func resetPassword(email: String) {
        
        FIRAuth.auth()?.sendPasswordResetWithEmail(email, completion: { (error) in
            if error == nil {
                
            }
        })
    }
}