//
//  HomeScreenVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 22.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var tblItems: UITableView!
    
    var isDown = false

    override func viewDidLoad() {
        super.viewDidLoad()
  
        let headerNib = UINib.init(nibName: "HeaderViewInSection", bundle: Bundle.main)
        tblItems.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderViewInSection")
        
        tblItems.rowHeight = UITableView.automaticDimension
        tblItems.estimatedRowHeight = 600
        
    }
}




