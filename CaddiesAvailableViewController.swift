//
//  CaddiesAvailableViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/8/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class CaddiesAvailableViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var reservationSnapshotView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Available Caddies"
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        reservationSnapshotView.layer.shadowColor = UIColor.blackColor().CGColor
        reservationSnapshotView.layer.shadowOpacity = 0.25
        reservationSnapshotView.layer.shadowOffset = CGSizeMake(0.0, 0.0)

        containerView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

