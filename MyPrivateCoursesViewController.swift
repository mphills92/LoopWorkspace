//
//  MyPrivateCoursesViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/10/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class MyPrivateCoursesViewController: UITableViewController {
    
    var userPrivateCourses = UserPrivateCourses()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Private Clubs"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addPrivateCourse")
        self.navigationItem.rightBarButtonItem = addButton
        
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)

    }
}

extension MyPrivateCoursesViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 62
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Select a course if you wish to remove it from your My Private Clubs list."
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPrivateCourses.privateCourseNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PrivateCourseCell
        
        cell.privateCourseNameLabel.text = userPrivateCourses.privateCourseNames[indexPath.row]
        cell.privateCourseLocationLabel.text = userPrivateCourses.privateCourseLocations[indexPath.row]
        
        return cell
    }
    
    func addPrivateCourse() {
        performSegueWithIdentifier("addPrivateCourseSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let actionSheetController = UIAlertController(title: "Remove \(userPrivateCourses.privateCourseNames[indexPath.row])?", message: "This course will no longer show up as an available option when beginning the caddie reservation process.", preferredStyle: .ActionSheet)
        actionSheetController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        let removeAction = UIAlertAction(title: "Remove from My Private Clubs", style: .Destructive) { (action) in
            print("TO DO: Remove course from private course list.")
        }
        actionSheetController.addAction(removeAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        actionSheetController.addAction(cancelAction)
        
        presentViewController(actionSheetController, animated: true) {
            actionSheetController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }
}