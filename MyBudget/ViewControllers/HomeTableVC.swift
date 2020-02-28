//
//  HomeTableVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 26.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit

class HomeTableVC: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var nameCollection = ["Зарплата", "Freelance", "BitCoin", "Халтура", "Web site",
                          "Зарплата", "Freelance", "BitCoin", "Халтура", "Web site",
                          "Зарплата", "Freelance", "BitCoin", "Халтура",]
    
    static var currentSection: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let layout = setCollectionViewSettings(section: HomeTableVC.currentSection ?? 0)
        
        self.collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewID")
       // collectionView.isPagingEnabled = true
        //TODO: write code for peging good style
        collectionView.setCollectionViewLayout(layout, animated: true)        
    }
    
    func setCollectionViewSettings(section: Int) -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let cellSize = CGSize(width:100 , height:100)
        layout.itemSize = cellSize
        
        if section == 3 {
            layout.scrollDirection = .vertical
        } else {
            layout.scrollDirection = .horizontal
        }
        layout.sectionInset = UIEdgeInsets(top: 1, left: 5.0, bottom: 1, right: 5.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    
        return layout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}


