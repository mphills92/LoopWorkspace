//
//  ContainerDashboardViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/19/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerDashboardViewController: UITableViewController {
    
    var dataExistsForTableView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ContainerDashboardViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        
        if (dataExistsForTableView == true) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            
            noDataLabel.text = "You have no reservations today."
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
