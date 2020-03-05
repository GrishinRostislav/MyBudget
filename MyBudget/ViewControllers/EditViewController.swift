//
//  EditViewController.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 02.03.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {
    
    var indexForDelet: Int!
    var indexForCategory: Int!
    var getNameOfCategory: String!
    var nameDelete: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNameOfCategory = DataManager.getCategory(index: indexForCategory)
    }
    
    @IBAction func deletCategory(_ sender: UIButton) {
        
        switch getNameOfCategory {
        case "Income":
            DataManager.deletIncome(index: indexForDelet)
            HomeTableVC.reloadItemAtIndex = indexForDelet
            HomeTableVC.deleteFromView = 0
        case "Wallet":
            DataManager.deletWallet(index: indexForDelet)
            HomeTableVC.reloadItemAtIndex = indexForDelet
            HomeTableVC.deleteFromView = 1
        case "Goal":
            DataManager.deletGoal(index: indexForDelet)
            HomeTableVC.reloadItemAtIndex = indexForDelet
            HomeTableVC.deleteFromView = 2
        case "Expense":
            DataManager.deletExpense(name: nameDelete)
            HomeTableVC.reloadItemAtIndex = indexForDelet
            HomeTableVC.deleteFromView = 3
        default:
            print("error")
        }
    }
}

