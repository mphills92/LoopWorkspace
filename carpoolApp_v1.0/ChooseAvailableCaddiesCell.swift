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
    @IBOutlet weak var detailsDisclosureIndicator: UIImageView!
    @IBOutlet weak var detailsButton: UIButton!
    
    var caddiesAvailable: Caddies? {
        didSet {
            if let caddiesAvailable = caddiesAvailable {
                caddieNameLabel.text = caddiesAvailable.name
                membershipHistoryLabel.text = "Member since \(caddiesAvailable.membership)"
                roundsHistoryLabel.text = "\(caddiesAvailable.rounds) rounds caddied"
                //detailsButton.layer.cornerRadius = 12
                //detailsButton.layer.borderColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0).CGColor
                //detailsButton.layer.borderWidth = 1
                
                profileImageView.layer.cornerRadius = 8
            }
        }
    }
}
