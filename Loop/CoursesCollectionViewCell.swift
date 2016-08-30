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
    @IBOutlet weak var holdForDetailsLabel: UILabel!
    @IBOutlet weak var tapToSelectLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseLocationLabel: UILabel!
    @IBOutlet weak var chooseCourseButton: UIButton!
    @IBOutlet weak var revealUpDisclosureIndicator: UIImageView!
    @IBOutlet weak var revealRightDisclosureIndicator: UIImageView!
    
    // Reference to database class which communicates with Firebase.
    let usersDB = UsersDatabase()
    let golfCoursesDB = CoursesBasicInfoDatabase()
    
    var coursesAvailable: Courses? {
        didSet {
            if let coursesAvailable = coursesAvailable {
                imageView.image = UIImage(named: "GolfCourseBackgroundImage")
                courseNameLabel.text = coursesAvailable.name
                courseLocationLabel.text = coursesAvailable.city
                //membershipHistoryLabel.text = "Member since \(coursesAvailable.membershipHistory)"
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
        courseLocationLabel.transform = CGAffineTransformMakeScale(scale, scale)
        holdForDetailsLabel.transform = CGAffineTransformMakeScale(scale, scale)
        revealUpDisclosureIndicator.transform = CGAffineTransformMakeScale(scale, scale)
        tapToSelectLabel.transform = CGAffineTransformMakeScale(scale, scale)
        revealRightDisclosureIndicator.transform = CGAffineTransformMakeScale(scale, scale)
            
        courseLocationLabel.alpha = delta
        holdForDetailsLabel.alpha = delta
        revealUpDisclosureIndicator.alpha = delta
        tapToSelectLabel.alpha = delta
        revealRightDisclosureIndicator.alpha = delta
    }
}
