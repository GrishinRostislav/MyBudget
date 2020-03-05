//
//  HomeScreenVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 22.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift

//var currentUser: UserData?

class MyTapGesture: UITapGestureRecognizer {
    var typeOfCategory: String = ""
}

class HomeScreenVC: UIViewController {
    
    static let shared = HomeScreenVC()
    
    var dataManager = DataManager()
    
    @IBOutlet weak var balanceTotal: UILabel!
    @IBOutlet weak var expensTotal: UILabel!
    @IBOutlet weak var prognozTotal: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var incomeStack: UIStackView!
    @IBOutlet weak var walletStack: UIStackView!
    @IBOutlet weak var goalSteck: UIStackView!
    @IBOutlet weak var expensStack: UIStackView!
    @IBOutlet weak var darkGround: UIView!
    
    var myTimer: Timer?
    
    //TODO: check variables, maybe it is not needed
    var walletList: List<Wallet>!
    var incomeList: List<Income>!
    var expenseList: List<Expens>!
    var goalList: List<Goal>!
    //---------------------------------------------
    
    //MARK: menu values
    var stacksArray: [UIStackView]!
    var heightStack: CGFloat!
    var extraSpecing: CGFloat = 5
    var isDown = false
    //-----------------------------
    
    let newCategotyIndentifier = "CreateNewCategory"
    
    var haederName = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if !isDown {
            return .darkContent
        } else {
        return .lightContent
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        heightStack = incomeStack.frame.size.height + extraSpecing
        stacksArray = [incomeStack, walletStack, goalSteck, expensStack]
        
        setTagForStack()
        
      //  setTimer()
        configureTableView()
        createTapGestures()
        tapGestureOnBackground()
        
        walletList = dataManager.getWallets()
        incomeList = dataManager.getIncome()
        expenseList = dataManager.getExpens()
        goalList = dataManager.getGoals()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    //MARK: Timer with interval for refresh Data
//    private func setTimer() {
//        self.myTimer = Timer(timeInterval: 30.0, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
//        RunLoop.main.add(self.myTimer!, forMode: .default)
//    }

     func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("tableview updated")
        }
    }
    //-------------------------------------

    //MARK: find tap for specialize catagory
    func createTapGestures() {
        for index in 0...stacksArray.count - 1 {
            let stack = stacksArray[index]
            let tapOfCategory = MyTapGesture.init(target: self, action: #selector(createNewCategoryVC))
            tapOfCategory.typeOfCategory = DataManager.getCategory(index: index)
            stack.isUserInteractionEnabled = true
            stack.addGestureRecognizer(tapOfCategory)
        }
    }
    
    func tapGestureOnBackground() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnViewBlack))
        darkGround.isUserInteractionEnabled = true
        darkGround.addGestureRecognizer(tap)
    }
    @objc func tapOnViewBlack() {
        isDown.toggle()
        showOrHideMenu(isHide: isDown)
    }
    
    @objc func createNewCategoryVC(sender: MyTapGesture) {
        let vc = storyboard?.instantiateViewController(withIdentifier: newCategotyIndentifier) as! NewCategoryVC
        vc.category = sender.typeOfCategory
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        _ = unwindSegue.source
        isDown.toggle()
        showOrHideMenu(isHide: isDown)
    }
    
    @IBAction func unwindToDetails(_ unwindSegue: UIStoryboardSegue) {
       // let sourceViewController = unwindSegue.source
    }
    
    func configureTableView() {
        self.tableView.tableFooterView = UIView()
    
        let headerNib = UINib.init(nibName: "HeaderViewInSection", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderViewInSection")
        tableView.alwaysBounceVertical = false
    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        isDown.toggle()
        showOrHideMenu(isHide: isDown)
    }
    
    func showOrHideMenu(isHide: Bool) {
        if isHide { showMenu() }
        else {
            hideMenu()
        }
    }
    
    func setTagForStack() {
        for index in 0...stacksArray.count - 1 {
            stacksArray[index].tag = index
        }
    }
    
    func showMenu() {
        addButton.tintColor = .white
        self.toggleItems()
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.configureStacks(array: self.stacksArray, isHide: self.isDown)
            self.addButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)
        }
    }
    
    func hideMenu() {
        addButton.tintColor = .black
        UIView.animate(withDuration: 0.5, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
            self.addButton.transform = CGAffineTransform.identity
            self.configureStacks(array: self.stacksArray, isHide: self.isDown)
        }) { (_) in
            self.toggleItems()
        }
    }
    
    func configureStacks(array: [UIStackView], isHide: Bool) {
        if isHide {
            for index in 0...array.count - 1 {
                array[index].alpha = 1
                array[index].frame.origin.y += self.heightStack * CGFloat(index + 1)
            }
            self.darkGround.alpha = 0.9
        } else {
            for index in 0...array.count - 1 {
                array[index].alpha = 0
                array[index].frame.origin.y -= self.heightStack * CGFloat(index + 1)
            }
            self.darkGround.alpha = 0
        }
    }
    
    func toggleItems() {
        self.incomeStack.isHidden.toggle()
        self.walletStack.isHidden.toggle()
        self.goalSteck.isHidden.toggle()
        self.expensStack.isHidden.toggle()
        self.darkGround.isHidden.toggle()
    }
}

