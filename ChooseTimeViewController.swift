//
//  ChooseTimeViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/14/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChooseTimeViewController: UIViewController {
    
    @IBOutlet weak var searchCaddiesButton: UIButton!
    @IBOutlet weak var chooseTimePicker: UIDatePicker!
    @IBOutlet weak var pickerBackgroundView: UIView!
    @IBOutlet weak var reservationSnapshotView: UIView!
    @IBOutlet weak var bottomButtonHolderView: UIView!
    
    var selectedDate = NSDate()
    var dateFormatter = NSDateFormatter()
    
    let timeComponents = NSCalendar.currentCalendar().componentsInTimeZone(NSTimeZone.localTimeZone(), fromDate: NSDate())

    @IBAction func searchAvailableCaddiesButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toChooseCaddieSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose Time"
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        reservationSnapshotView.layer.shadowColor = UIColor.blackColor().CGColor
        reservationSnapshotView.layer.shadowOpacity = 0.25
        reservationSnapshotView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        bottomButtonHolderView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomButtonHolderView.layer.shadowOpacity = 0.25
        bottomButtonHolderView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        pickerBackgroundView.layer.cornerRadius = 8
        pickerBackgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        pickerBackgroundView.layer.shadowOpacity = 0.5
        pickerBackgroundView.layer.shadowOffset = CGSizeZero
        pickerBackgroundView.layer.shadowRadius = 5

        searchCaddiesButton.layer.cornerRadius = 20
        
        chooseTimePicker.addTarget(self, action: "timeChangedValue:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension ChooseTimeViewController {
    
    func timeChangedValue(date: NSDate) {
        selectedDate = chooseTimePicker.date
        //dateFormatter.dateFormat = "HH:mm a"
        dateFormatter.timeStyle = .ShortStyle
        let convertedTime = dateFormatter.stringFromDate(selectedDate)
        print (convertedTime)
    }
    
    
}