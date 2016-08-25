//
//  SignUpChoosePrivateCoursesViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/10/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class SignUpChoosePrivateCoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoBannerBackgroundView: UIView!
    
    
    let currentLocation = ["Use current location"]
    
    var courses = PrivateCourses().courses
    var locations = PrivateCourses().locations
    
    var selectedIndexPath: NSIndexPath?
    var noCellIsSelected = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
        
        navigationItem.title = "Private Clubs"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        infoBannerBackgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        infoBannerBackgroundView.layer.shadowOpacity = 0.25
        infoBannerBackgroundView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        let nextButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "advanceToNextSignUpStep")
        nextButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension SignUpChoosePrivateCoursesViewController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PrivateCourseCell
        
        cell.privateCourseNameLabel.text = courses[indexPath.row]
        
        cell.selectionStyle = .None
        configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
        //selectedCity = (selectedCell.textLabel?.text)!
        configure(selectedCell, forRowAtIndexPath: indexPath)
        noCellIsSelected = false
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
    func configure(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (selectedIndexPath == indexPath) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }
    
    func advanceToNextSignUpStep() {
        performSegueWithIdentifier("toPasswordSignUpSegue", sender: self)

    }
}
