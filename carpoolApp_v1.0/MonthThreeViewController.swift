//
//  MonthThreeViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class MonthThreeViewController: UIViewController {
    
    
    @IBOutlet weak var calendarMonthThreeLabel: UILabel!
    
    var calendarMonths = CalendarMonths()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarMonthThreeLabel.text = calendarMonths.calendarMonthThree
        
        
    }
}