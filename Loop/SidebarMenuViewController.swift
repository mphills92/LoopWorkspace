//
//  SidebarMenuViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class SidebarMenuViewController: UIViewController {
    
    @IBOutlet weak var caddieMenuOptionButton: UIButton!
    
    let userAccount = UserAccount()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        setCaddieMenuOptionButton()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

extension SidebarMenuViewController {
    
    func setCaddieMenuOptionButton() {
        if (userAccount.userHasCaddieAccount == false) {
            caddieMenuOptionButton.setTitle("Become a Caddie", forState: .Normal)
        } else {
            caddieMenuOptionButton.setTitleColor(UIColor.clearColor(), forState: .Normal)
            caddieMenuOptionButton.userInteractionEnabled = false
        }
    }
    
    @IBAction func caddieMenuOptionButtonPressed(sender: AnyObject) {
        if (userAccount.userHasCaddieAccount == false) {
            performSegueWithIdentifier("toBecomeCaddieSegue", sender: self)
        }
    }
    
}
