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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellSize = CGSize(width:100 , height:100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 5.0, bottom: 1, right: 5.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewID")
        collectionView.isPagingEnabled = true
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}


