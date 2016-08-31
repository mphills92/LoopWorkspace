//
//  ContainerReservationChooseCourseViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/29/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerReservationChooseCourseViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    
    let coursesAvailable = Courses.coursesAvailable()
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    let golfCoursesDB = CoursesBasicInfoDatabase()
    
    // Empty variables to be populated in order to execute getBasicInfoForGolfCoursesInRadius.
    var setPointLat = Double()
    var setPointLon = Double()
    var searchRadiusFromSetPoint = 2000.00
    
    // Variables to be populated upon retrieving nearby courses.
    var nearbyCoursesToDisplay = [String]()
    var dataHasBeenLoaded = Bool()
    
    
    var selectedCourseNameToSend = String()
    var selectedLocationToSend = String()
    var selectedCourseIDToSend = Int()
    
    var selectedCourseCollectionCellIndexPath = NSIndexPath()
    var lastContentOffset = CGFloat()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataHasBeenLoaded = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.backgroundColor = UIColor.blackColor()
        collectionView!.layoutIfNeeded()
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        longPressRecognizer.minimumPressDuration = 0.35
        longPressRecognizer.delaysTouchesBegan = true
        longPressRecognizer.delegate = self
        self.collectionView?.addGestureRecognizer(longPressRecognizer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "adjustSetPointLat:", name: "setPointLatNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "adjustSetPointLon:", name: "setPointLonNotification", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        golfCoursesDB.getGolfCourseIDsInRadius(setPointLat, setPointLon: setPointLon, searchRadiusFromSetPoint: searchRadiusFromSetPoint) {
            (courseIDs) -> Void in
            
            self.golfCoursesDB.getGolfCourseBasicInfoForIDs(courseIDs) {
                (courseNames) -> Void in
                self.nearbyCoursesToDisplay = courseNames
                self.collectionView?.reloadData()
                self.dataHasBeenLoaded = true
            }
            
            
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "setPointLatNotification", object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "setPointLonNotification", object: self.view.window)
    }
}


extension ContainerReservationChooseCourseViewController {
    
    func adjustSetPointLat(notification: NSNotification) {
        setPointLat = notification.object! as! Double
        
    }
    
    func adjustSetPointLon(notification: NSNotification) {
        setPointLon = notification.object! as! Double
        
    }
    
    @IBAction func chooseCourseButtonPressed(sender: AnyObject) {
        let chooseCourseButtonRow = sender.tag
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numOfItems: Int = 0
        
        /*
        if (dataHasBeenLoaded == false) {
            print("loading")
            numOfItems = 0
        } else if (dataHasBeenLoaded == true) {
            if (nearbyCoursesToDisplay.count == 0) {
                print("no courses to show")
                numOfItems = 1
            } else if (nearbyCoursesToDisplay.count > 0) {
                print("nearby courses")
                numOfItems = nearbyCoursesToDisplay.count
            }
        }*/
        
        if (dataHasBeenLoaded == false) {
            print("loading")
            numOfItems = 0
        } else {
            print("loaded")
            numOfItems = nearbyCoursesToDisplay.count
        }
        return  numOfItems
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CoursesCollectionCell
        
        //cell.coursesAvailable = coursesAvailable[indexPath.item]

        cell.courseNameLabel.text = nearbyCoursesToDisplay[indexPath.item]
        cell.imageView.image = UIImage(named: "GolfCourseBackgroundImage")
        
        cell.chooseCourseButton.tag = indexPath.row
        
        selectedCourseCollectionCellIndexPath = indexPath
        
        cell.chooseCourseButton.addTarget(self, action: "chooseCourseButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.layoutIfNeeded()
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! CoursesCollectionCell
        
        selectedCourseNameToSend = (cell.courseNameLabel.text)!
        selectedLocationToSend = (cell.courseLocationLabel.text)!
        
        self.performSegueWithIdentifier("courseHasBeenSelectedSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "courseHasBeenSelectedSegue") {
            let destinationVC = segue.destinationViewController as! ChooseDateViewController
            
            destinationVC.selectedCourseNameHasBeenSent = selectedCourseNameToSend
            destinationVC.selectedLocationHasBeenSent = selectedLocationToSend
        } else if (segue.identifier == "toCourseDetailsSegue") {
            var indexPath: NSIndexPath = (sender as! NSIndexPath)
            let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! CoursesCollectionCell
            
            selectedCourseIDToSend = cell.tag
            //selectedCourseNameToSend = (cell.courseNameLabel.text)!
            
            let navigationController = segue.destinationViewController as? UINavigationController
            let destinationVC = navigationController!.topViewController as! CourseDetailsViewController
            destinationVC.selectedCourseNameHasBeenSent = selectedCourseNameToSend
            destinationVC.selectedCourseIDHasBeenSent = selectedCourseIDToSend
            
        }
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }

    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var upwardScroll = Bool()
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            upwardScroll = true
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            upwardScroll = false
        } else {
            
        }
        NSNotificationCenter.defaultCenter().postNotificationName("userHasSwipedContainerNotification", object: upwardScroll)
    }
    
    func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
        if (gestureRecognizer.state != .Began) {
            return
        }
        
        let touchPoint = gestureRecognizer.locationInView(self.collectionView)
        let indexPath = self.collectionView?.indexPathForItemAtPoint(touchPoint)
        
        if let index = indexPath {
            var cell = self.collectionView?.cellForItemAtIndexPath(index) as! CoursesCollectionCell
            performSegueWithIdentifier("toCourseDetailsSegue", sender: indexPath)
            //print("long press in cell \(coursesAvailable[indexPath!.item])")
        } else {
            //print("no long press")
        }
    }
}
