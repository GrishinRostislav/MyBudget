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

   
    @IBOutlet weak var logo: UITextField!
    
    @IBOutlet weak var nameCategoryTF: UITextField!
    @IBOutlet weak var currencyOfCategory: UIButton!
    @IBOutlet weak var addNewSubCategoryBTN: UIButton!
    @IBOutlet weak var summOrLimite: UITextField!
    
    let dataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    var listOfSubCategories = [String]()
    
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        choiseUI(category: category)
    }
    
    func saveNewItemToDataBase(nameCategory: String) {
        if summOrLimite.text?.count == 0 { summOrLimite.text = "0" }
        guard let total = Int(summOrLimite.text!) else {return}
        guard let name = nameCategoryTF.text else {return}
        guard let currency = currencyOfCategory.titleLabel?.text else {return }
        var newElement: Object?
        let getRandom = Int.random(in: 0...100000)
        let setId = "\(name)\(getRandom)"
        let logoItem = logo.text?.first
        let symbol = (logoItem != nil) ? String(logoItem!) : ""
        print("Created symbol: ", symbol)
        
        switch nameCategory {
        case wallet:
            newElement = Wallet(value: ["name": name, "amount": total, "currency": currency, "id": setId, "logo": symbol])
        case income:
            let mynewElement = Income(value: ["name": name, "total": total, "currency": currency, "id": setId, "logo": symbol])
            newElement = mynewElement
        case goal:
            newElement = Goal(value: ["name": name, "currency": currency, "goal": total, "id": setId, "logo": symbol])
        case expense:
            newElement = Expens(value: ["name": name, "budget": total, "currency": currency, "id": setId, "logo": symbol])
        default:
            return print("error")
        }
        DispatchQueue(label: "background").async {
            autoreleasepool {
                guard let item = newElement else {return}
                self.dataManager.saveData(list: item)
            }
        }
        dismiss(animated: true) {
            
        }
    }
    
    func choiseUI(category: String) {
        switch category {
        case wallet:
            setUIForWallet()
        case income:
            setUIForIncome()
        case goal:
            setUIForGoal()
        case expense:
            setUIForExpense()
        default:
            print("Error")
        }
    }
    
    func setUIForIncome() {
       
        nameCategoryTF.isHidden = false
        currencyOfCategory.isHidden = false
        summOrLimite.isHidden = true
    }
    
    func setUIForWallet() {
        
        nameCategoryTF.isHidden = false
        currencyOfCategory.isHidden = false
        summOrLimite.isHidden = false
        tableView.isHidden = true
    }
    
    func setUIForGoal() {
       
        nameCategoryTF.isHidden = false
        currencyOfCategory.isHidden = false
        summOrLimite.isHidden = false
    }
    
    func setUIForExpense() {
        
        nameCategoryTF.isHidden = false
        currencyOfCategory.isHidden = false
        summOrLimite.isHidden = false
    }
    

    @IBAction func cancel(_ sender: UIButton) {
    }
    
    @IBAction func saveToDataBase(_ sender: UIButton) {
        saveNewItemToDataBase(nameCategory: category)
    }
    
    @IBAction func changeCurrency(_ sender: UIButton) {
        let title = currencyOfCategory.titleLabel?.text == "₪" ? "$" : "₪"
        currencyOfCategory.setTitle(title, for: .normal)
    }
    
    @IBAction func addSubTapped(_ sender: UIButton) {
        showAlert(title: "New Subcategory", message: "")
    }
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        // Save action
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let newValue = alert.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            
            self.listOfSubCategories.append(newValue)
            self.tableView.insertRows(at: [IndexPath(row: self.listOfSubCategories.count - 1, section: 0)], with: .automatic)
        }
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                self.tableView.deselectRow(at: indexPath, animated: true)
//            }
        }
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
}

extension NewCategoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfSubCategories.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listOfSubCategories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategories", for: indexPath)
        cell.textLabel?.text = listOfSubCategories[indexPath.row]
        return cell
    }
    
}
