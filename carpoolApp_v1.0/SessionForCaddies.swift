//
//  Session.swift
//  RWDevCon
//
//  Created by Mic Pringle on 02/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
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
    
    /*
  init(title: String, speaker: String, room: String, time: String, backgroundImage: UIImage) {
    self.title = title
    self.speaker = speaker
    self.room = room
    self.time = time
    self.backgroundImage = backgroundImage
  }
  
  convenience init(dictionary: NSDictionary) {
    let title = dictionary["Title"] as? String
    let speaker = dictionary["Speaker"] as? String
    let room = dictionary["Room"] as? String
    let time = dictionary["Time"] as? String
    let backgroundName = dictionary["Background"] as? String
    //let backgroundImage = UIImage(named: backgroundName!)
    self.init(title: title!, speaker: speaker!, room: room!, time: time!, backgroundImage: backgroundImage!.decompressedImage)
  }*/
    
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
