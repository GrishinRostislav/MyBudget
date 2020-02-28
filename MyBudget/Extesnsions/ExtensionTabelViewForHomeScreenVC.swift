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
    
    //TODO: dynamic height for last section in row, need to get size from section to safe area
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let headerHeight: CGFloat = 35 * 4
        let cellHeight: CGFloat = 3 * 100
        let tableViewHeight = tableView.frame.size.height
        print(tableViewHeight)
        let result = tableViewHeight - headerHeight - cellHeight
        let getSection = indexPath.section
        return getSection == 3 ? result : 100
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderViewInSection") as! HeaderViewInSection
        
        myView.nameOfSection.text = "HEllo"
        return myView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let getSection = indexPath.section
        HomeTableVC.currentSection = getSection
        
        let vc = tableView.dequeueReusableCell(withIdentifier: "wallet", for: indexPath) as! HomeTableVC
        
        return vc
    }
}
