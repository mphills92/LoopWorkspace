//
//  MonthTwoViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class MonthTwoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var calendarMonthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var calendarMonthTwo = CalendarMonthTwo()
    
    var cellToAdjustHighlight = NSIndexPath()
    var highlightedCell = NSIndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 8
        backgroundView.alpha = 0.5
        
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.delaysContentTouches = false
        
        calendarMonthLabel.text = calendarMonthTwo.monthTitle
    }
}

extension MonthTwoViewController: UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarMonthTwo.monthDates.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CalendarCollectionViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.numericDate.text = calendarMonthTwo.monthDates[indexPath.item]
        
        cell.selectedDateView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        cell.selectedDateView.layer.cornerRadius = 8
        cell.selectedDateView.hidden = true
        
        if (cell.numericDate.text == "") {
            cell.userInteractionEnabled = false
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 7), height: (collectionView.frame.width / 6))
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CalendarCollectionViewCell
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CalendarCollectionViewCell
        
        cellToAdjustHighlight = indexPath
        
        if (cellToAdjustHighlight != highlightedCell) {
        highlightCell(cellToAdjustHighlight)
        } else {
            unhighlightCell(cellToAdjustHighlight)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CalendarCollectionViewCell
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CalendarCollectionViewCell
        
        if (cellToAdjustHighlight == highlightedCell) {
            unhighlightCell(cellToAdjustHighlight)
        }
    }
    
    func highlightCell(cellToHighlight: NSIndexPath) -> NSIndexPath {
        let cell = collectionView.cellForItemAtIndexPath(cellToHighlight) as! CalendarCollectionViewCell
        
        cell.selectedDateView.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5).CGColor
        cell.selectedDateView.layer.borderColor = UIColor.whiteColor().CGColor
        cell.selectedDateView.layer.borderWidth = 1
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            cell.selectedDateView.transform = CGAffineTransformMakeScale(1, 1)
            cell.selectedDateView.hidden = false
            }, completion: nil)
        
        highlightedCell = cellToAdjustHighlight
        return highlightedCell
    }
    
    func unhighlightCell(cellToHighlight: NSIndexPath) -> NSIndexPath {
        let cell = collectionView.cellForItemAtIndexPath(cellToHighlight) as! CalendarCollectionViewCell
        
        cell.selectedDateView.layer.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(1.0).CGColor
        cell.selectedDateView.layer.borderColor = UIColor.clearColor().CGColor
        cell.selectedDateView.layer.borderWidth = 0
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            cell.selectedDateView.transform = CGAffineTransformMakeScale(0.5, 0.5)
            cell.selectedDateView.hidden = true
            }, completion: nil)

        highlightedCell = NSIndexPath()
        return highlightedCell
    }
}

