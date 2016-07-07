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
        
        setCaddieMenuOptionButton()
        
    }
}

extension SidebarMenuViewController {
    
    func setCaddieMenuOptionButton() {
        if (userAccount.userHasCaddieAccount == false) {
            caddieMenuOptionButton.setTitle("Become a Caddie", forState: .Normal)
        } else {
            caddieMenuOptionButton.setTitle("Go To Caddie Mode", forState: .Normal)
            caddieMenuOptionButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 14)
            caddieMenuOptionButton.backgroundColor = UIColor.clearColor()
            caddieMenuOptionButton.layer.borderColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0).CGColor
            caddieMenuOptionButton.layer.borderWidth = 1
            caddieMenuOptionButton.layer.cornerRadius = caddieMenuOptionButton.bounds.height / 2
        }
    }
    
    @IBAction func caddieMenuOptionButtonPressed(sender: AnyObject) {
        if (userAccount.userHasCaddieAccount == false) {
            performSegueWithIdentifier("toBecomeCaddieSegue", sender: self)
        } else {
            performSegueWithIdentifier("toCaddieModeSegue", sender: self)
        }
    }
    
}
