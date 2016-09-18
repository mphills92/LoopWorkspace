//
//  CaddiesDatabase.swift
//  Loop
//
//  Created by Matt Hills on 9/9/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import Foundation
import Firebase

class CaddieDatabase {
    private var dbRef : FIRDatabaseReference
    private var caddiesRef : FIRDatabaseReference
    
    var firstName = String()
    var lastName = String()
    
    init() {
        self.dbRef = FIRDatabase.database().reference()
        self.caddiesRef = dbRef.child("caddies")
    }
    
    /*func getCaddieInformation(caddieID: String, completion: ((Bool -> Void))) {
        
        self.caddiesNodeRef.child("\(caddieID)").observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            let first_name = snapshot.value?.objectForKey("first_name") as! String
            
            self.firstName = first_name
        }
    }*/
}
