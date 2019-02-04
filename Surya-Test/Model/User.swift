//
//  User.swift
//  Surya-Test
//
//  Created by Prateek Kumar on 31/01/19.
//  Copyright © 2019 Sourcebits. All rights reserved.
//

import Foundation

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.emailId == rhs.emailId &&
            lhs.imageUrl == rhs.imageUrl
    }
}

struct  User: Codable {

    let firstName: String
    let lastName: String
    let emailId:  String
    let imageUrl: String
}
