//
//  OurViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 4/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var findCaddyButton: UIButton!
    @IBOutlet weak var constraintToBottomFindCaddyButton: NSLayoutConstraint!
    
    var screenSize = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        
        let navBarLogo = UIImage(named: "LoopLogoNavBar")! as UIImage
        let imageView = UIImageView(image: navBarLogo)
        imageView.frame.size.width = 35.0
        imageView.frame.size.height = 35.0
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        imageViewBackground.image = UIImage(named: "LandingPageBackground")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
        
        
        findCaddyButton.layer.borderColor = UIColor.whiteColor().CGColor
        findCaddyButton.layer.borderWidth = 1
        findCaddyButton.layer.cornerRadius = findCaddyButton.bounds.height / 2
        findCaddyButton.layer.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.2).CGColor
    
        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)]
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func findCaddyButtonPressed(sender: AnyObject) {
        presentReservationView()
    }
    
    func presentReservationView() {
        
        // Hide the "Find a Caddy" button by sliding it down out of the frame.
        /*UIView.animateWithDuration(1, delay: 0, options: .CurveEaseIn, animations: {
            self.constraintToBottomFindCaddyButton.constant -= self.screenSize.height / 2
            self.view.layoutIfNeeded()
            }, completion: nil)*/
    }
    
    func submitReservationView() {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toStartReservationSegue") {
            //menuButton.enabled = false
        }
    }
    
}


