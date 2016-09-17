//
//  ReservationDetailsViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/24/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ReservationDetailsViewController: UITableViewController {
    
    @IBOutlet weak var caddieProfileImageView: UIImageView!
    @IBOutlet weak var reviewCaddieBannerCell: UITableViewCell!
    @IBOutlet weak var reviewCaddieButton: UIButton!
    
    var previousReservation = PreviousReservation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Caddie Reservation"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        reviewCaddieButton.layer.cornerRadius = 15
        reviewCaddieButton.layer.borderWidth = 1
        reviewCaddieButton.layer.borderColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0).CGColor
        
        caddieProfileImageView.layer.cornerRadius = 50
        
        setNumberOfTableViewSections()
        
        
    }
    
}

extension ReservationDetailsViewController {
    
    func setNumberOfTableViewSections() {
        if (previousReservation.reviewHasBeenSubmitted == false) {
            reviewCaddieBannerCell.hidden = false
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            reviewCaddieBannerCell.hidden = true
            tableView.contentInset = UIEdgeInsetsMake(-212, 0, 0, 0)
        }
    }
    
    /*
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }*/
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 3) {
            return 45
        } else {
            return 0
        }
        return 0
    }
    
    @IBAction func reviewCaddieButtonPressed(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewCaddieNavController = storyboard.instantiateViewControllerWithIdentifier("ReviewCaddieNavigationController") as! UIViewController
        self.presentViewController(reviewCaddieNavController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

