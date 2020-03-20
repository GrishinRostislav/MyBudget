//
//  HomeScreenVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 22.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift

class HomeScreenVC: UIViewController, UINavigationControllerDelegate {
    
    var dataManager = DataManager()
    
    //MARK: Collection Views
    @IBOutlet weak var collectionViewIncome: UICollectionView!
    @IBOutlet weak var collectionViewWallets: UICollectionView!
    @IBOutlet weak var collectionViewGoals: UICollectionView!
    @IBOutlet weak var collectionViewExpense: UICollectionView!
    var collectionViewsArray: [UICollectionView]!
    var currentCollectionView: UICollectionView?
    //========================
    
    
    @IBOutlet weak var headerIncome: UILabel!
    @IBOutlet weak var headerWallet: UILabel!
    @IBOutlet weak var headerGoal: UILabel!
    @IBOutlet weak var headerExpense: UILabel!
    
    @IBOutlet weak var youNeed: UILabel!
    
    
    @IBOutlet weak var balanceOnTop: UILabel!
    @IBOutlet weak var expensOnTop: UILabel!
    @IBOutlet weak var plannedOnTop: UILabel!
    
    @IBOutlet var currencyGlobal: [UILabel]!
    
    @IBOutlet weak var totalIncome: UILabel!
    @IBOutlet weak var totalWallet: UILabel!
    @IBOutlet weak var totalGoal: UILabel!
    @IBOutlet weak var totalExpense: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var expenseButton: UIButton!
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var walletButton: UIButton!
    @IBOutlet weak var goalButton: UIButton!
    
    @IBOutlet weak var viewTitle: UIView!
    
    @IBOutlet weak var darkGround: UIView!
    
    var myTimer: Timer?
    var typeOfCategoryFrom: String!
    var sourceIndex: Int!
    var sourceItem: Any!
    var sourceID: String!
    var destinationID: String!
    
    //TODO: check variables, maybe it is not needed
    var walletList: List<Wallet>?
    var incomeList: List<Income>?
    var expenseList: List<Expens>?
    var goalList: List<Goal>?
    //---------------------------------------------
    
    //MARK: menu values
    var buttonsArray: [UIButton]!
    var heightStack: CGFloat!
    var extraSpecing: CGFloat = 5
    var isDown = false
    //-----------------------------
    
    let layout = UICollectionViewFlowLayout()
    let screenSize = UIScreen.main.bounds
    
    let headerCategory = "HeaderViewInSection"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerIncome.text = income
        totalIncome.text = "0"
        headerWallet.text = wallet
        totalWallet.text = "0"
        headerGoal.text = goal
        totalGoal.text = "0"
        headerExpense.text = expense
        totalExpense.text = "0"
        
        balanceOnTop.text = "0 \(nis)"
        expensOnTop.text = "0 \(nis)"
        plannedOnTop.text = "0 \(nis)"
        
        
        registerCellsInCollectionViews()
        heightStack = incomeButton.frame.size.height + extraSpecing
        createArrays()
        
        setTagForStack()
        
        walletList = dataManager.getWallets()
        incomeList = dataManager.getIncomes()
        expenseList = dataManager.getExpens()
        goalList = dataManager.getGoals()
        
        self.navigationController?.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        collectionViewIncome.reloadData()
        collectionViewWallets.reloadData()
        collectionViewGoals.reloadData()
        collectionViewExpense.reloadData()
        
