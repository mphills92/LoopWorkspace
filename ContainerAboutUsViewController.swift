//
//  ContainerAboutUsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/19/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerAboutUsViewController: UITableViewController {
    
    @IBOutlet weak var goToWebsiteTableViewCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(-100, 0, -100, 0)

    }
}

extension ContainerAboutUsViewController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 3) {
           UIApplication.sharedApplication().openURL(NSURL(string:"http://looptechnologies.github.io")!)
        }
    }
    
}
