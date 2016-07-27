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
    var membershipHistory: String
    var courseLocation: String
    
    //var backgroundImage: UIImage

    init(name: String, membershipHistory: String, courseLocation: String) {
        self.name = name
        self.membershipHistory = membershipHistory
        self.courseLocation = courseLocation
        //self.backgroundImage = backgroundImage
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["Name"] as? String
        let membershipHistory = dictionary["Membership History"] as? String
        let courseLocation = dictionary["Location"] as? String
        //let backgroundName = dictionary["Background"] as? String
        //let backgroundImage = UIImage(named: backgroundName!)
        self.init(name: name!, membershipHistory: membershipHistory!, courseLocation: courseLocation!)
    }
    
}
