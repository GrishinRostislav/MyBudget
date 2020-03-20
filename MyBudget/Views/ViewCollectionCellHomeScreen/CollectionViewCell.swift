//
//  CollectionViewCell.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 26.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var topCanstraint: NSLayoutConstraint!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var textLogo: UILabel!
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var logoCell: UIImageView!
    @IBOutlet weak var nameOfCell: UILabel!
    @IBOutlet weak var viewFrame: UIView!
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var currencyCell: UILabel!
    
    
    @IBOutlet weak var budget: UILabel!
    
    var typeOfCell = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewFrame.layer.cornerRadius = viewFrame.frame.size.height / 2


    }
}


