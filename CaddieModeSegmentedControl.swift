//
//  CaddieModeSegmentedControl.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/6/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

@IBDesignable class CaddieModeSegmentedControl: UIControl {
    
    private var labels = [UILabel]()
    var thumbView = UIView()
    var lineView = UIView()
    var pillView = UIView()
    
    var items: [String] = ["Dashboard", "Upcoming"] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex : Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupView()
    }
    
    func setupView() {
        setupLabels()
        insertSubview(thumbView, atIndex: 0)
    }
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll(keepCapacity: true)
        
        for index in 1...items.count {
            let label = UILabel(frame: CGRectZero)
            label.text = items[index - 1]
            label.textAlignment = .Center
            label.textColor = UIColor.whiteColor()
            label.font = UIFont(name: "AvenirNext-Regular", size: 17)
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var selectFrame = self.bounds
        let newWidth = CGRectGetWidth(selectFrame) / CGFloat(items.count)
        selectFrame.size.width = newWidth
        thumbView.frame = selectFrame

        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        lineView.frame = CGRectMake((labelWidth * 0.05), labelHeight - 1.0, (labelWidth * 0.9), 1.5)
        lineView.backgroundColor = UIColor.whiteColor() //(red: 19/255, green: 86/255, blue:99/255, alpha: 1.0)
        
        pillView.frame = CGRectMake ((labelWidth * 0.05), 0, (labelWidth * 0.9), labelHeight)
        pillView.backgroundColor = UIColor.clearColor()
        pillView.layer.borderWidth = 1
        pillView.layer.borderColor = UIColor.whiteColor().CGColor
        pillView.layer.cornerRadius = thumbView.frame.height / 2
        
        thumbView.addSubview(pillView)
        
        for index in 0...labels.count - 1 {
            var label = labels[index]
            
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRectMake(xPosition, 0, labelWidth, labelHeight)
        }
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        var calculatedIndex: Int?
        for(index, item) in EnumerateSequence(labels) {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        return false
    }
    
    func displayNewSelectedIndex() {
        var label = labels[selectedIndex]
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping:  0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
            self.thumbView.frame = label.frame
            }, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("selectedIndexNotification", object: selectedIndex)
    }
    
    func addIndividualItemConstraints(items: [UIView], mainView: UIView, padding: CGFloat) {
        let constraints = mainView.constraints
        for (index, button) in EnumerateSequence(items) {
            
            var topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
            
            var bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == items.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -padding)
                
            }else{
                
                let nextButton = items[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: nextButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -padding)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: padding)
                
            }else{
                
                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: prevButton, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: padding)
                
                let firstItem = items[0]
                
                var widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: NSLayoutRelation.Equal, toItem: firstItem, attribute: .Width, multiplier: 1.0  , constant: 0)
                
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    
}

