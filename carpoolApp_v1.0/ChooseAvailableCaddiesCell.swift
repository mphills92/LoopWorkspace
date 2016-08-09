//
//  TutorialCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 27/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class ChooseAvailableCaddiesCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var caddieNameLabel: UILabel!
    @IBOutlet weak var membershipHistoryLabel: UILabel!
    @IBOutlet weak var roundsHistoryLabel: UILabel!
    @IBOutlet weak var firstRatingImageView: UIImageView!
    @IBOutlet weak var secondRatingImageView: UIImageView!
    @IBOutlet weak var thirdRatingImageView: UIImageView!
    
    var golfKnowledge = Float()
    var golfKnowledgeRatingImage = UIImage()
    var greenReading = Float()
    var greenReadingRatingImage = UIImage()
    var customerSatisfaction = Float()
    var customerSatisfactionRatingImage = UIImage()
    
    var caddiesAvailable: Caddies? {
        didSet {
            if let caddiesAvailable = caddiesAvailable {
                caddieNameLabel.text = caddiesAvailable.name
                membershipHistoryLabel.text = "Member since \(caddiesAvailable.membership)"
                roundsHistoryLabel.text = "\(caddiesAvailable.rounds) rounds caddied"
                
                profileImageView.image = caddiesAvailable.profileImage
                
                profileImageView.layer.cornerRadius = 8
                profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
                profileImageView.layer.borderWidth = 1
                
                golfKnowledge = caddiesAvailable.golfKnowledge
                greenReading = caddiesAvailable.greenReading
                customerSatisfaction = caddiesAvailable.customerSatisfaction
                
                applyFirstRatingImage(golfKnowledge)
                firstRatingImageView.image = golfKnowledgeRatingImage
                
                applySecondRatingImage(greenReading)
                secondRatingImageView.image = greenReadingRatingImage
                
                applyThirdRatingImage(customerSatisfaction)
                thirdRatingImageView.image = customerSatisfactionRatingImage
            }
        }
    }
}

extension ChooseAvailableCaddiesCell {
    
    func applyFirstRatingImage(golfKnowledge: Float) -> UIImage {
        if (golfKnowledge >= 0 && golfKnowledge <= 0.24) {
            golfKnowledgeRatingImage = UIImage(named: "0.0CaddieRatingImage")!
        } else if (golfKnowledge >= 0.25 && golfKnowledge <= 0.74) {
            golfKnowledgeRatingImage = UIImage(named: "0.5CaddieRatingImage")!
        } else if (golfKnowledge >= 0.75 && golfKnowledge < 1.24) {
            golfKnowledgeRatingImage = UIImage(named: "1.0CaddieRatingImage")!
        } else if (golfKnowledge >= 1.25 && golfKnowledge <= 1.74) {
            golfKnowledgeRatingImage = UIImage(named: "1.5CaddieRatingImage")!
        } else if (golfKnowledge >= 1.75 && golfKnowledge <= 2.24) {
            golfKnowledgeRatingImage = UIImage(named: "2.0CaddieRatingImage")!
        } else if (golfKnowledge >= 2.25 && golfKnowledge <= 2.74) {
            golfKnowledgeRatingImage = UIImage(named: "2.5CaddieRatingImage")!
        } else if (golfKnowledge >= 2.75 && golfKnowledge < 3.24) {
            golfKnowledgeRatingImage = UIImage(named: "3.0CaddieRatingImage")!
        } else if (golfKnowledge >= 3.25 && golfKnowledge <= 3.74) {
            golfKnowledgeRatingImage = UIImage(named: "3.5CaddieRatingImage")!
        } else if (golfKnowledge >= 3.75 && golfKnowledge <= 4.24) {
            golfKnowledgeRatingImage = UIImage(named: "4.0CaddieRatingImage")!
        } else if (golfKnowledge > 4.25 && golfKnowledge <= 4.74) {
            golfKnowledgeRatingImage = UIImage(named: "4.5CaddieRatingImage")!
        } else if (golfKnowledge >= 4.75) {
            golfKnowledgeRatingImage = UIImage(named: "5.0CaddieRatingImage")!
        }
        return golfKnowledgeRatingImage
    }
    
