//
//  GolferCheckInViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/20/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class GolferCheckInViewController: UIViewController {

    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var bottomButtonHolderView: UIView!
    
    let userReferralCode = UserReferralCode()
    
    var textFieldCharactersCount = Int()
    var enteredPromoCode = String()
    var promoCodeIsValid: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        bottomButtonHolderView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomButtonHolderView.layer.shadowOpacity = 0.25
        bottomButtonHolderView.layer.shadowOffset = CGSizeMake(0.0, 0.0)

        checkInButton.layer.cornerRadius = 20
    }
}

extension GolferCheckInViewController {
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})    
    }
    
    
    @IBAction func checkInButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
// TODO: Set nextReservation.userHasCheckedInForReservation to 'true' and store in DB.
    }
    
}