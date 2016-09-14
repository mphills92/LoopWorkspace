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
    
    init () {
        self.dbRef = FIRDatabase.database().reference()
        self.reservationsRef = dbRef.child("reservations_table")
    }
    
    func getReservationInformation(reservationIDs: [String], completion: ((Bool -> Void))) {
        
        self.reservationsRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            for var i = 0; i < reservationIDs.count; i++ {
                if let caddie = snapshot.childSnapshotForPath("\(reservationIDs[i])").value?.objectForKey("caddie") as? String {
                }
            }
            
        }
    }
}
