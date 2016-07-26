//
//  ContainerGolferCheckInViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/20/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerGolferCheckInViewController: UITableViewController {
    
    @IBOutlet weak var caddieProfileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-96, 0, 0, 0)

        caddieProfileImageView.layer.cornerRadius = 8

    }
}

extension ContainerGolferCheckInViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }
    
}
