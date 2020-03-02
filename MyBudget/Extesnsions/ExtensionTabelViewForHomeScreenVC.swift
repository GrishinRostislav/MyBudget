//
//  extensionTabelView.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 25.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift
//MARK: extension for tableView

extension HomeScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Static number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    //MARK: Static height of header in section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    //MARK: Set dynamic height in last section in row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let result = calcuateHeigh() //get dynamic height for row in last section
        let getSection = indexPath.section
        return getSection == 3 ? result : 100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderViewInSection") as! HeaderViewInSection

        switch section {
        case 0:
            myView.nameOfSection.text = "Доходы"
            var result = 0
            for incom in incomeList {
                result += incom.total
            }
            myView.countOfSection.text = String(result)
        case 1:
            myView.nameOfSection.text = "Кошельки"
            var result = 0
            for incom in walletList {
                result += incom.total
            }
            myView.countOfSection.text = String(result)
        case 2:
            myView.nameOfSection.text = "Цели"
            let result = 0
            myView.countOfSection.text = String(result)
        case 3:
            myView.nameOfSection.text = "Расходы"
            var result = 0
            for incom in expenseList {
                result += incom.total
            }
            myView.countOfSection.text = String(result)
        default:
            print("error")
        }

        return myView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let getSection = indexPath.section
        
        HomeTableVC.currentSection = getSection
        let vc = tableView.dequeueReusableCell(withIdentifier: "wallet", for: indexPath) as! HomeTableVC
        vc.awakeFromNib()
     
        return vc
    }

    //MARK: calculate a heigh for row in last section
    func calcuateHeigh() -> CGFloat{
        let headerHeight: CGFloat = 35 * 4
        let cellHeight: CGFloat = 3 * 100
        let tableViewHeight = tableView.frame.size.height

        return tableViewHeight - headerHeight - cellHeight
    }
}
