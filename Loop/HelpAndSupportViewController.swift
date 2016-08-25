//
//  HelpAndSupportViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class HelpAndSupportViewController: UIViewController {
    
    @IBOutlet weak var viewFAQsButton: UIButton!
    @IBOutlet weak var fileComplaintButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Help & Support"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.viewFAQsButton.layer.cornerRadius = viewFAQsButton.bounds.height / 2
        self.fileComplaintButton.layer.cornerRadius = fileComplaintButton.bounds.height / 2
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension HelpAndSupportViewController {

}