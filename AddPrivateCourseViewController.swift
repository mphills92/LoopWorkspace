//
//  AddPrivateCourseViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/10/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class AddPrivateCourseViewController: UITableViewController {
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    var privateCourses = PrivateCourses()
    
    var selectedIndexPath: NSIndexPath?
    var selectedClub = String()
    var noCellIsSelected = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "Add Private Club"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: ("saveChanges"))
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)

    }
}

extension AddPrivateCourseViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 62
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateCourses.courses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PrivateCourseCell
        
        cell.privateCourseNameLabel.text = privateCourses.courses[indexPath.row]
        cell.privateCourseLocationLabel.text = privateCourses.locations[indexPath.row]
        
        cell.selectionStyle = .None
        configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! PrivateCourseCell
        
        if (selectedIndexPath == indexPath) {
            selectedIndexPath = nil
        } else {
            let oldSelectedIndexPath = selectedIndexPath
            selectedIndexPath = indexPath
            
            var previousSelectedCell: UITableViewCell?
            
            if let previousSelectedIndexPath = oldSelectedIndexPath {
                if let previousSelectedCell = tableView.cellForRowAtIndexPath(previousSelectedIndexPath) {
                    configure(previousSelectedCell, forRowAtIndexPath: previousSelectedIndexPath)
                }
            }
        }
        
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)! as! PrivateCourseCell
        selectedClub = (selectedCell.privateCourseNameLabel.text)!
        //selectedClub = (selectedCell.textLabel?.text)!
        configure(selectedCell, forRowAtIndexPath: indexPath)
        noCellIsSelected = false
        //evaluateButtonState()
    }
    
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (selectedIndexPath == indexPath) {
            selectedIndexPath = nil
        } else {
            let oldSelectedIndexPath = selectedIndexPath
            selectedIndexPath = indexPath
            
            var previousSelectedCell: UITableViewCell?
            
            if let previousSelectedIndexPath = oldSelectedIndexPath {
                if let previousSelectedCell = tableView.cellForRowAtIndexPath(previousSelectedIndexPath) {
                    configure(previousSelectedCell, forRowAtIndexPath: previousSelectedIndexPath)
                }
            }
        }
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)!
        configure(selectedCell, forRowAtIndexPath: indexPath)
        noCellIsSelected = true
        //evaluateButtonState()
    }
    
    func configure(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if (selectedIndexPath == indexPath) {
            cell.accessoryType = .Checkmark
            navigationItem.rightBarButtonItem?.enabled = true
        } else {
            cell.accessoryType = .None
            navigationItem.rightBarButtonItem?.enabled = false

        }
    }
    
    func saveChanges() {

        let alertController = UIAlertController(title: "Your My Private Clubs list has been updated.", message:  "", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        
        let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            self.dismissViewControllerAnimated(true, completion: {})
        }
        alertController.addAction(doneAction)
        
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }


}