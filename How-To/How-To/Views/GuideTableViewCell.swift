//
//  GuidesTableViewCell.swift
//  How-To
//
//  Created by Audrey Welch on 7/8/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class GuideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var guideNameLabel: UILabel!
    @IBOutlet weak var guideUserNameLabel: UILabel!
    @IBOutlet weak var guideTags: UILabel!
    @IBOutlet weak var guideImage: UIImageView!
    @IBOutlet weak var guideImage2: UIImageView!
    
    static let reuseIdentifier = "guideTableCell"
}
