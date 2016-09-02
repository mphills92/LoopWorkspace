//
//  CourseOffersViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/13/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase

class CourseOffersViewController: UIViewController {
    
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    
    var detailedInformation = [String]()
    
    var informationHasBeenCached = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (informationHasBeenCached == false) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "extractDetailedInformation:", name: "passDetailedInfoPage3Notification", object: nil)
            NSNotificationCenter.defaultCenter().postNotificationName("requestDetailedInformationNotification", object: nil)
            informationHasBeenCached = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBackgroundView.layer.cornerRadius = 8
        topBackgroundView.alpha = 0.5
        bottomBackgroundView.layer.cornerRadius = 8
        bottomBackgroundView.alpha = 0.5

    }
}

extension CourseOffersViewController {
    
    func extractDetailedInformation(notification: NSNotification) {
        detailedInformation = notification.object! as! [String]
        print("course offers: \(detailedInformation)")
        
    }
}
