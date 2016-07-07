//
//  ContainerChooseCaddieViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/2/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerChooseCaddieViewController: UITableViewController {
    
    // Dummy data.
    var caddiesFound = true
    
    var currentRow = Int()
    var aCellIsExpanded = false
    
    let caddiesAvailable = Caddies.caddiesAvailable()
    
    @IBAction func reserveButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("caddieSelectedSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(-28, 0, -28, 0)
    }
}

extension ContainerChooseCaddieViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (caddiesFound == true) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "No caddies found that match your criteria."
            noDataLabel.textColor = UIColor.darkGrayColor()
            noDataLabel.textAlignment = NSTextAlignment.Center
            tableView.backgroundView = noDataLabel
            tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return numOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caddiesAvailable.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ChooseAvailableCaddiesCell
        
        cell.caddiesAvailable = caddiesAvailable[indexPath.item]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentRow = indexPath.row
        selectedCellIndex()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (aCellIsExpanded == true) {
            if (currentRow == indexPath.row) {
                return 170
            }
        } else {
            return 100
        }
        return 100
    }
    
    func selectedCellIndex() {
        if (aCellIsExpanded == false) {
            aCellIsExpanded = true
        } else {
            aCellIsExpanded = false
        }
    }
}
