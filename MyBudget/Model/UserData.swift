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
    var wallets = List<Wallet>()
    var incomes = List<Income>()
    var expense = List<Expens>()
}
