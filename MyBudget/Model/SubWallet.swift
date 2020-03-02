//
//  SubWallet.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 01.03.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import RealmSwift

class SubWallet: Object{
    @objc dynamic var nameOfSubCatagory = ""
    @objc dynamic var date = ""
    @objc dynamic var currency = ""
    @objc dynamic var currentValue = ""
}
