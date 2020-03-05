//
//  protocolCell.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 02.03.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//
import UIKit

protocol TableViewInsideCollectionViewDelegate:class {
    func cellTaped(data:IndexPath, collectionView: UICollectionView)
}
