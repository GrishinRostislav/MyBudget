//
//  Transaction.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 12.03.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import RealmSwift

class Transaction: Object {
    @objc dynamic var source = ""
    @objc dynamic var destination = ""
    @objc dynamic var sourceLogo = ""
    @objc dynamic var imageLogo: Data?
    @objc dynamic var destinationLogo = ""
    @objc dynamic var currency = "$"
    @objc dynamic var amount = 0
    @objc dynamic var comment = ""
    @objc dynamic var tag = ""
}
