//
//  HeaderView.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 25.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit

class HeaderViewInSection: UITableViewHeaderFooterView {

    @IBOutlet weak var countOfSection: UILabel!
    @IBOutlet weak var nameOfSection: UILabel!
    @IBOutlet weak var currenceOfSection: UILabel!

    override func awakeFromNib() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = hexStringToUIColor(hex: "EBEBEB")
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
