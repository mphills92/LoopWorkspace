//
//  ContainerReviewCaddieViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/20/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
class ContainerReviewCaddieViewController: UITableViewController {
    
    @IBOutlet weak var caddieProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.contentInset = UIEdgeInsetsMake(-100, 0, -40, 0)
        
        caddieProfileImage.layer.cornerRadius = 50
        
        
    }
    
}

extension ContainerReviewCaddieViewController {

}
