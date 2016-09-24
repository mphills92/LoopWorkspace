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
    @IBOutlet weak var segmentedControlView: ChooseCourseSegmentedControl!
    @IBOutlet weak var eventBannerView: UIView!
    @IBOutlet weak var resultsFilterButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sliderBackgroundView: UIView!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceSliderLabel: UILabel!
    @IBOutlet weak var sliderDisplayBlackButton: UIButton!
    
    // Receive data from segue.
    var senderTag: Int?
    var userLatitudeHasBeenSent: Double?
    var userLongitudeHasBeenSent: Double?
    
    // Empty variables to be populated in order to execute getBasicInfoForGolfCoursesInRadius.
    var setPointLat = Double()
    var setPointLon = Double()
    var searchRadiusFromSetPoint = Double()

    var screenSize = UIScreen.mainScreen().bounds
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let activityIndicatorBackground = UIView()
    
    let gradientLayer = CAGradientLayer()
    
    var upwardScroll = Bool()
    var selectedCity = String()
    var previouslySelectedCity = String()
    var currentSearchRadius = Double()
    var newSearchRadius = Double()
    var previouslySelectedDistance = Int()
    
    /*
    @IBAction func cancelReservationButtonPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSelectedCityFromFilterNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSelectedDistanceFromFilterNotification", object: self.view.window)
        self.dismissViewControllerAnimated(true, completion: {})
        
    }*/

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userHasSwipedContainer:", name: "userHasSwipedContainerNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectedCityHasChangedFromFilter:", name: "userHasSelectedCityFromFilterNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectedDistanceHasChangedFromFilter:", name: "userHasSelectedDistanceFromFilterNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "startActivityIndicator:", name: "startActivityIndicatorNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopActivityIndicator:", name: "stopActivityIndicatorNotification", object: nil)
        
        activityIndicator.center = CGPointMake(self.screenSize.width / 2, self.screenSize.height / 2)
        activityIndicatorBackground.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.25)
        activityIndicatorBackground.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height)
        activityIndicatorBackground.hidden = true
        self.containerView!.addSubview(activityIndicatorBackground)
        self.containerView!.addSubview(activityIndicator)
        
        let dismissViewButton = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: "dismissView")
        self.navigationItem.leftBarButtonItem = dismissViewButton
        self.navigationItem.leftBarButtonItem?.enabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        segmentedControlBackgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        segmentedControlBackgroundView.layer.shadowOpacity = 0.25
        segmentedControlBackgroundView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        sliderBackgroundView.hidden = true
        sliderDisplayBlackButton.hidden = true
        navigationItem.rightBarButtonItem?.image = UIImage(named: "IconRadiusUnfilled")
        navigationItem.rightBarButtonItem?.tintColor = UIColor.clearColor()
        
        setPointLat = userLatitudeHasBeenSent!
        setPointLon = userLongitudeHasBeenSent!
        
        currentSearchRadius = 20.0
        formatSearchRadius()
        
        if (senderTag == 1) {
            segmentedControlView.hidden = false
            eventBannerView.hidden = true
        } else if (senderTag == 2) {
            segmentedControlView.hidden = true
            eventBannerView.hidden = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("setPointLatNotification", object: setPointLat)
        NSNotificationCenter.defaultCenter().postNotificationName("setPointLonNotification", object: setPointLon)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "userHasSwipedContainerNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "startActivityIndicatorNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "stopActivityIndicatorNotification", object: self.view.window)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}


extension ReservationChooseCourseViewController {
    
    @IBAction func changeDistanceValueButtonPressed(sender: UIBarButtonItem) {
        if (sliderBackgroundView.hidden == true) {
            displaySlider()
        } else if (sliderBackgroundView.hidden == false) {
            cancelSlider()
        }
    }
    
    @IBAction func sliderDisplayBlackButtonPressed(sender: AnyObject) {
        cancelSlider()
    }

    @IBAction func distanceSliderValueChanged(sender: UISlider) {
        var increment: Float = 5
        var newValue: Float = sender.value / increment
        sender.value = floor(newValue) * increment
        
        var formatted: String {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            formatter.minimumFractionDigits = 0
            return formatter.stringFromNumber(sender.value) ?? ""
        }
        
        distanceSliderLabel.text  = "\(formatted) mi"
        newSearchRadius = Double(formatted)!
    }
    
    func formatSearchRadius() {
        var formatted: String {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            formatter.minimumFractionDigits = 0
            return formatter.stringFromNumber(currentSearchRadius) ?? ""
        }
        
        distanceSliderLabel.text  = "\(formatted) mi"
        currentSearchRadius = Double(formatted)!
        distanceSlider.value = Float(formatted)!
    }
    
    func dismissView() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func displaySlider() {
        sliderBackgroundView.hidden = false
        sliderDisplayBlackButton.hidden = false
        navigationItem.title = "Change Distance"
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelSlider")
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.leftBarButtonItem?.enabled = true
        
        let saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "saveSlider")
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    func cancelSlider() {
        sliderBackgroundView.hidden = true
        sliderDisplayBlackButton.hidden = true
        navigationItem.title = "Choose Course"
        
        let dismissViewButton = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: "dismissView")
        self.navigationItem.leftBarButtonItem = dismissViewButton
        self.navigationItem.leftBarButtonItem?.enabled = true
        
        let showSliderButton = UIBarButtonItem(image: UIImage(named:"IconRadiusUnfilled"), style: .Plain, target: self, action: "displaySlider")
        self.navigationItem.rightBarButtonItem = showSliderButton
        self.navigationItem.rightBarButtonItem?.enabled = true
        
        formatSearchRadius()
    }
    
    func saveSlider() {
        sliderBackgroundView.hidden = true
        sliderDisplayBlackButton.hidden = true
        navigationItem.title = "Choose Course"
        
        let dismissViewButton = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: "dismissView")
        self.navigationItem.leftBarButtonItem = dismissViewButton
        self.navigationItem.leftBarButtonItem?.enabled = true
        
        let showSliderButton = UIBarButtonItem(image: UIImage(named:"IconRadiusUnfilled"), style: .Plain, target: self, action: "displaySlider")
        self.navigationItem.rightBarButtonItem = showSliderButton
        self.navigationItem.rightBarButtonItem?.enabled = true
        
        currentSearchRadius = newSearchRadius
        NSNotificationCenter.defaultCenter().postNotificationName("newSearchRadiusNotification", object: currentSearchRadius)
    }
    
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
    
    func startActivityIndicator(notification: NSNotification) {
        activityIndicator.startAnimating()
        activityIndicatorBackground.hidden = false
    }
    
    func stopActivityIndicator(notification: NSNotification) {
        self.activityIndicator.stopAnimating()
        self.activityIndicatorBackground.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "containerCoursesAvailable") {
            let destinationVC = segue.destinationViewController as! ContainerReservationChooseCourseViewController
            destinationVC.reservationTypeToSend = senderTag
        }
    }
}

