//
//  User.swift
//  How-To
//
//  Created by Audrey Welch on 7/9/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let userID: Int? = nil
    let username: String
    let password: String
    let userType: String 
}
