//
//  SessionForCaddies.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//


import UIKit

class SessionForCaddies {
 
    var name: String
    var rounds: Int
    var membership: String
    var handicap: Float
    var golfKnowledge: Float
    var greenReading: Float
    var customerSatisfaction: Float
    var profileImage: UIImage
  
    /*
  var roomAndTime: String {
    get {
      return "\(time) • \(room)"
    }
  }
 */
  
    init(name: String, rounds: Int, membership: String, handicap: Float, golfKnowledge: Float, greenReading: Float, customerSatisfaction: Float, profileImage: UIImage) {
        self.name = name
        self.rounds = rounds
        self.membership = membership
        self.handicap = handicap
        self.golfKnowledge = golfKnowledge
        self.greenReading = greenReading
        self.customerSatisfaction = customerSatisfaction
        self.profileImage = profileImage
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["Name"] as? String
        let rounds = dictionary["Rounds"] as? Int
        let membership = dictionary["Membership"] as? String
        let handicap = dictionary["Handicap"] as? Float
        let golfKnowledge = dictionary["Golf Knowledge"] as? Float
        let greenReading = dictionary["Green Reading"] as? Float
        let customerSatisfaction = dictionary["Customer Satisfaction"] as? Float
        let profileImageName = dictionary["Caddie Placeholder Image"] as? String
        let profileImage = UIImage(named: profileImageName!)
        self.init(name: name!, rounds: rounds!, membership: membership!, handicap: handicap!, golfKnowledge: golfKnowledge!, greenReading: greenReading!, customerSatisfaction: customerSatisfaction!, profileImage: profileImage!)
    }

}
