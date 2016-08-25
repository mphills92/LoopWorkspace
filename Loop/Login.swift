//
//  Login.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 6/29/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

// Query DB for email and return true/false from DB to set emailExistsInDatabase.
class EmailAuthentication {
    var emailExistsInDatabase: Bool = true
}

// Query DB to ensure email and password match for the account and return true/false from DB to set passwordMatchesEmailAccount.
class PasswordAuthentication {
    var passwordExistsInDatabase: Bool = true
    var passwordMatchesEmailAccount: Bool = true
}
