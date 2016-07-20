//
//  UserInformation.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/18/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class UserName {
    var firstName: String = "Mark"
    var lastName: String = "Johnson"
}

class UserPassword {
    var password: String = "test"
    var newPassword = String()
    var confirmedNewPassword = String()
}

class UserEmail {
    var email: String = "test@email.com"
    var newEmail = String()
    var confirmedNewEmail = String()
}

class UserPhone {
    var phoneNumber: String = "7778889999"
}

class UserAccount {
    var membershipHistory: String = "July 2016"
    var lifetimeRounds: Int = 22
    var currentCredit: Int = 4
    var userHasCaddieAccount: Bool = true
}

class UserReferralCode {
    var referralCode: String = "ABC123"
}

class UpcomingReservations {
    var reservationDataExists: Bool = true
    var numberOfUpcomingReservationsCells: Int = 5
}

class CaddieHistory {
    var caddieHistoryDataExists: Bool = true
    var numberOfCaddieHistoryCells: Int = 5
    
}

class Notifications {
    var notificationsDataExists: Bool = false
    var numberOfNotificationsCells: Int = 0
}

class MostRecentRound {
    var reviewHasBeenSubmittedForMostRecentRound: Bool = false
}

