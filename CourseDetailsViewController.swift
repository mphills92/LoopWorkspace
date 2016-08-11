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
    
    // Receive data from segue.
    var selectedCourseNameHasBeenSent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        courseNameLabel.text = selectedCourseNameHasBeenSent
    }
}

extension CourseDetailsViewController {
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
}
