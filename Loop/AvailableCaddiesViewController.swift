//
//  AvailableCaddiesViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class AvailableCaddiesViewController: UIViewController {
    
    
    @IBAction func dismissAvailableCaddies(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        
    }
}
