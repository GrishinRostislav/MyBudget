//
//  Wallet.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 20.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import RealmSwift

class Wallet: Object {
    @objc dynamic var name = ""
    @objc dynamic var logo = ""
    @objc dynamic var imageLogo: Data?
    @objc dynamic var currency = "$"
    @objc dynamic var amount = 0
    @objc dynamic var total = 0
    @objc dynamic var id = ""
    var transactions = List<Transaction>()
}
