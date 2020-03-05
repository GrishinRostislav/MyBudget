//
//  DeteilViewController.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 02.03.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit

class DeteilViewController: UIViewController {

    @IBOutlet weak var nameOfLabel: UILabel!
    var name: Int!
    var currentTag: Int!
    var nameOfItem: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfLabel.text = nameOfItem
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .black
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EditViewController
        vc.indexForDelet = name
        vc.indexForCategory = currentTag
        vc.nameDelete = nameOfItem
    }
}
