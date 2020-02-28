//
//  HomeScreenVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 22.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var incomeStack: UIStackView!
    @IBOutlet weak var walletStack: UIStackView!
    @IBOutlet weak var goalSteck: UIStackView!
    @IBOutlet weak var expensStack: UIStackView!
    @IBOutlet weak var darkGround: UIView!
    var heightStack: CGFloat?
    var isDown = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if !isDown {
            return .darkContent
        } else {
        return .lightContent
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        heightStack = incomeStack.frame.size.height + 5
    }
    
    func configureTableView() {
        self.tableView.tableFooterView = UIView()
    
        let headerNib = UINib.init(nibName: "HeaderViewInSection", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderViewInSection")
        tableView.alwaysBounceVertical = false
        
    }
    

    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let height = heightStack else {return}
        
        isDown.toggle()
        
        if isDown {
            sender.tintColor = .white
            incomeStack.isHidden = false
            walletStack.isHidden = false
            goalSteck.isHidden = false
            expensStack.isHidden = false
            darkGround.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.setNeedsStatusBarAppearanceUpdate()
                self.incomeStack.frame.origin.y += height
                self.walletStack.frame.origin.y += height * 2
                self.goalSteck.frame.origin.y += height * 3
                self.expensStack.frame.origin.y += height * 4
                self.incomeStack.alpha = 1
                self.walletStack.alpha = 1
                self.goalSteck.alpha = 1
                self.expensStack.alpha = 1
                self.darkGround.alpha = 0.9
                sender.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)
            }
        } else {
            sender.tintColor = .black
            
            UIView.animate(withDuration: 0.5, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
                sender.transform = CGAffineTransform.identity
                self.incomeStack.frame.origin.y -= height
                  self.walletStack.frame.origin.y -= height * 2
                  self.goalSteck.frame.origin.y -= height * 3
                  self.expensStack.frame.origin.y -= height * 4
                self.incomeStack.alpha = 0
                self.walletStack.alpha = 0
                self.goalSteck.alpha = 0
                self.expensStack.alpha = 0
                self.darkGround.alpha = 0
                  
            }) { (_) in
                self.incomeStack.isHidden = true
                self.walletStack.isHidden = true
                self.goalSteck.isHidden = true
                self.expensStack.isHidden = true
                self.darkGround.isHidden = true
            }

        }
        
    }
}
