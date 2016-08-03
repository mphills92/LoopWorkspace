//
//  ChooseDateViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/7/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var chooseDateButton: UIButton!
    @IBOutlet weak var reservationSnapshotView: UIView!
    @IBOutlet weak var bottomButtonHolderView: UIView!
    @IBOutlet weak var selectedCourseNameLabel: UILabel!
    
    // Pass data via segue.
    var selectedCourseNameToSend = String()
    var selectedLocationToSend = String()
    
    // Receive data from segue.
    var selectedCourseNameHasBeenSent: String?
    var selectedLocationHasBeenSent: String?
    
    @IBAction func chooseDateButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toChooseTimeSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose Date"
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        chooseDateButton.layer.cornerRadius = 20
        
        reservationSnapshotView.layer.shadowColor = UIColor.blackColor().CGColor
        reservationSnapshotView.layer.shadowOpacity = 0.25
        reservationSnapshotView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        bottomButtonHolderView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomButtonHolderView.layer.shadowOpacity = 0.25
        bottomButtonHolderView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        selectedCourseNameLabel.text = selectedCourseNameHasBeenSent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension ChooseDateViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toChooseTimeSegue") {
            let destinationVC = segue.destinationViewController as! ChooseTimeViewController
            selectedCourseNameToSend = selectedCourseNameHasBeenSent!
            selectedLocationToSend = selectedLocationHasBeenSent!
            
            destinationVC.selectedCourseNameHasBeenSent = selectedCourseNameToSend
            destinationVC.selectedLocationHasBeenSent = selectedLocationToSend
            print(selectedLocationToSend)

        }
    }
}
