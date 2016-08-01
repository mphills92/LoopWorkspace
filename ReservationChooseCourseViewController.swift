//
//  ReservationChooseCourseViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/29/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ReservationChooseCourseViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var resultsFilterButton: UIButton!
    
    let gradientLayer = CAGradientLayer()
    
    @IBAction func cancelReservationButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        resultsFilterButton.layer.cornerRadius = 15
        resultsFilterButton.layer.shadowColor = UIColor.blackColor().CGColor
        resultsFilterButton.layer.shadowOpacity = 0.5
        resultsFilterButton.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

