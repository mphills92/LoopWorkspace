//
//  ChooseCoursePopoverViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ChooseCoursePopoverViewController: UIViewController {
    
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var selectCourseButton: UIButton!
    
    @IBAction func cancelChooseCourse(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectCourseButton.layer.cornerRadius = 15
        
        popoverView.layer.cornerRadius = 8
        
        
    }
}
