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
    

    var citiesAvailable = CitiesAvailable().cities
    
    var aCellIsSelected = false
    var selectedCity = [String!]()
    var currentLocationCellShowsCheckmark = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        saveFiltersButton.layer.cornerRadius = 20
        
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
        tableView.allowsMultipleSelection = false
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
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesAvailable.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.font = UIFont(name: "AvenirNext-Regular", size: 17)
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = "Use current location"
            cell.textLabel?.textColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        } else {
            cell.textLabel?.text = citiesAvailable[indexPath.row - 1]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        if (aCellIsSelected == false) {
                tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
                let selectedCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
                aCellIsSelected = true
        } else {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
            selectedCity.removeAll()
            let selectedCell = 0
            aCellIsSelected = false
        }
        print(aCellIsSelected)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        if aCellIsSelected == true {
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
            selectedCity.removeAll()
            
            aCellIsSelected = false
        } else {}
    }
    
    @IBAction func distanceSliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        distanceSliderLabel.text = "\(currentValue) mi"
    }
}
