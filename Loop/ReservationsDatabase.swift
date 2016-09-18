//
//  ReservationsDatabase.swift
//  Loop
//
//  Created by Matt Hills on 9/13/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import Foundation
import Firebase

class ReservationsDatabase {
    private var dbRef : FIRDatabaseReference
    private var reservationsRef : FIRDatabaseReference
    
    var requestsIDs = [String]()
    
    init () {
        self.dbRef = FIRDatabase.database().reference()
        self.reservationsRef = dbRef.child("requests_reservations")
    }
    
    func getRequestsIDs(resIDs: [String], completion: (([String] -> Void))) {

        var totalReservationEntries = resIDs.count
        var completionCounter = 0
        
        self.reservationsRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            var requestsArray = [String]()
            
            for var x = 0; x < totalReservationEntries; x++ {
                
                if let status = snapshot.childSnapshotForPath("\(resIDs[x])").value?.objectForKey("status") as? String {
                    
                    if (status == "pending" || status == "declined") {
                        requestsArray.append(resIDs[x])
                    }
                }
                completionCounter++
            }
            
            if (completionCounter == totalReservationEntries) {
                completion(requestsArray)
            }
        }
    }
    
    
    
}
