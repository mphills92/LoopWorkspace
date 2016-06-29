//
//  SettingsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/9/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var signOutCell: UITableViewCell!
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"HelveticaNeue-Light", size: 20)!]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension SettingsViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 3) {
            return 65
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        if cellClicked == signOutCell {
            print("TO DO: Sign out user from Loop and release credentials. Pop view back to login page.")
            // TO DO: Sign out user from Loop and release credentials. Pop view back to login page.
        }
    }
}
