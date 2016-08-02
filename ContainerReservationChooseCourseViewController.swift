//
//  ContainerReservationChooseCourseViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/29/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerReservationChooseCourseViewController: UICollectionViewController {
    
    let coursesAvailable = Courses.coursesAvailable()
    
    var selectedCourseNameToSend = String()
    var selectedCourseIDToPass = Int()
    var selectedCourseCollectionCellIndexPath = NSIndexPath()
    var lastContentOffset = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.backgroundColor = UIColor.blackColor()
        collectionView!.layoutIfNeeded()
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
    }
}


extension ContainerReservationChooseCourseViewController {
    
    @IBAction func chooseCourseButtonPressed(sender: AnyObject) {
        let chooseCourseButtonRow = sender.tag
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coursesAvailable.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CoursesCollectionCell
        
        cell.coursesAvailable = coursesAvailable[indexPath.item]
        
        cell.chooseCourseButton.tag = indexPath.row
        
        selectedCourseCollectionCellIndexPath = indexPath
        
        cell.chooseCourseButton.addTarget(self, action: "chooseCourseButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.layoutIfNeeded()
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! CoursesCollectionCell

        selectedCourseNameToSend = (cell.courseNameLabel.text)!
        
        self.performSegueWithIdentifier("courseHasBeenSelectedSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "courseHasBeenSelectedSegue") {
            let destinationVC = segue.destinationViewController as! ChooseDateViewController
            
            destinationVC.selectedCourseNameHasBeenSent = selectedCourseNameToSend
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
