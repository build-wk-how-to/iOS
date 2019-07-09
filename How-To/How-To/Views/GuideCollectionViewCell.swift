//
//  GuideCollectionViewCell.swift
//  How-To
//
//  Created by Audrey Welch on 7/8/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class GuideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var guideImageView: UIImageView!
    @IBOutlet weak var guideNameLabel: UILabel!
    
    static let reuseIdentifier = "guideCollectionCell"
}
