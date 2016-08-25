//
//  FilterResultsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/30/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class FilterResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var sliderBackgroundView: UIView!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceSliderLabel: UILabel!
    @IBOutlet weak var saveFiltersButton: UIButton!
    
    let currentLocation = ["Use current location"]
    
    var selectedIndexPath: NSIndexPath?
    
    var selectedLocationFilter = [String!]()
    
    var regionsAvailable = CitiesAvailable().regions
    var region1 = CitiesAvailable().region1
    var region2 = CitiesAvailable().region2
    
    var selectedCity = String()
    var noCellIsSelected = true
    var selectedDistance = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        sliderBackgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        sliderBackgroundView.layer.shadowOpacity = 0.25
        sliderBackgroundView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        saveFiltersButton.layer.cornerRadius = 20

        //evaluateButtonState()
        
        tableView.estimatedRowHeight = 44
    }
}

extension FilterResultsViewController {
    
    @IBAction func cancelFilterButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func saveFiltersButtonPressed(sender: AnyObject) {
        
        if (noCellIsSelected == false || selectedDistance != 20) {
            NSNotificationCenter.defaultCenter().postNotificationName("userHasSelectedCityFromFilterNotification", object: selectedCity)
            NSNotificationCenter.defaultCenter().postNotificationName("userHasSelectedDistanceFromFilterNotification", object: selectedDistance)
            self.dismissViewControllerAnimated(true, completion: {})
        } else {
            self.dismissViewControllerAnimated(true, completion: {})
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (regionsAvailable.count + 1)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else if (section == 1) {
            return region1.count
        } else if (section == 2) {
            return region2.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return nil
        } else if (section == 1) {
            return regionsAvailable[section - 1]
        } else if (section == 2) {
            return regionsAvailable[section - 1]
        }
        return nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.selectionStyle = .None
        configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if (selectedIndexPath == indexPath) {
            selectedIndexPath = nil
        } else {
            let oldSelectedIndexPath = selectedIndexPath
            selectedIndexPath = indexPath
            
            var previousSelectedCell: UITableViewCell?
            
            if let previousSelectedIndexPath = oldSelectedIndexPath {
                if let previousSelectedCell = tableView.cellForRowAtIndexPath(previousSelectedIndexPath) {
                    configure(previousSelectedCell, forRowAtIndexPath: previousSelectedIndexPath)
                }
            }
        }        
        
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCity = (selectedCell.textLabel?.text)!
        configure(selectedCell, forRowAtIndexPath: indexPath)
        noCellIsSelected = false
        //evaluateButtonState()
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (selectedIndexPath == indexPath) {
            selectedIndexPath = nil
        } else {
            let oldSelectedIndexPath = selectedIndexPath
            selectedIndexPath = indexPath
            
            var previousSelectedCell: UITableViewCell?
            
            if let previousSelectedIndexPath = oldSelectedIndexPath {
                if let previousSelectedCell = tableView.cellForRowAtIndexPath(previousSelectedIndexPath) {
                    configure(previousSelectedCell, forRowAtIndexPath: previousSelectedIndexPath)
                }
            }
        }
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)!
        configure(selectedCell, forRowAtIndexPath: indexPath)
        noCellIsSelected = true
        //evaluateButtonState()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func configure(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.section == 0) {
            cell.textLabel?.text = "Current Location"
        } else if (indexPath.section == 1) {
            cell.textLabel?.text = region1[indexPath.row]
        } else if (indexPath.section == 2) {
            cell.textLabel?.text = region2[indexPath.row]
        }

        if (selectedIndexPath == indexPath) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
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
        selectedDistance = Int(formatted)!
        
        
        /*
        var currentValue = Int(sender.value)
        distanceSlider.setValue((Float((distanceSlider.value + 2.5) / 5) * 5), animated: false)
        distanceSliderLabel.text = "\(currentValue) mi"
        selectedDistance = currentValue
         */
    }
}
