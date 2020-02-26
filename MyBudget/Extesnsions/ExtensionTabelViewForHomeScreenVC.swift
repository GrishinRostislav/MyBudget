//
//  extensionTabelView.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 25.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit 

extension HomeScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderViewInSection") as! HeaderViewInSection
        
        myView.nameOfSection.text = "HEllo"
        myView.backgroundColor = .blue
        return myView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO seder with cells
        let getSection = indexPath.section
        
        if getSection == 0 {
            let vc = tableView.dequeueReusableCell(withIdentifier: "wallet", for: indexPath) as! HomeTableVC
            return vc
        } else {
            let vc = tableView.dequeueReusableCell(withIdentifier: "wallet", for: indexPath)
            return vc
        }
    }
}
