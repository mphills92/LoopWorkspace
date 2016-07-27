//
//  LoopContactRequestViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/26/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class LoopContactRequestViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Default
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        submitButton.layer.cornerRadius = 20
    }
}

extension LoopContactRequestViewController {
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
// TODO: Send contact request information to Loop.
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    
}
