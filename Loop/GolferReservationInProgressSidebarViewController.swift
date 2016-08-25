//
//  GolferReservationInProgressSidebarViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/22/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class GolferReservationInProgressSidebarViewController: UIViewController {
    
    @IBOutlet weak var reservationSnapshotView: UIView!
    @IBOutlet weak var reservationCompleteButton: UIButton!
    @IBOutlet weak var bottomButtonHolderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        bottomButtonHolderView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomButtonHolderView.layer.shadowOpacity = 0.25
        bottomButtonHolderView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        reservationSnapshotView.layer.shadowColor = UIColor.blackColor().CGColor
        reservationSnapshotView.layer.shadowOpacity = 0.25
        reservationSnapshotView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        reservationCompleteButton.layer.cornerRadius = 20
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

extension GolferReservationInProgressSidebarViewController {
    
    @IBAction func reservationCompleteButtonPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("reservationHasCompletedNotification", object: true)
        
        performSegueWithIdentifier("toReviewCaddieSegue", sender: self)
    }
    
}
