//
//  MonthTwoViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class MonthTwoViewController: UIViewController {
    
    
    @IBOutlet weak var calendarMonthTwoLabel: UILabel!
    
    var calendarMonths = CalendarMonths()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarMonthTwoLabel.text = calendarMonths.calendarMonthTwo
        
        
    }
}
