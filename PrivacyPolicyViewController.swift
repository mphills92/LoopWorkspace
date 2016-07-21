//
//  PrivacyPolicyViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/21/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Privacy Policy"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
}
