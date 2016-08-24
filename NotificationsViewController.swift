//
//  NotificationsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class NotificationsViewController: UITableViewController {
    
    var notifications = Notifications()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notifications"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        tableView.contentInset = UIEdgeInsetsMake(-36, 0, -36, 0)

    }
}

extension NotificationsViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (notifications.notificationsDataExists == true) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            
            noDataLabel.text = "You have no new notifications."
            noDataLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
            noDataLabel.textColor = UIColor.darkGrayColor()
            noDataLabel.textAlignment = NSTextAlignment.Center
            tableView.backgroundView = noDataLabel
            tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return numOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.notificationsToDisplay.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notificationsCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = notifications.notificationsToDisplay[indexPath.row]
        cell.textLabel?.font = UIFont(name: "AvenirNext-Regular", size: 17)
        cell.textLabel?.lineBreakMode = .ByWordWrapping
        cell.textLabel?.numberOfLines = 0
        

        return cell
    }
}