//
//  CourseOffersViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/13/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class CourseOffersViewController: UIViewController {
    
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBackgroundView.layer.cornerRadius = 8
        topBackgroundView.alpha = 0.5
        bottomBackgroundView.layer.cornerRadius = 8
        bottomBackgroundView.alpha = 0.5
        
    }
}