        totalIncome.text = dataManager.getTotalIncome()
        totalWallet.text = dataManager.getTotalWallets()
        balanceOnTop.text = totalWallet.text
        totalGoal.text = dataManager.getTotalGoals()
        totalExpense.text = dataManager.getTotalExpense()
        
    }
    
    func createArrays() {
        buttonsArray = [incomeButton, walletButton, goalButton, expenseButton]
        collectionViewsArray = [collectionViewIncome, collectionViewWallets, collectionViewGoals, collectionViewExpense]
    }
    
    func registerCellsInCollectionViews() {
        collectionViewIncome.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionViewWallets.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionViewGoals.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionViewExpense.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        collectionViewIncome.dragInteractionEnabled = true
        collectionViewWallets.dragInteractionEnabled = true
        collectionViewGoals.dragInteractionEnabled = true
        collectionViewExpense.dragInteractionEnabled = true
    }
    //-------------------------------------
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        _ = unwindSegue.source
        isDown.toggle()
        showOrHideMenu(isHide: isDown)
    }
    
    @IBAction func unwindToDetails(_ unwindSegue: UIStoryboardSegue) {
        // let sourceViewController = unwindSegue.source
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        isDown.toggle()
        showOrHideMenu(isHide: isDown)
    }
    
    //MARK: Configure menu
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if !isDown {
            return .darkContent
        } else {
            return .lightContent
        }
    }
    
    func showOrHideMenu(isHide: Bool) {
        if isHide { showMenu() }
        else {
            hideMenu()
        }
    }
    
    func setTagForStack() {
        for index in 0...buttonsArray.count - 1 {
            buttonsArray[index].tag = index
        }
    }
    
    func showMenu() {
        addButton.tintColor = .white
        self.toggleItems()
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.configureStacks(array: self.buttonsArray, isHide: self.isDown)
            self.addButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)
        }
    }
    
    func hideMenu() {
        addButton.tintColor = .black
        UIView.animate(withDuration: 0.5, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
            self.addButton.transform = CGAffineTransform.identity
            self.configureStacks(array: self.buttonsArray, isHide: self.isDown)
        }) { (_) in
            self.toggleItems()
        }
    }
    
    func configureStacks(array: [UIButton], isHide: Bool) {
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
        self.incomeButton.isHidden.toggle()
        self.walletButton.isHidden.toggle()
        self.goalButton.isHidden.toggle()
        self.expenseButton.isHidden.toggle()
        self.darkGround.isHidden.toggle()
    }
    //===============================================================
    
    @IBAction func addNewExpenseBTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateNewCategory") as! NewCategoryVC
        vc.category = expense
        vc.title = "New \(expense)"
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        isDown.toggle()
        showOrHideMenu(isHide: isDown)
        // present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addNewIncomeBTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateNewCategory") as! NewCategoryVC
        vc.category = income
        vc.title = "New \(income)"
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
        isDown.toggle()
        showOrHideMenu(isHide: isDown)
    }
    
    @IBAction func addNewWalletBTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateNewCategory") as! NewCategoryVC
        vc.category = wallet
        vc.title = "New \(wallet)"
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        isDown.toggle()
        showOrHideMenu(isHide: isDown)
    }
    
    @IBAction func addNewGoalBTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateNewCategory") as! NewCategoryVC
        vc.category = goal
        vc.title = "New \(goal)"
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        isDown.toggle()
        showOrHideMenu(isHide: isDown)
    }
}

