//
//  CoursesCollectionViewCell.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/29/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class CoursesCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageCoverView: UIView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var membershipHistoryLabel: UILabel!
    @IBOutlet weak var chooseCourseButton: UIButton!
    
    var coursesAvailable: Courses? {
        didSet {
            if let coursesAvailable = coursesAvailable {
                imageView.image = UIImage(named: "GolfCourseBackgroundImage")
                courseNameLabel.text = coursesAvailable.name
                membershipHistoryLabel.text = "Member since \(coursesAvailable.membershipHistory)"
                //imageView.image = caddiesAvailable.backgroundImage
            }
        }
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes!) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
        
        let delta = 1 - ((featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.25
        let maxAlpha: CGFloat = 0.8
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.65)
        //titleLabel.transform = CGAffineTransformMakeScale(scale, scale)
        courseNameLabel.transform = CGAffineTransformMakeScale(scale, scale)
        membershipHistoryLabel.transform = CGAffineTransformMakeScale(scale, scale)
        chooseCourseButton.alpha = delta
    }
    
}
