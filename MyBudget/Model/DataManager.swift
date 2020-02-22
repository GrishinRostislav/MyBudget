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
    
    static func saveNewWallets(wallet: [Wallet]) {
        try! realm.write {
            realm.add(wallet)
        }
    }
    
    static func saveNewIncoms(incomes: [Income]){
        try! realm.write {
            realm.add(incomes)
        }
    }
    
    static func saveNewExpens(expens: [Expens]){
        try! realm.write {
            realm.add(expens)
        }
    }
}
