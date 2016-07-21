//
//  GolferCurrentReservationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/20/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class GolferCurrentReservationViewController: UIViewController {
    
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var blackFadedBackground: UIButton!
    @IBOutlet weak var closeViewBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var navigationBarTitle: UILabel!
    @IBOutlet weak var reservationCompletedButton: UIButton!
    @IBOutlet weak var checkInForReservationButton: UIButton!
    @IBOutlet weak var reservationInProgressContainer: UIView!
    @IBOutlet weak var checkInForReservationContainer: UIView!
    
    var nextReservation = NextReservation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseCorrectContainerToDisplay()

        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        popoverView.layer.shadowColor = UIColor.blackColor().CGColor
        popoverView.layer.shadowOpacity = 0.5
        popoverView.layer.shadowOffset = CGSizeZero
        popoverView.layer.shadowRadius = 5
        popoverView.layer.shouldRasterize = true
        
        reservationCompletedButton.layer.borderColor = UIColor.whiteColor().CGColor
        reservationCompletedButton.layer.borderWidth = 1
        
        reservationCompletedButton.layer.cornerRadius = 20
        checkInForReservationButton.layer.cornerRadius = 20
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
            self.blackFadedBackground.alpha = 0.2
            }, completion: nil)
    }
}

extension GolferCurrentReservationViewController {
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
    @IBAction func blackFadedBackgroundButtonPressed(sender: AnyObject) {
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: {
            self.blackFadedBackground.alpha = 0
            }, completion: {
                (value: Bool) in
                self.dismissViewControllerAnimated(true, completion: {})
        })
    }
    
    @IBAction func checkInForReservationButtonPressed(sender: AnyObject) {
        checkInForReservationContainer.hidden = true
        reservationInProgressContainer.hidden = false
        checkInForReservationButton.hidden = true
        reservationCompletedButton.hidden = false
        activeDisplayStyle()
// TODO: Set nextReservation.userHasCheckedInForReservation to 'true' and store in DB.
    }
    
    
    @IBAction func reservationCompleteButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("toReviewCaddieSegue", sender: self)
    }
    
    func chooseCorrectContainerToDisplay() {
        if (nextReservation.userHasCheckedInForNextReservation == false) {
            checkInForReservationContainer.hidden = false
            reservationInProgressContainer.hidden = true
            checkInForReservationButton.hidden = false
            reservationCompletedButton.hidden = true
            passiveDisplayStyle()
        } else if (nextReservation.userHasCheckedInForNextReservation == true) {
            checkInForReservationContainer.hidden = true
            reservationInProgressContainer.hidden = false
            checkInForReservationButton.hidden = true
            reservationCompletedButton.hidden = false
            activeDisplayStyle()
        }
    }
    
    func passiveDisplayStyle() {
        navigationBarTitle.text = "Check In"
        navigationBarTitle.textColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        //navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationBar.barTintColor = UIColor.whiteColor()
        popoverView.backgroundColor = UIColor.whiteColor()
        closeViewBarButtonItem.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
    }
    
    func activeDisplayStyle() {
        navigationBarTitle.text = "Round In Progress"
        navigationBarTitle.textColor = UIColor.whiteColor()
        //navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBar.barTintColor = UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1.0)
        popoverView.backgroundColor = UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1.0)
        closeViewBarButtonItem.tintColor = UIColor.whiteColor()
    }
}