    func applySecondRatingImage(greenReading: Float) -> UIImage {
        if (greenReading >= 0 && greenReading <= 0.24) {
            greenReadingRatingImage = UIImage(named: "0.0CaddieRatingImage")!
        } else if (greenReading >= 0.25 && greenReading <= 0.74) {
            greenReadingRatingImage = UIImage(named: "0.5CaddieRatingImage")!
        } else if (greenReading >= 0.75 && greenReading < 1.24) {
            greenReadingRatingImage = UIImage(named: "1.0CaddieRatingImage")!
        } else if (greenReading >= 1.25 && greenReading <= 1.74) {
            greenReadingRatingImage = UIImage(named: "1.5CaddieRatingImage")!
        } else if (greenReading >= 1.75 && greenReading <= 2.24) {
            greenReadingRatingImage = UIImage(named: "2.0CaddieRatingImage")!
        } else if (greenReading >= 2.25 && greenReading <= 2.74) {
            greenReadingRatingImage = UIImage(named: "2.5CaddieRatingImage")!
        } else if (greenReading >= 2.75 && greenReading < 3.24) {
            greenReadingRatingImage = UIImage(named: "3.0CaddieRatingImage")!
        } else if (greenReading >= 3.25 && greenReading <= 3.74) {
            greenReadingRatingImage = UIImage(named: "3.5CaddieRatingImage")!
        } else if (greenReading >= 3.75 && greenReading <= 4.24) {
            greenReadingRatingImage = UIImage(named: "4.0CaddieRatingImage")!
        } else if (greenReading > 4.25 && greenReading <= 4.74) {
            greenReadingRatingImage = UIImage(named: "4.5CaddieRatingImage")!
        } else if (greenReading >= 4.75) {
            greenReadingRatingImage = UIImage(named: "5.0CaddieRatingImage")!
        }
        return greenReadingRatingImage
    }
    
    func applyThirdRatingImage(customerSatisfaction: Float) -> UIImage {
        if (customerSatisfaction >= 0 && customerSatisfaction <= 0.24) {
            customerSatisfactionRatingImage = UIImage(named: "0.0CaddieRatingImage")!
        } else if (customerSatisfaction >= 0.25 && customerSatisfaction <= 0.74) {
            customerSatisfactionRatingImage = UIImage(named: "0.5CaddieRatingImage")!
        } else if (customerSatisfaction >= 0.75 && customerSatisfaction < 1.24) {
            customerSatisfactionRatingImage = UIImage(named: "1.0CaddieRatingImage")!
        } else if (customerSatisfaction >= 1.25 && customerSatisfaction <= 1.74) {
            customerSatisfactionRatingImage = UIImage(named: "1.5CaddieRatingImage")!
        } else if (customerSatisfaction >= 1.75 && customerSatisfaction <= 2.24) {
            customerSatisfactionRatingImage = UIImage(named: "2.0CaddieRatingImage")!
        } else if (customerSatisfaction >= 2.25 && customerSatisfaction <= 2.74) {
            customerSatisfactionRatingImage = UIImage(named: "2.5CaddieRatingImage")!
        } else if (customerSatisfaction >= 2.75 && customerSatisfaction < 3.24) {
            customerSatisfactionRatingImage = UIImage(named: "3.0CaddieRatingImage")!
        } else if (customerSatisfaction >= 3.25 && customerSatisfaction <= 3.74) {
            customerSatisfactionRatingImage = UIImage(named: "3.5CaddieRatingImage")!
        } else if (customerSatisfaction >= 3.75 && customerSatisfaction <= 4.24) {
            customerSatisfactionRatingImage = UIImage(named: "4.0CaddieRatingImage")!
        } else if (customerSatisfaction > 4.25 && customerSatisfaction <= 4.74) {
            customerSatisfactionRatingImage = UIImage(named: "4.5CaddieRatingImage")!
        } else if (customerSatisfaction >= 4.75) {
            customerSatisfactionRatingImage = UIImage(named: "5.0CaddieRatingImage")!
        }
        return customerSatisfactionRatingImage
    }

}
