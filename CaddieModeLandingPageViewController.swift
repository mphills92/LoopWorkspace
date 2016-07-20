//
//  CaddieModeLandingPageViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class CaddieModeLandingPageViewController: UIViewController {
    
    @IBOutlet weak var dashboardContainer: UIView!
    @IBOutlet weak var upcomingContainer: UIView!
    @IBOutlet weak var alertsContainer: UIView!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var selectedIndex = Int()

    var userName = UserName()
    
    @IBAction func exitViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notifyWithSelectedIndex:", name: "selectedIndexNotification", object: nil)

    }
}

extension CaddieModeLandingPageViewController {
    
    func notifyWithSelectedIndex (notification: NSNotification) {
        selectedIndex = notification.object! as! Int
        
        if (selectedIndex == 0) {
            self.dashboardContainer.hidden = false
            self.upcomingContainer.hidden = true
            self.alertsContainer.hidden = true
        } else if (selectedIndex == 1) {
            self.dashboardContainer.hidden = true
            self.upcomingContainer.hidden = false
            self.alertsContainer.hidden = true
        } else {
            self.dashboardContainer.hidden = true
            self.upcomingContainer.hidden = true
            self.alertsContainer.hidden = false
        }
    }

    
}
