//
//  ExtensionCollectionView + HomeTableVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 26.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit

extension HomeTableVC: UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: calculate number items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return countOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellTaped(data: indexPath, collectionView: collectionView)
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
        case 2:
            vc.nameOfCell.text = goalList[indexPath.row].name
            vc.currencyCell.text = goalList[indexPath.row].currency
            vc.totalCount.text = String(goalList[indexPath.row].total)
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
    
    func cellTaped(data: IndexPath, collectionView: UICollectionView) {
        var cell: Any
        switch collectionView.tag {
        case 0:
            cell = incomeList[data.row]
        case 1:
            cell = walletList[data.row]
        case 2:
            cell = goalList[data.row]
        case 3:
            cell = expenseList[data.row]
        default:
            return
        }
        
      //  let cell = expenseList[data.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "details") as! DeteilViewController
        
        detailVC.name = data.row
        print("index is:", data.row)
        detailVC.currentTag = collectionView.tag
        print(collectionView.tag)
        detailVC.nameOfItem = (cell as AnyObject).name
        self.window?.rootViewController?.present(detailVC, animated: true, completion: nil)
    }
}
