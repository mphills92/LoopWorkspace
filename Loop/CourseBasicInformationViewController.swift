//
//  CourseBasicInformationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/12/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase

class CourseBasicInformationViewController: UIViewController {
    
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var informationBackgroundView: UIView!
    @IBOutlet weak var membershipHistoryLabel: UILabel!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityStateZipLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var detailedInformation = [String]()
    
    var informationHasBeenCached = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (informationHasBeenCached == false) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "extractDetailedInformation:", name: "passDetailedInfoPage1Notification", object: nil)
            informationHasBeenCached = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBackgroundView.layer.cornerRadius = 8
        topBackgroundView.alpha = 0.5
        informationBackgroundView.layer.cornerRadius = 8
        informationBackgroundView.alpha = 0.5
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension CourseBasicInformationViewController {
    
    func extractDetailedInformation(notification: NSNotification) {
        detailedInformation = notification.object! as! [String]
        
        var streetAddress = detailedInformation[0]
        streetAddressLabel.text = streetAddress
        
        var cityStateZip = "\(detailedInformation[1])  \(detailedInformation[2])"
        cityStateZipLabel.text = cityStateZip
        
        var membershipHistory = detailedInformation[3]
        membershipHistoryLabel.text = "Member since \(membershipHistory)"
        
        var courseDescription = detailedInformation[4]
        descriptionLabel.text = courseDescription
    }
}
