//
//  Inspiration.swift
//  RWDevCon
//
//  Created by Mic Pringle on 02/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class Caddies: Session {
    class func caddiesAvailable()  -> [Caddies] {
        var caddiesList = [Caddies]()
        if let URL = NSBundle.mainBundle().URLForResource("CaddiesList", withExtension: "plist") {
            if let tutorialsFromPlist = NSArray(contentsOfURL: URL) {
                for dictionary in tutorialsFromPlist {
                    let caddiesListed = Caddies(dictionary: dictionary as! NSDictionary)
                    caddiesList.append(caddiesListed)
                }
            }
        }
        return caddiesList
    }
  
}

class Courses: SessionForCourses {
    class func coursesAvailable()  -> [Courses] {
        var coursesList = [Courses]()
        if let URL = NSBundle.mainBundle().URLForResource("GolfCourseList", withExtension: "plist") {
            if let tutorialsFromPlist = NSArray(contentsOfURL: URL) {
                for dictionary in tutorialsFromPlist {
                    let coursesListed = Courses(dictionary: dictionary as! NSDictionary)
                    coursesList.append(coursesListed)
                }
            }
        }
        return coursesList
    }
    
}
