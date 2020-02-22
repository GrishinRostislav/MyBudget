//
//  Income.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 20.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//
import RealmSwift

class Income: Object {
    @objc dynamic var name = ""
    @objc dynamic var logo: Data?
    @objc dynamic var currency = "$"
    @objc dynamic var total = 0
}