extension HomeScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDropDelegate, UICollectionViewDragDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case collectionViewIncome:
            return incomeList?.count ?? 0
        case collectionViewWallets:
            return walletList?.count ?? 0
        case collectionViewGoals:
            return goalList?.count ?? 0
        case collectionViewExpense:
            return expenseList?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = makeCell(collectionView, indexPath)
        return cell
    }
    

       

    
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        


        let rightAndLeft: CGFloat = 5
        let cellSize: CGFloat = 75
        let widthScreen = screenSize.width - rightAndLeft * 2
        let amountElements = (widthScreen / cellSize).rounded()
        let spacing = (widthScreen - (amountElements * cellSize)) / (amountElements - 1)
        return spacing
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case collectionViewIncome:
            let vc = storyboard?.instantiateViewController(withIdentifier: "details") as! DeteilViewController
            vc.category = income
            vc.indexItem = indexPath.row
            vc.nameOfItem = incomeList?[indexPath.row].name ?? ""
            present(vc, animated: true, completion: nil)
        case collectionViewWallets:
            let vc = storyboard?.instantiateViewController(withIdentifier: "details") as! DeteilViewController
            vc.category = wallet
            vc.indexItem = indexPath.row
            vc.nameOfItem = walletList?[indexPath.row].name ?? ""
            present(vc, animated: true, completion: nil)
        case collectionViewGoals:
            let vc = storyboard?.instantiateViewController(withIdentifier: "details") as! DeteilViewController
            vc.category = goal
            vc.indexItem = indexPath.row
            vc.nameOfItem = goalList?[indexPath.row].name ?? ""
            present(vc, animated: true, completion: nil)
        case collectionViewExpense:
            let vc = storyboard?.instantiateViewController(withIdentifier: "details") as! DeteilViewController
            vc.category = expense
            vc.indexItem = indexPath.row
            vc.nameOfItem = expenseList?[indexPath.row].name ?? ""
            present(vc, animated: true, completion: nil)
        default:
            print("Hello")
        }
    }
    
    func makeCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        switch collectionView {
        case collectionViewIncome:
            
            totalIncome.text = dataManager.getTotalIncome()
            if incomeList != nil {
                cell.nameOfCell.text = incomeList?[indexPath.row].name ?? ""
                cell.totalCount.text = String(incomeList?[indexPath.row].amount ?? 0)
                cell.currencyCell.text = incomeList?[indexPath.row].currency ?? "$"
                cell.textLogo.text = incomeList?[indexPath.row].logo

                if incomeList?[indexPath.row].logo == "" {
                    setImageLogo(textLogo: cell.textLogo, imageLogo: cell.logoCell)
                } else {
                    setTextLogo(textLogo: cell.textLogo, imageLogo: cell.logoCell)
                }
            }
        case collectionViewWallets:
            
            totalWallet.text = dataManager.getTotalWallets()
            balanceOnTop.text = "\(totalWallet.text ?? "0") \(nis)"
            
            cell.nameOfCell.text = walletList?[indexPath.row].name ?? ""
            cell.totalCount.text = String(walletList?[indexPath.row].amount ?? 0)
            cell.currencyCell.text = walletList?[indexPath.row].currency ?? "$"
            cell.textLogo.text = walletList?[indexPath.row].logo
            if walletList?[indexPath.row].logo == "" {
                setImageLogo(textLogo: cell.textLogo, imageLogo: cell.logoCell)
            } else {
                setTextLogo(textLogo: cell.textLogo, imageLogo: cell.logoCell)
            }
            
        case collectionViewGoals:
            
            totalGoal.text = dataManager.getTotalGoals()
            guard let item = goalList?[indexPath.row] else {return cell}
            cell.nameOfCell.text = item.name
            cell.totalCount.text = String(item.amount)
            cell.currencyCell.text = item.currency
            cell.textLogo.text = item.logo
            if item.goal == 0 {
                cell.budget.isHidden = true
            } else {
                cell.budget.isHidden = false
            }
            cell.budget.text = String(item.goal)
            if item.logo == "" {
                setImageLogo(textLogo: cell.textLogo, imageLogo: cell.logoCell)
            } else {
                setTextLogo(textLogo: cell.textLogo, imageLogo: cell.logoCell)
            }
            cell.progressView.isHidden = true
            if item.goal != 0 {
                let setConstraint: CGFloat = CGFloat(50 - 50 * (Double(item.amount) / Double(item.goal != 0 ? item.goal : 1)))
                
                
                cell.progressView.isHidden = false
                UIView.animate(withDuration: 0.5) {
                    DispatchQueue.main.async {
                        cell.topCanstraint.constant = setConstraint
                        cell.progressView.layoutIfNeeded()
                    }
                }
                
            }
        case collectionViewExpense:
            
            totalExpense.text = dataManager.getTotalExpense()
            plannedOnTop.text = "\(dataManager.getTotalPlanned()) \(nis)"
            expensOnTop.text = "\(totalExpense.text ?? "0") \(nis)"
            
            guard let item = expenseList?[indexPath.row] else {return cell}
            cell.nameOfCell.text = item.name
            cell.totalCount.text = String(item.amount)
            cell.currencyCell.text = item.currency
            cell.textLogo.text = item.logo
            if item.budget == 0 {
                cell.budget.isHidden = true
            } else {
                cell.budget.isHidden = false
            }
            cell.budget.text = String(item.budget)
            
            if item.logo == "" {
                setImageLogo(textLogo: cell.textLogo, imageLogo: cell.logoCell)
            } else {
                setTextLogo(textLogo: cell.textLogo, imageLogo: cell.logoCell)
            }
            cell.progressView.isHidden = true
            if item.budget != 0 {
            let setConstraint: CGFloat = CGFloat(50 - 50 * (Double(item.amount) / Double(item.budget != 0 ? item.budget : 1)))

                cell.progressView.isHidden = false
                UIView.animate(withDuration: 0.5) {
                    DispatchQueue.main.async {
                        cell.topCanstraint.constant = setConstraint
                        cell.progressView.layoutIfNeeded()
                    }
                }
            }
        default:
            print("Hello")
        }
        return cell
    }
    
    func setTextLogo(textLogo: UILabel, imageLogo: UIImageView) {
        textLogo.isHidden = false
        imageLogo.isHidden = true
    }
    func setImageLogo(textLogo: UILabel, imageLogo: UIImageView) {
        textLogo.isHidden = true
        imageLogo.isHidden = false
    }
    
    //MARK: Start drop items
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        sourceIndex = indexPath.row
        
        
        switch collectionView {
        case collectionViewIncome:
            typeOfCategoryFrom = income
            currentCollectionView = collectionViewIncome
            sourceItem = incomeList?[indexPath.row] ?? 0
            sourceID = incomeList?[indexPath.row].id
        case collectionViewWallets:
            typeOfCategoryFrom = wallet
            currentCollectionView = collectionViewWallets
            sourceItem = walletList?[indexPath.row] ?? 0
            sourceID = walletList?[indexPath.row].id
        case collectionViewGoals:
            typeOfCategoryFrom = goal
            currentCollectionView = collectionViewGoals
            sourceItem = goalList?[indexPath.row] ?? 0
            sourceID = goalList?[indexPath.row].id
            //        case collectionViewExpense:
            //            typeOfCategoryFrom = "Expense"
            //            session.localContext = collectionViewExpense
            //            currentCollectionView = collectionViewExpense
        //            sourceItem = expenseList[indexPath.row]
        default:
            print("Hello")
        }
        return dragItems(at: indexPath)
    }
    
    //     func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
    //         return dragItems(at: indexPath)
    //     }
    //
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        
        if let attributedImage = (currentCollectionView?.cellForItem(at: indexPath) as? CollectionViewCell)?.nameOfCell.attributedText {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: attributedImage))
            dragItem.localObject = attributedImage
            return [dragItem]
        } else {
            return []
        }
    }
    //Тут можно отслеживать куда был брошен item который мы взяли
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewTransaction") as! AddNewTransaction
        vc.source = typeOfCategoryFrom
        
        guard let destinationIndexPath = coordinator.destinationIndexPath else {return}
        
        vc.sourceIndex = sourceIndex
        vc.destinationIndex = destinationIndexPath.row
        
        switch collectionView {
        case collectionViewIncome:
            if currentCollectionView == collectionViewWallets { return }
            if currentCollectionView == collectionViewGoals { return }
            vc.destinationID = incomeList?[destinationIndexPath.row].id
            vc.title = incomeList?[destinationIndexPath.row].name
            vc.destination = income
            
        case collectionViewWallets:
            if currentCollectionView == collectionViewGoals { return }
            vc.destinationID = walletList?[destinationIndexPath.row].id
            vc.destination = wallet
            vc.title = walletList?[destinationIndexPath.row].name
        case collectionViewGoals:
            if currentCollectionView == collectionViewIncome { return }
            vc.destinationID = goalList?[destinationIndexPath.row].id
            vc.destination = goal
            vc.title = goalList?[destinationIndexPath.row].name
        case collectionViewExpense:
            if currentCollectionView == collectionViewExpense { return }
            if currentCollectionView == collectionViewGoals { return }
            if currentCollectionView == collectionViewIncome { return }
            vc.destinationID = expenseList?[destinationIndexPath.row].id
            vc.destination = expense
            vc.title = expenseList?[destinationIndexPath.row].name
        default:
            print("Hello")
        }
        vc.sourceID = sourceID
        //  navigationController?.pushViewController(vc, animated: true)
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        
        //present(vc, animated: true, completion: nil)
        
        
        
        //        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        //        for item in coordinator.items {
        //            if let sourceIndexPath = item.sourceIndexPath {
        //                if let attributedString = item.dragItem.localObject as? NSAttributedString {
        //                    collectionView.performBatchUpdates({
        ////                        emojis.remove(at: sourceIndexPath.item)
        ////                        emojis.insert(attributedString.string, at: destinationIndexPath.item)
        ////                        collectionView.deleteItems(at: [sourceIndexPath])
        ////                        collectionView.insertItems(at: [destinationIndexPath])
        //                    })
        //                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        //                    let cell = collectionView.cellForItem(at: destinationIndexPath) as? CollectionViewCell
        //                   print(cell?.nameOfCell)
        //                }
        //            }
        //        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
    //        return session.canLoadObjects(ofClass: NSAttributedString.self)
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
    //        let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
    //        return UICollectionViewDropProposal(operation: isSelf ? .move : .copy, intent: .insertIntoDestinationIndexPath)
    //    }
}
