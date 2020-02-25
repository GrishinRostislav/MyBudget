//
//  ButtonsAppearence.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 24.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//
import UIKit

extension UIButton {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
}
