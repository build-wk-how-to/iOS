//
//  SearchViewController.swift
//  How-To
//
//  Created by Audrey Welch on 7/8/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Delegate
        searchBar.delegate = self
    }
}
