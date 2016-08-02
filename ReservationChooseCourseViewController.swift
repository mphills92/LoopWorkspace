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
    @IBOutlet weak var resultsFilterButtonBottomConstraint: NSLayoutConstraint!
    
    let gradientLayer = CAGradientLayer()
    
    var upwardScroll = Bool()
    
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
        
        resultsFilterButton.layer.cornerRadius = 17
        resultsFilterButton.layer.shadowColor = UIColor.blackColor().CGColor
        resultsFilterButton.layer.shadowOpacity = 0.5
        resultsFilterButton.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        

    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSwipedContainerNotification", object: self.view.window)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userHasSwipedContainer:", name: "userHasSwipedContainerNotification", object: nil)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension ReservationChooseCourseViewController {
    func userHasSwipedContainer(notification: NSNotification) {
        upwardScroll = notification.object! as! Bool
        
        if (upwardScroll == true) {
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.resultsFilterButtonBottomConstraint.constant = -80
                self.view.layoutIfNeeded()
                }, completion: nil)


        } else {
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.resultsFilterButtonBottomConstraint.constant = 37
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
}

