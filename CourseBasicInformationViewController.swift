//
//  CourseBasicInformationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/12/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class CourseBasicInformationViewController: UIViewController {
    
    
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var informationBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        topBackgroundView.layer.cornerRadius = 8
        topBackgroundView.alpha = 0.6
        informationBackgroundView.layer.cornerRadius = 8
        informationBackgroundView.alpha = 0.6
        
        
    }
}
