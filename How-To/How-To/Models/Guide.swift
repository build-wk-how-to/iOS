//
//  Guide.swift
//  How-To
//
//  Created by Audrey Welch on 7/9/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import Foundation

struct Guide: Codable {
    
    let guideID: Int
    let guideName: String
    let owner: Int
    let guideContent: String
    let category: Int? // CategoryID
    
}
