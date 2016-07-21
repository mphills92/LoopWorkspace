//
//  CaddieNotificationsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/19/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class CaddieNotificationsViewController: UITableViewController {
    
    var dataExistsForTableView = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Notifications"
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }
}

extension CaddieNotificationsViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        
        if (dataExistsForTableView == true) {
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
}