//
//  Database.swift
//  Loop
//
//  Created by Matt Hills on 8/24/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import Foundation
import Firebase

class UsersDatabase {
    // Reference to the Firebase data store.
    private var dbRef : FIRDatabaseReference
    
    // Where all users will be stored.
    private var userIDRef : FIRDatabaseReference
    
    // Variables to populate form the database.
    var firstName = String()
    var lastName = String()
    
    init() {
        self.dbRef = FIRDatabase.database().reference()
        
        // Sets the reference to the caddieUsers part of the database.
        self.userIDRef = self.dbRef.child("users").child("12546")
        getUserInformation()
    }
    
    func getUserInformation() {
        self.userIDRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            let first_name = snapshot.value?.objectForKey("first_name") as! String
            let last_name = snapshot.value?.objectForKey("last_name") as! String
            
            self.firstName = first_name
            self.lastName = last_name
        }
    }
}
