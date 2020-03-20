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
        
       // getNameOfCategory = DataManager.getCategory(index: indexForCategory)
    }
    
    @IBAction func deletCategory(_ sender: UIButton) {
        
        DataManager.deleteItem(nameCategory: getNameOfCategory, index: indexForDelet)

    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

