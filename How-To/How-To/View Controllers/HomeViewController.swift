//
//  HomeViewController.swift
//  How-To
//
//  Created by Audrey Welch on 7/8/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var guidesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        GuideController.shared.fetchGuides(completion: { (guides) in
            print(guides)
        })
        
        guidesCollectionView.delegate = self
        guidesCollectionView.dataSource = self

    }
    
    // MARK: - Collection View Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        //return GuideController.shared.guides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GuideCollectionViewCell.reuseIdentifier, for: indexPath) as! GuideCollectionViewCell
        
        //guard let guide = GuideController.shared.guides[indexPath.row] else { return cell }
        
        //cell.guideNameLabel.alpha = 0.75
        
        cell.guideNameLabel.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
}

