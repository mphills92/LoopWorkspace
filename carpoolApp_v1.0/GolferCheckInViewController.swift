//
//  GolferCheckInViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/20/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class GolferCheckInViewController: UIViewController {
    
    @IBOutlet weak var blackBackground: UIButton!
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var checkInButton: UIButton!
    
    let userReferralCode = UserReferralCode()
    
    var textFieldCharactersCount = Int()
    var enteredPromoCode = String()
    var promoCodeIsValid: Bool = true
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func blackBackgroundPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 20)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        //blackBackground.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        
        popoverView.layer.cornerRadius = 8
        popoverView.layer.shadowColor = UIColor.blackColor().CGColor
        popoverView.layer.shadowOpacity = 0.5
        popoverView.layer.shadowOffset = CGSizeZero
        popoverView.layer.shadowRadius = 5
        popoverView.layer.shouldRasterize = true
        
        checkInButton.layer.cornerRadius = 20
    }
}

extension GolferCheckInViewController {
    
    @IBAction func checkInButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("userHasCheckedInSegue", sender: self)
        self.dismissViewControllerAnimated(true, completion: {})
// TODO: Set nextReservation.userHasCheckedInForReservation to 'true' and store in DB.
    }
    
}