//
//  ReviewCaddieViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/19/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ReviewCaddieViewController: UITableViewController {
    
    @IBOutlet weak var caddieProfileImage: UIImageView!
    @IBOutlet weak var submitReviewCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)

        navigationItem.title = "Review Caddie"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        caddieProfileImage.layer.cornerRadius = 8
        


    }
}

extension ReviewCaddieViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        if cellClicked == submitReviewCell {
            let alertController = UIAlertController(title: "Review submitted!", message: "Thanks very much for your feedback. Your reviews help to ensure that Loop customers have the best possible caddie ratings when making reservation decisions. ", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            
            let doneAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.dismissViewControllerAnimated(true, completion: {})
            }
            
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }

        }
    }
    
    
}
