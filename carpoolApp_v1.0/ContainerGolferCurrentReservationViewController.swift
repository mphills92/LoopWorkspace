//
//  ContainerGolferCurrentReservationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/20/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerGolferCurrentReservationViewController: UITableViewController {
    
    @IBOutlet weak var caddieProfileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(-33, 0, -33, 0)
        
        caddieProfileImageView.layer.cornerRadius = 8
        
    }
}

extension ContainerGolferCurrentReservationViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }
}