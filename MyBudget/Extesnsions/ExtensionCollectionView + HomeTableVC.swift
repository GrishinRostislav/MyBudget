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
            return countOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       cellTaped(data: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let vc = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath) as! CollectionViewCell
        
        switch currentTag {
        case 0:
            vc.nameOfCell.text = incomeList[indexPath.row].name
            vc.currencyCell.text = incomeList[indexPath.row].currency
            vc.totalCount.text = String(incomeList[indexPath.row].total)
        case 1:
            vc.nameOfCell.text = walletList[indexPath.row].name
            vc.currencyCell.text = walletList[indexPath.row].currency
            vc.totalCount.text = String(walletList[indexPath.row].total)
//        case 2:
//            vc.nameOfCell.text = walletList[indexPath.row].name
//            vc.currencyCell.text = walletList[indexPath.row].currency
//            vc.totalCount.text = walletList[indexPath.row].currency
        case 3:
            vc.nameOfCell.text = expenseList[indexPath.row].name
            vc.currencyCell.text = expenseList[indexPath.row].currency
            vc.totalCount.text = String(expenseList[indexPath.row].total)
        default:
            print("Error")
        }
        vc.delegate = self
        return vc
    }
}

extension HomeTableVC: TableViewInsideCollectionViewDelegate {
    func cellTaped(data: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "details") as! DeteilViewController
        detailVC.name = data.row
        self.window?.rootViewController?.present(detailVC, animated: true, completion: nil)
        
    }
}
