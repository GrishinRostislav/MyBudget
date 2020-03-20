//
//  SubCategory.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 19.03.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import RealmSwift

class SubCategory: Object {
    @objc dynamic var name = ""
    @objc dynamic var logo = ""
    @objc dynamic var imageLogo: Data?
    @objc dynamic var amount = 0
    @objc dynamic var budget = 0
    @objc dynamic var id = ""
    var transactions = List<Transaction>()
}
