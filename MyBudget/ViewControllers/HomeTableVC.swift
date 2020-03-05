//
//  HomeTableVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 26.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift

class HomeTableVC: UITableViewCell {

    static let shared = HomeTableVC()

    @IBOutlet weak var collectionView: UICollectionView!
    
    //TODO: understand how find this index and set 
    var currentUser = realm.objects(UserData.self)[0]
    var countOfItems = 0

    static var reloadItemAtIndex: Int!
    static var deleteFromView: Int!
    var currentTag = 0
    var tagmy = 3
    
    var walletList = List<Wallet>()
    var incomeList = List<Income>()
    var expenseList = List<Expens>()
    var goalList = List<Goal>()

    static var currentSection: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let layout = setCollectionViewSettings(section: HomeTableVC.currentSection ?? 0)
        print("Collection view")
        self.collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewID")
        //collectionView.isPagingEnabled = true
        //TODO: write code for peging good style
        deleteFromCollectionVIew()
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func deleteFromCollectionVIew(){
        if let index = HomeTableVC.reloadItemAtIndex {
            if collectionView.tag == HomeTableVC.deleteFromView {
                print("reload")
                collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
                collectionView.remembersLastFocusedIndexPath = false
             HomeTableVC.reloadItemAtIndex = nil
            }
        }
    }
    
    
    func setCollectionViewSettings(section: Int) -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let cellSize = CGSize(width:80 , height:100)
        layout.itemSize = cellSize
        
        switch section {
        case 0:
            countOfItems = currentUser.incomes.count
            incomeList = currentUser.incomes
            currentTag = 0
            collectionView.tag = 0
        case 1:
            countOfItems = currentUser.wallets.count
            walletList = currentUser.wallets
            currentTag = 1
            collectionView.tag = 1
        case 2:
            countOfItems = currentUser.goal.count
            goalList = currentUser.goal
            currentTag = 2
            collectionView.tag = 2
        case 3:
            countOfItems = currentUser.expense.count
            expenseList = currentUser.expense
            currentTag = 3
            collectionView.tag = 3
        default:
            countOfItems = 0
        }
        
        if section == 3 {
            layout.scrollDirection = .vertical
        } else {
            layout.scrollDirection = .horizontal
        }
        layout.sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
    
        return layout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}


