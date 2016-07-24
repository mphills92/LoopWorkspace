//
//  GolferReservationInProgressSidebarViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/22/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class GolferReservationInProgressSidebarViewController: UIViewController {
    
    @IBOutlet weak var reservationCompleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        reservationCompleteButton.layer.cornerRadius = 20
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

extension GolferReservationInProgressSidebarViewController {
    
    @IBAction func reservationCompleteButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toReviewCaddieSegue", sender: self)
    }
    
}
