//
//  ContainerConfirmReservationViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/15/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerConfirmReservationViewController: UITableViewController {
    
    @IBOutlet weak var promoCodeTableViewCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-32, 0, -32, 0)
        
        promoCodeTableViewCell.tag = 1

    }
    
}

extension ContainerConfirmReservationViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }
    
    @IBAction func infoButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Why am I charged 10% of my reservation now?", message:  "\n Our caddies need assurance in return for blocking off a 5 hour time window within their schedules. \n \n Between now and your reservation date, the 10% reservation cost that you are charged remains securely held by Loop. If you choose to cancel your reservation prior to 48 hours before your reservation, the amount will be fully refunded to your payment method. If you choose to cancel your reservation within 48 hours of the reservation or if you decide not show up to your reservation, you forfeit the amount and it is paid to the caddie you had reserved.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in }
        alertController.addAction(doneAction)
        
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        if cellClicked == promoCodeTableViewCell {
            performSegueWithIdentifier("toPromoCodePopoverSegue", sender: self)
        }
        
    }
}
