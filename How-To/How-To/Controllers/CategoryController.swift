//
//  CategoryController.swift
//  How-To
//
//  Created by Audrey Welch on 7/9/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import Foundation

class CategoryController {
    
    static let shared = CategoryController()
    private let baseURL = URL(string: "https://bwhowto.herokuapp.com/api/")!
    
    var userID: Int?
    var token: String?
    
}
