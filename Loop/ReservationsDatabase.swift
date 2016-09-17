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
    
    func getRequestsIDs(reservationIDs: [String], completion: (([String] -> Void))) {
        
        var totalReservationEntries = reservationIDs.count
        var completionCounter = 0
        
        self.reservationsRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            var requestsArray = [String]()
            
            for var x = 0; x < totalReservationEntries; x++ {
                if let pendingStatus = snapshot.childSnapshotForPath("\(reservationIDs[x])").value?.objectForKey("pending") as? Bool {
                    
                    if (pendingStatus == true) {
                        requestsArray.append(reservationIDs[x])
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
