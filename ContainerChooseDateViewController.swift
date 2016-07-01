//
//  ContainerChooseDateViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/30/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerChooseDateViewController: UITableViewController {
    
    let dummyMonthData = ["JULY 2016", "AUGUST 2016", "SEPTEMBER 2016"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(-30, 0, -30, 0)
        
    }
}

extension ContainerChooseDateViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CalendarCell
        
        cell.calendarContainerBackgroundView.layer.cornerRadius = 8
        cell.calendarContainerBackgroundView.layer.borderWidth = 1
        cell.calendarContainerBackgroundView.layer.borderColor = UIColor.whiteColor().CGColor
        
        cell.monthLabel.text = dummyMonthData[indexPath.item]
        
        return cell
    }
    
    
}
