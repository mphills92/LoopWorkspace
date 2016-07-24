//
//  ContainerReservationChooseCourseViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/29/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class ContainerReservationChooseCourseViewController: UICollectionViewController {
    
    
    @IBAction func chooseCourseButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("courseHasBeenSelectedSegue", sender: self)
    }
    
    let coursesAvailable = Courses.coursesAvailable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.backgroundColor = UIColor.blackColor()
        collectionView!.layoutIfNeeded()
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast //UIScrollViewDecelerationRateNormal //UIScrollViewDecelerationRateFast
    }
}


extension ContainerReservationChooseCourseViewController {
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coursesAvailable.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CoursesCollectionCell
        
        cell.coursesAvailable = coursesAvailable[indexPath.item]
        //cell.inspiration = inspirations[indexPath.item]
        //cell.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor() //colors[indexPath.item]
        cell.layoutIfNeeded()
        return cell
    }
    
}
