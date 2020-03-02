//
//  EditViewController.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 02.03.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {
    
    var indexForDelet: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func deletCategory(_ sender: UIButton) {
        DataManager.deletWallet(index: indexForDelet)
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
