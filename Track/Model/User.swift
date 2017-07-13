//
//  User.swift
//  Track
//
//  Created by ty on on 6/22/17.
//  Copyright © 2017 Code Clan. All rights reserved.
//

import Foundation
class User {
    var firstName: String!
    var lastName: String!
    var dateOfBirth: String!
    var doctorId: String!
    var profilImage: String!
    
    init(firstNames: String, lastNames: String, dateOfBirths: String, doctorIds: String, profileImages: String) {
        self.firstName = firstNames
        self.lastName = lastNames
        self.dateOfBirth = dateOfBirths
        self.doctorId = doctorIds
        self.profilImage = profileImages
    }
}
