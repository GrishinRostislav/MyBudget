//
//  ExtensionCollectionView + HomeTableVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 26.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit

extension HomeTableVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let vc = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath) as! CollectionViewCell
        return vc
    }
}
