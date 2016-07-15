//
//  ChooseDateViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/7/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController {
    
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toChooseTimeSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0), NSFontAttributeName: UIFont.systemFontOfSize(20, weight: UIFontWeightRegular)]
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        popoverView.layer.shadowColor = UIColor.blackColor().CGColor
        popoverView.layer.shadowOpacity = 0.5
        popoverView.layer.shadowOffset = CGSizeZero
        popoverView.layer.shadowRadius = 5
        popoverView.layer.shouldRasterize = true
        
        nextButton.layer.cornerRadius = 20
        
    }
}
