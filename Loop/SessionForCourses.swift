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
    var street: String
    var city: String
    var zip: String
    var operatingHoursOpen: String
    var operatingHoursClose: String
    var price: String
    var description: String
    var facilitiesHighlight1: String
    var facilitiesHighlight2: String
    var facilitiesHighlight3: String
    var amenitiesHighlight1: String
    var amenitiesHighlight2: String
    var amenitiesHighlight3: String
    //var mapViewImage: UIImage
    var offer1: String
    var offer2: String
    var offer3: String
    
    //var backgroundImage: UIImage

    init(name: String,
         membershipHistory: String,
         street: String,
         city: String,
         zip: String,
         operatingHoursOpen: String,
         operatingHoursClose: String,
         price: String,
         description: String,
         facilitiesHighlight1: String,
         facilitiesHighlight2: String,
         facilitiesHighlight3: String,
         amenitiesHighlight1: String,
         amenitiesHighlight2: String,
         amenitiesHighlight3: String,
         //mapViewImage: UIImage,
         offer1: String,
         offer2: String,
         offer3: String) {

            self.name = name
            self.membershipHistory = membershipHistory
            self.street = street
            self.city = city
            self.zip = zip
            self.operatingHoursOpen = operatingHoursOpen
            self.operatingHoursClose = operatingHoursClose
            self.price = price
            self.description = description
            self.facilitiesHighlight1 = facilitiesHighlight1
            self.facilitiesHighlight2 = facilitiesHighlight2
            self.facilitiesHighlight3 = facilitiesHighlight3
            self.amenitiesHighlight1 = amenitiesHighlight1
            self.amenitiesHighlight2 = amenitiesHighlight2
            self.amenitiesHighlight3 = amenitiesHighlight3
            //self.mapViewImage = mapViewImage
            self.offer1 = offer1
            self.offer2 = offer2
            self.offer3 = offer3
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["Name"] as? String
        let membershipHistory = dictionary["Membership_History"] as? String
        let street = dictionary["Street"] as? String
        let city = dictionary["City"] as? String
        let zip = dictionary["Zip"] as? String
        let operatingHoursOpen = dictionary["Operating_Hours_Open"] as? String
        let operatingHoursClose = dictionary["Operating_Hours_Close"] as? String
        let price = dictionary["Price"] as? String
        let description = dictionary["Description"] as? String
        let facilitiesHighlight1 = dictionary["Facilities_Highlight_1"] as? String
        let facilitiesHighlight2 = dictionary["Facilities_Highlight_2"] as? String
        let facilitiesHighlight3 = dictionary["Facilities_Highlight_3"] as? String
        let amenitiesHighlight1 = dictionary["Amenities_Highlight_1"] as? String
        let amenitiesHighlight2 = dictionary["Amenities_Highlight_2"] as? String
        let amenitiesHighlight3 = dictionary["Amenities_Highlight_3"] as? String
        //let mapViewImageName = dictionary["Map_View_Image"] as? String
        //let mapViewImage = UIImage(named: mapViewImageName!)
        let offer1 = dictionary["Offer_1"] as? String
        let offer2 = dictionary["Offer_2"] as? String
        let offer3 = dictionary["Offer_3"] as? String

        self.init(name: name!,
                  membershipHistory: membershipHistory!,
                  street: street!,
                  city: city!,
                  zip: zip!,
                  operatingHoursOpen: operatingHoursOpen!,
                  operatingHoursClose: operatingHoursClose!,
                  price: price!,
                  description: description!,
                  facilitiesHighlight1: facilitiesHighlight1!,
                  facilitiesHighlight2: facilitiesHighlight2!,
                  facilitiesHighlight3: facilitiesHighlight3!,
                  amenitiesHighlight1: amenitiesHighlight1!,
                  amenitiesHighlight2: amenitiesHighlight2!,
                  amenitiesHighlight3: amenitiesHighlight3!,
                  //mapViewImage: mapViewImage!,
                  offer1: offer1!,
                  offer2: offer2!,
                  offer3: offer3!)
    }
    
}
