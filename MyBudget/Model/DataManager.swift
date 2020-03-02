//
//  DataManager.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 20.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//
import RealmSwift

let realm = try! Realm()

class DataManager {
 
    static func getCategory(index: Int) -> String {
        let categories = ["Income", "Wallet", "Goal", "Expense"]
        return categories[index]
    }
    
    //MARK: Save data
    static func saveNewWallets(wallet: Wallet) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let users = realm.objects(UserData.self)
                try! realm.write {
                    users[0].wallets.append(wallet)
                }
            }
        }
    }

    static func saveNewIncoms(incomes: Income){
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let users = realm.objects(UserData.self)
                try! realm.write {
                    users[0].incomes.append(incomes)
                }
            }
        }
    }
    
    static func saveNewExpens(expens: Expens){
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let users = realm.objects(UserData.self)
                try! realm.write {
                    users[0].expense.append(expens)
                }
            }
        }
    }
    //-------------------------------------------------------
    //MARK: Delete Data
    static func deletWallet(index: Int) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let users = realm.objects(UserData.self)
                try! realm.write {
                    users[0].wallets.remove(at: index)
                }
            }
        }
    }
    //-------------------------------------------------------
    //MARK: Get Data
    func getWallets() -> List<Wallet>{
        let myUser = realm.objects(UserData.self)[0]
        return myUser.wallets
    }
    func getIncome() -> List<Income>{
        let myUser = realm.objects(UserData.self)[0]
        return myUser.incomes
    }

    func getExpens() -> List<Expens>{
        let myUser = realm.objects(UserData.self)[0]
        return myUser.expense
    }
    
    
    
}
