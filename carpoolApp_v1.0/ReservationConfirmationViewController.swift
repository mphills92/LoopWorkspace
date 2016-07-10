//
//  ReservationConfirmationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/7/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ReservationConfirmationViewController: UIViewController {
    
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var blackFadedBackground: UIButton!
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: {
            self.blackFadedBackground.alpha = 0
            }, completion: {
                (value: Bool) in
                self.dismissViewControllerAnimated(true, completion: {})
        })
    }
    
    @IBAction func blackFadedBackgroundPressed(sender: AnyObject) {
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: {
            self.blackFadedBackground.alpha = 0
            }, completion: {
                (value: Bool) in
                self.dismissViewControllerAnimated(true, completion: {})
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 22)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        popoverView.layer.cornerRadius = 8
        popoverView.layer.shadowColor = UIColor.blackColor().CGColor
        popoverView.layer.shadowOpacity = 0.5
        popoverView.layer.shadowOffset = CGSizeZero
        popoverView.layer.shadowRadius = 5
        popoverView.layer.shouldRasterize = true
    }
    
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
            self.blackFadedBackground.alpha = 0.2
            }, completion: nil)
    }
}
