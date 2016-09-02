//
//  ContainerReservationChooseCourseViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/29/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit
import Firebase

class ContainerReservationChooseCourseViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    
    let coursesAvailable = Courses.coursesAvailable()
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    let golfCoursesDB = CoursesBasicInfoDatabase()
    let coursesDetailedInfoDB = CoursesDetailedInfoDatabase()
    
    var dbRef : FIRDatabaseReference!
    var courseBasicInfoRef : FIRDatabaseReference!
    
    // Empty variables to be populated in order to execute getBasicInfoForGolfCoursesInRadius.
    var setPointLat = Double()
    var setPointLon = Double()
    var searchRadiusFromSetPoint = 2000.00
    
    // Variables to be populated upon retrieving nearby courses.
    var nearbyCourseNamesToDisplay = [String]()
    var nearbyCourseLocationsToDisplay = [String]()
    var nearbyCourseIDsToMonitor = [String]()
    var dataHasBeenLoaded = Bool()
    
    
    var selectedCourseNameToSend = String()
    var selectedLocationToSend = String()
    var selectedCourseIDToSend = String()
    
    var collectionViewHasBeenCached = Bool()
    
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
        
        self.dbRef = FIRDatabase.database().reference()
        self.courseBasicInfoRef = self.dbRef.child("courses_basic_info")
        
        collectionViewHasBeenCached = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if (collectionViewHasBeenCached == false) {
        NSNotificationCenter.defaultCenter().postNotificationName("startActivityIndicatorNotification", object: nil)
        
        self.courseBasicInfoRef.observeEventType(FIRDataEventType.Value) {
            (snapshot: FIRDataSnapshot) in
            
            self.golfCoursesDB.getGolfCourseIDsInRadius(self.setPointLat, setPointLon: self.setPointLon, searchRadiusFromSetPoint: self.searchRadiusFromSetPoint) {
                (courseIDs) -> Void in
                
                self.nearbyCourseIDsToMonitor = courseIDs
                
                var courseNamesArray = [String]()
                var courseLocationsArray = [String]()
                
                for var n = 0; n < courseIDs.count; n++ {
                    if let name = snapshot.childSnapshotForPath("\(courseIDs[n])").value?.objectForKey("name") as? String {
                        courseNamesArray.append(name)
                    }
                    self.nearbyCourseNamesToDisplay = courseNamesArray
                }
                
                for var l = 0; l < courseIDs.count; l++ {
                    if let location = snapshot.childSnapshotForPath("\(courseIDs[l])").value?.objectForKey("city_state") as? String {
                        courseLocationsArray.append(location)
                    }
                    self.nearbyCourseLocationsToDisplay = courseLocationsArray
                }
                
                self.collectionView?.reloadData()
                NSNotificationCenter.defaultCenter().postNotificationName("stopActivityIndicatorNotification", object: nil)
            }
            }
            collectionViewHasBeenCached = true
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
        return nearbyCourseNamesToDisplay.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CoursesCollectionCell
        
        cell.tag = indexPath.row
        
        cell.courseNameLabel.text = nearbyCourseNamesToDisplay[indexPath.item]
        cell.courseLocationLabel.text = nearbyCourseLocationsToDisplay[indexPath.item]
        cell.imageView.image = UIImage(named: "GolfCourseBackgroundImage")
        
        
        selectedCourseCollectionCellIndexPath = indexPath
        
        cell.layoutIfNeeded()
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! CoursesCollectionCell
        
        selectedCourseNameToSend = nearbyCourseNamesToDisplay[indexPath.row]
        selectedLocationToSend = nearbyCourseLocationsToDisplay[indexPath.row]
        selectedCourseIDToSend = nearbyCourseIDsToMonitor[indexPath.row]
        
        self.performSegueWithIdentifier("courseHasBeenSelectedSegue", sender: self)
    }
    
    func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
        if (gestureRecognizer.state != .Began) {
            return
        }
        
        let touchPoint = gestureRecognizer.locationInView(self.collectionView)
        let indexPath = self.collectionView?.indexPathForItemAtPoint(touchPoint)
        
        if let index = indexPath {
            var cell = self.collectionView?.cellForItemAtIndexPath(index) as! CoursesCollectionCell
            selectedCourseNameToSend = nearbyCourseNamesToDisplay[index.row]
            selectedLocationToSend = nearbyCourseLocationsToDisplay[index.row]
            selectedCourseIDToSend = nearbyCourseIDsToMonitor[index.row]
            
            performSegueWithIdentifier("toCourseDetailsSegue", sender: indexPath)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "courseHasBeenSelectedSegue") {
            let destinationVC = segue.destinationViewController as! ChooseDateViewController
            destinationVC.selectedCourseNameHasBeenSent = selectedCourseNameToSend
            destinationVC.selectedLocationHasBeenSent = selectedLocationToSend
        } else if (segue.identifier == "toCourseDetailsSegue") {
            var indexPath: NSIndexPath = (sender as! NSIndexPath)
            let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! CoursesCollectionCell
            
            let navigationController = segue.destinationViewController as? UINavigationController
            let destinationVC = navigationController!.topViewController as! CourseDetailsViewController
            
            destinationVC.selectedCourseNameHasBeenSent = selectedCourseNameToSend
            destinationVC.selectedLocationHasBeenSent = selectedLocationToSend
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
}
