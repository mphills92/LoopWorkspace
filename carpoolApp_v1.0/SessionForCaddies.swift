//
//  SessionForCaddies.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//


import UIKit

class SessionForCaddies {
 
    /*
  var title: String
  var speaker: String
  var room: String
  var time: String
  var backgroundImage: UIImage
 */
    
    var name: String
    var rounds: Int
    var membership: String
    var handicap: Float
    //var backgroundImage: UIImage
  
    /*
  var roomAndTime: String {
    get {
      return "\(time) • \(room)"
    }
  }
 */
  
    init(name: String, rounds: Int, membership: String, handicap: Float) {
        self.name = name
        self.rounds = rounds
        self.membership = membership
        self.handicap = handicap
        //self.backgroundImage = backgroundImage
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["Name"] as? String
        let rounds = dictionary["Rounds"] as? Int
        let membership = dictionary["Membership"] as? String
        let handicap = dictionary["Handicap"] as? Float
        //let backgroundName = dictionary["Background"] as? String
        //let backgroundImage = UIImage(named: backgroundName!)
        self.init(name: name!, rounds: rounds!, membership: membership!, handicap: handicap!)
    }

}
