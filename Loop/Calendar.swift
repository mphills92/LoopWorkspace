//
//  Calendar.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 8/17/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class GeneralCalendarData {

    var calendarMonths = ["January",
                          "February",
                          "March",
                          "April",
                          "May",
                          "June",
                          "July",
                          "August",
                          "September",
                          "October",
                          "November",
                          "December"]
    
    var daysPerCalendarMonth = [31,  // Jan
                                28,  // Feb
                                31,  // Mar
                                30,  // Apr
                                31,  // May
                                30,  // Jun
                                31,  // July
                                31,  // Aug
                                30,  // Sep
                                31,  // Oct
                                30,  // Nov
                                31]  // Dec
    
    func getCurrentDateInfo() -> (currentDay: Int, currentMonth: Int, currentYear: Int) {
        let date = NSDate()
        let userCalendar = NSCalendar.currentCalendar()
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        var currentDay = Int()
        var currentMonth = Int()
        var currentYear = Int()
        let requestedComponents: NSCalendarUnit = [NSCalendarUnit.Year,
                                                   NSCalendarUnit.Month,
                                                   NSCalendarUnit.Day,
                                                   NSCalendarUnit.Hour,
                                                   NSCalendarUnit.Minute,
                                                   NSCalendarUnit.Second]
        
        dateFormatter.dateFormat = "dd"
        _ = userCalendar.components(requestedComponents, fromDate: date)
        currentDay = Int(dateFormatter.stringFromDate(date))!
        
        dateFormatter.dateFormat = "MM"
        _ = userCalendar.components(requestedComponents, fromDate: date)
        currentMonth = Int(dateFormatter.stringFromDate(date))!
        
        dateFormatter.dateFormat = "yyyy"
        _ = userCalendar.components(requestedComponents, fromDate: date)
        currentYear = Int(dateFormatter.stringFromDate(date))!
        
        return (currentDay, currentMonth, currentYear)
    }
    
    /*
    func setDaysOfMonth(month: Int) -> [Int] {
        
        var daysOfMonth = []
        
        switch (month) {
        case 0:
            
        case 1:
            
        }
        
        return daysOfMonth as! [Int]
    }*/
    
}


class CalendarMonthOne {
    // Currently September 2016
    var monthDates = ["", "", "", "", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
}

class CalendarMonthTwo {
    // Currently October 2016
    var monthDates = ["", "", "", "", "", "", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
}

class CalendarMonthThree {
    // Currently November 2016
    var monthDates = ["", "", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
}
