//
//  SessionForCourses.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/29/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class SessionForCourses {
    
    var name: String
    var membershipHistory: Int
    //var backgroundImage: UIImage

    init(name: String, membershipHistory: Int) {
        self.name = name
        self.membershipHistory = membershipHistory
        //self.backgroundImage = backgroundImage
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["Name"] as? String
        let membershipHistory = dictionary["Membership History"] as? Int
        //let backgroundName = dictionary["Background"] as? String
        //let backgroundImage = UIImage(named: backgroundName!)
        self.init(name: name!, membershipHistory: membershipHistory!)
    }
    
}
