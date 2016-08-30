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
    @IBOutlet weak var segmentedControlBackgroundView: UIView!
    @IBOutlet weak var resultsFilterButtonTopConstraint: NSLayoutConstraint!
    
    // Receive data from segue.
    var userLatitudeHasBeenSent: Double?
    var userLongitudeHasBeenSent: Double?
    
    let gradientLayer = CAGradientLayer()
    
    var upwardScroll = Bool()
    var selectedCity = String()
    var previouslySelectedCity = String()
    var selectedDistance = 20
    var previouslySelectedDistance = Int()
    
    @IBAction func cancelReservationButtonPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSelectedCityFromFilterNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSelectedDistanceFromFilterNotification", object: self.view.window)
        self.dismissViewControllerAnimated(true, completion: {})
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userLatitudeHasBeenSent)
        print(userLongitudeHasBeenSent)
        
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        segmentedControlBackgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        segmentedControlBackgroundView.layer.shadowOpacity = 0.25
        segmentedControlBackgroundView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        resultsFilterButton.layer.cornerRadius = 15
        resultsFilterButton.layer.shadowColor = UIColor.blackColor().CGColor
        resultsFilterButton.layer.shadowOpacity = 0.5
        resultsFilterButton.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        if (previouslySelectedCity == "") {
            previouslySelectedCity = "Current Location"
            previouslySelectedDistance = 20
        } else {
            previouslySelectedCity = selectedCity
            previouslySelectedDistance = selectedDistance
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSwipedContainerNotification", object: self.view.window)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        /*
        if (previouslySelectedCity == "") {
            previouslySelectedCity = "Current Location"
            previouslySelectedDistance = 20
        } else {
            previouslySelectedCity = selectedCity
            previouslySelectedDistance = selectedDistance
        }*/
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userHasSwipedContainer:", name: "userHasSwipedContainerNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectedCityHasChangedFromFilter:", name: "userHasSelectedCityFromFilterNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectedDistanceHasChangedFromFilter:", name: "userHasSelectedDistanceFromFilterNotification", object: nil)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        updateResultsFilterButtonTitle()
    }
}

extension ReservationChooseCourseViewController {
    
    func userHasSwipedContainer(notification: NSNotification) {
        upwardScroll = notification.object! as! Bool
        
        if (upwardScroll == true) {
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.resultsFilterButtonTopConstraint.constant = 0
                self.view.layoutIfNeeded()
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.resultsFilterButtonTopConstraint.constant = 64
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    func selectedCityHasChangedFromFilter(notification: NSNotification) {
        selectedCity = notification.object! as! String
    }
    
    func selectedDistanceHasChangedFromFilter(notification: NSNotification) {
        selectedDistance = notification.object! as! Int
    }
    
    func updateResultsFilterButtonTitle() {
        if (selectedCity != "") {
            resultsFilterButton.setTitle("   Filter by: \(selectedCity) (\(selectedDistance) mi)  ", forState: UIControlState.Normal)
        } else {
            resultsFilterButton.setTitle("   Filter by: \(previouslySelectedCity) (\(selectedDistance) mi)   ", forState: UIControlState.Normal)
        }
    }
}

