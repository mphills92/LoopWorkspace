//
//  CaddieModeLandingPageViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class CaddieModeLandingPageViewController: UIViewController {
    
    @IBAction func exitViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}
