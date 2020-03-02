//
//  NewCategoryVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 29.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift

class NewCategoryVC: UIViewController {

    @IBOutlet weak var nameOfCatagory: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var nameCategoryTF: UITextField!
    @IBOutlet weak var currencyOfCategory: UIButton!
    @IBOutlet weak var addNewSubCategoryBTN: UIButton!
    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet weak var summOrLimite: UITextField!
    
    @IBOutlet weak var tableView: UITableView!

    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        choiseUI(category: category)
    }

    func saveNewItemToDataBase(nameCategory: String) {
        if summOrLimite.text?.count == 0 { summOrLimite.text = "0" }
        guard let total = Int(summOrLimite.text!) else {return}
        guard let name = nameCategoryTF.text else {return}
        
        switch nameCategory {
        case "Wallet":
            let newWallet = Wallet(value: ["name": name, "total": total])
            DispatchQueue(label: "background").async {
                autoreleasepool {
                    DataManager.saveNewWallets(wallet: newWallet)
                }
            }
        case "Income":
            let newWallet = Income(value: ["name": name, "total": total])
            DispatchQueue(label: "background").async {
                autoreleasepool {
                    DataManager.saveNewIncoms(incomes: newWallet)
                }
            }
        case "Expens":
            let newWallet = Expens(value: ["name": name, "total": total])
            DispatchQueue(label: "background").async {
                autoreleasepool {
                    DataManager.saveNewExpens(expens: newWallet)
                }
            }
        default:
           return print("error")
        }
    }
    
    func choiseUI(category: String) {
        switch category {
        case "Wallet":
            print("")
        case "Income":
            setincomeUI()
        default:
            print("Error")
        }
    }
    
    func setincomeUI(){
        nameOfCatagory.text = "Новая категория дохода"
        summOrLimite.isHidden = true
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveToDataBase(_ sender: UIButton) {
        saveNewItemToDataBase(nameCategory: category)
        dismiss(animated: true, completion: nil)
    }
}

extension NewCategoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategories", for: indexPath)
        cell.textLabel?.text = "NewSubCategory"
        return cell
    }
}
