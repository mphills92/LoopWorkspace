//
//  HelpViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/22/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class HelpViewController: UITableViewController {
    
    @IBOutlet weak var reviewCaddieCell: UITableViewCell!
    
    var mostRecentRound = MostRecentRound()
    
    @IBAction func closeViewButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.contentInset = UIEdgeInsetsMake(-25, 0, -25, 0)

        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}

extension HelpViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 32
        } else {
            return 12
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellClicked: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if cellClicked == reviewCaddieCell {
            if (mostRecentRound.reviewHasBeenSubmittedForMostRecentRound == false) {
                performSegueWithIdentifier("toReviewCaddieSegue", sender: self)
            } else if (mostRecentRound.reviewHasBeenSubmittedForMostRecentRound == true) {
                let alertController = UIAlertController(title: "Review already submitted.", message: "It looks like you've already reviewed the caddie from your previous round. We appreciate your enthusiasm, but you'll just have to play another round of golf to have another caddie to review!", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                
                let doneAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                }
                
                alertController.addAction(doneAction)
                
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
                }

            }
        }

    }
}