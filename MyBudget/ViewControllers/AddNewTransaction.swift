//
//  AddNewTransaction.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 11.03.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewTransaction: UIViewController {
    
    var dataManager = DataManager()
    
    var destination: String!
    var destinationIndex: Int!
    var source: String!
    var sourceIndex: Int!
    
    var incomeItem: Income!
    var walletItem: Wallet!
    var goalItem: Goal!
    var expenseItem: Expens!
    var transaction: Transaction!
    
    var sourceID: String!
    var destinationID: String!
    
    @IBOutlet weak var typeTotal: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        let number = Int(typeTotal.text!) ?? 0
        
        
        DispatchQueue(label: "background").async {
            print("Save!!!!")
            
            self.getItem(nameOfCategory: self.source, with: self.sourceIndex)
            self.getItem(nameOfCategory: self.destination, with: self.destinationIndex)
            
            self.transaction = Transaction(value: ["amount": number, "source": self.sourceID ?? "", "destination": self.destinationID ?? ""])
            autoreleasepool {
                let realm = try! Realm()
                if self.incomeItem != nil && self.walletItem != nil {
                    try! realm.write {
                        self.incomeItem.amount += number
                        self.walletItem.amount += number
                        self.walletItem.transactions.append(self.transaction)
                        self.incomeItem.transactions.append(self.transaction)
                    }
                }else if self.walletItem != nil && self.goalItem != nil {
                    
                    try! realm.write {
                        self.goalItem.amount += number
                        self.walletItem.amount -= number
                        self.walletItem.transactions.append(self.transaction)
                        self.goalItem.transactions.append(self.transaction)
                    }
                } else if self.walletItem != nil && self.expenseItem != nil {
                    
                    try! realm.write {
                        self.expenseItem.amount += number
                        self.walletItem.amount -= number
                        self.walletItem.transactions.append(self.transaction)
                        self.expenseItem.transactions.append(self.transaction)
                        
                    }
                } else if self.walletItem != nil {
                    
                    try! realm.write {
                        self.walletItem.amount += number
                        self.walletItem.transactions.append(self.transaction)
                        self.getItem(nameOfCategory: self.source, with: self.sourceIndex)
                        self.walletItem.amount -= number
                        self.walletItem.transactions.append(self.transaction)
                    }
                    
                } else if self.goalItem != nil {
                    
                    try! realm.write {
                        self.goalItem.amount += number
                        self.goalItem.transactions.append(self.transaction)
                        self.getItem(nameOfCategory: self.source, with: self.sourceIndex)
                        self.goalItem.amount -= number
                        self.goalItem.transactions.append(self.transaction)
                    }
                }else if self.incomeItem != nil {
                    
                    try! realm.write {
                        self.incomeItem.amount += number
                        self.incomeItem.transactions.append(self.transaction)
                        self.getItem(nameOfCategory: self.source, with: self.sourceIndex)
                        self.incomeItem.amount -= number
                        self.incomeItem.transactions.append(self.transaction)
                    }
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension AddNewTransaction {
    
    func getItem(nameOfCategory: String, with index: Int){
        switch nameOfCategory {
        case income:
            print("Income")
            incomeItem = getIncome(index: index)
        case wallet:
            print("Wallet")
            walletItem = getWallet(index: index)
        case goal:
            goalItem = getGoal(index: index)
        case expense:
            expenseItem = getExpense(index: index)
        default:
            print("Error")
        }
    }
    
    func getIncome(index: Int) -> Income {
        let realm = try! Realm()
        let user = realm.objects(UserData.self)[0]
        return user.incomes[index]
    }
    
    func getWallet(index: Int) -> Wallet {
        let realm = try! Realm()
        let user = realm.objects(UserData.self)[0]
        return user.wallets[index]
    }
    
    func getGoal(index: Int) -> Goal {
        let realm = try! Realm()
        let user = realm.objects(UserData.self)[0]
        return user.goals[index]
    }
    
    func getExpense(index: Int) -> Expens {
        let realm = try! Realm()
        let user = realm.objects(UserData.self)[0]
        return user.expense[index]
    }
}
