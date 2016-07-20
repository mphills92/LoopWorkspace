//
//  DashboardViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/19/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UIScrollViewDelegate {
    
    var dataExistsForTableView = false
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        let distBetweenScrollSectionAndNavBar : CGFloat = 152 - 64
        let screenSizeAdjustment = 1 + (distBetweenScrollSectionAndNavBar / screenSize.height)
        self.scrollView.contentSize.height = screenSize.height * screenSizeAdjustment
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, -64, 0)

        
    }
}