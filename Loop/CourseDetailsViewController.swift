//
//  CourseDetailsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/11/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class CourseDetailsViewController: UIViewController {
    
    @IBOutlet weak var courseNameLabel: UILabel!
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    let coursesDetailedInfoDB = CoursesDetailedInfoDatabase()
    
    // Receive data from segue.
    var selectedCourseNameHasBeenSent: String?
    var selectedLocationHasBeenSent: String?
    var selectedCourseIDHasBeenSent: String?
    
    var cityState = String()
    var courseIDForDetails = String()
    var membershipHistory = String()
    var detailedInformation = [String]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "postDetailedInfoPage2Notification:", name: "requestDetailedInformationNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "postDetailedInfoPage3Notification:", name: "requestDetailedInformationNotification", object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        courseNameLabel.text = selectedCourseNameHasBeenSent
        cityState = selectedLocationHasBeenSent!
        courseIDForDetails = selectedCourseIDHasBeenSent!
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        coursesDetailedInfoDB.getDetailedInformationForCourseID(courseIDForDetails) {
            (detailedInformationArray) -> Void in
            self.detailedInformation = detailedInformationArray
            
            NSNotificationCenter.defaultCenter().postNotificationName("passDetailedInfoPage1Notification", object: self.detailedInformation)
        }        
    }
}

extension CourseDetailsViewController {
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func postDetailedInfoPage2Notification(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().postNotificationName("passDetailedInfoPage2Notification", object: self.detailedInformation)
    }
    
    func postDetailedInfoPage3Notification(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().postNotificationName("passDetailedInfoPage3Notification", object: self.detailedInformation)
    }
}
