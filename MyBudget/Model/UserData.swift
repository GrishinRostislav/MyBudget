//
//  UserData.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 20.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//
import RealmSwift

class UserData: Object {
    @objc dynamic var email = String()
    @objc dynamic var password = String()
    @objc dynamic var isOnline = false
    var incomes = List<Income>()
    var wallets = List<Wallet>()
    var goal = List<Goal>()
    var expense = List<Expens>()
}
