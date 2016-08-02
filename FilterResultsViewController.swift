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
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceSliderLabel: UILabel!
    @IBOutlet weak var saveFiltersButton: UIButton!
    
    let currentLocation = ["Use current location"]
    
    var regionsAvailable = CitiesAvailable().regions
    var region1 = CitiesAvailable().region1
    var region2 = CitiesAvailable().region2
    
    var aCellIsSelected = false
    var selectedCity = [String!]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        saveFiltersButton.layer.cornerRadius = 20
        
        //tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
        tableView.allowsMultipleSelection = false
        tableView.estimatedRowHeight = 44
    }
}

extension FilterResultsViewController {
    
    @IBAction func cancelFilterButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func saveFiltersButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
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
        
        cell.textLabel?.font = UIFont(name: "AvenirNext-Regular", size: 17)
        
        if (indexPath.section == 0) {
            cell.textLabel?.text = "Use current location"
        } else if (indexPath.section == 1) {
            cell.textLabel?.text = region1[indexPath.row]
        } else if (indexPath.section == 2) {
            cell.textLabel?.text = region2[indexPath.row]
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var selectedCell = UITableViewCell()
        
        if (aCellIsSelected == false) {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
            //selectedCity.append(potentialTravelers.nearbyFriendsForTravel[indexPath.row] as NSString as String)
            aCellIsSelected = true
        } else if (aCellIsSelected == true) {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
            selectedCell = UITableViewCell()
            aCellIsSelected = false
        }
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if (aCellIsSelected == true) {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
            selectedCity.removeAll()
            aCellIsSelected = false
        } else {}
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func distanceSliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        distanceSliderLabel.text = "\(currentValue) mi"
    }
}
