//
//  ChooseTimeViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/14/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChooseTimeViewController: UIViewController {
    
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchCaddiesButton: UIButton!
    @IBOutlet weak var chooseTimePicker: UIDatePicker!
    
    var selectedDate = NSDate()
    var dateFormatter = NSDateFormatter()
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func searchAvailableCaddiesButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("toChooseCaddieSegue", sender: self)
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

        searchCaddiesButton.layer.cornerRadius = 20 //findAvailableCaddiesButton.bounds.height / 2
        
        self.chooseTimePicker.setValue(UIColor.whiteColor(), forKey: "textColor")
        chooseTimePicker.addTarget(self, action: "timeChangedValue:", forControlEvents: UIControlEvents.ValueChanged)
        
    }
}

extension ChooseTimeViewController {
    
    func timeChangedValue(date: NSDate) {
        selectedDate = chooseTimePicker.date
        dateFormatter.dateFormat = "HH:mm a"
        let convertedTime = dateFormatter.stringFromDate(selectedDate)
    }
}