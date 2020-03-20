//
//  DataManager.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 20.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//
import RealmSwift

let realm = try! Realm()
let income = "Income"
let wallet = "Wallet"
let goal = "Goal"
let expense = "Expense"
let usd = "$"
let nis = "₪"

class DataManager {
    
    static func getCategory(index: Int) -> String {
        let categories = ["Income", "Wallet", "Goal", "Expense"]
        return categories[index]
    }
    
    //MARK: Save data to category
    func saveData(list: Object) {
        DispatchQueue(label: "saveData").async {
            autoreleasepool {
                let realm = try! Realm()
                let user = realm.objects(UserData.self)[0]
                try! realm.write {
                    switch list {
                    case list as? Income:
                        print("Yes Income")
                        user.incomes.append(list as! Income)
                    case list as? Wallet:
                        print("Yes Wallet")
                        user.wallets.append(list as! Wallet)
                    case list as? Goal:
                        user.goals.append(list as! Goal)
                    case list as? Expens:
                        user.expense.append(list as! Expens)
                    default:
                        break
                    }
                }
            }
        }
    }
    //-------------------------------------------------------
   
    //MARK: Delete Data
    static func deleteItem(nameCategory: String, index: Int){
        DispatchQueue(label: "Delete Item").async {
            autoreleasepool {
                let realm = try! Realm()
                let user = realm.objects(UserData.self)[0]
                
                try! realm.write {
                  //  realm.deleteAll()
                    switch nameCategory {
                    
                    case income:
                       
                        let myItem = user.incomes[index]
                        let sourceID = myItem.id

                        for wallet in user.wallets {
                            for transaction in wallet.transactions{
                                if sourceID == transaction.source {
                                    wallet.amount -= transaction.amount
                                    realm.delete(transaction)
                                }
                            }
                        }
                        realm.delete(myItem)
                        
                    case wallet:
                    
                        let myItem = user.wallets[index]
                        let sourceID = myItem.id
                        
                        for expense in user.expense {
                            for transaction in expense.transactions{
                                if sourceID == transaction.source {
                                    expense.amount -= transaction.amount
                                    realm.delete(transaction)
                                }
                            }
                        }
                        
                        for goal in user.goals {
                            for transaction in goal.transactions{
                                if sourceID == transaction.source {
                                    goal.amount -= transaction.amount
                                    realm.delete(transaction)
                                }
                            }
                        }
                        
                        for wallet in user.wallets {
                            for transaction in wallet.transactions{
                                if sourceID == transaction.source {
                                    wallet.amount -= transaction.amount
                                    realm.delete(transaction)
                                }
                            }
                        }
                        
                        for income in user.incomes {
                            for transaction in income.transactions{
                                if sourceID == transaction.destination {
                                    income.amount -= transaction.amount
                                    realm.delete(transaction)
                                }
                            }
                        }
                        realm.delete(myItem)
                    case goal:
                        
                        realm.delete(user.goals[index])
                    case expense:
                        
                        realm.delete(user.expense[index])
                    default:
                        break
                    }
                }
            }
        }
    }
    //-------------------------------------------------------
    
    //MARK: Get Data

    func getData(nameOfCategory: String) -> List<Object> {
   //     let myUser = realm.objects(UserData.self)[0]
        var list = List<Object>()
//        switch nameOfCategory {
//        case income:
//            list = getIncomes() as! List<Object>
//        case wallet:
//            return getWallet(user: myUser)
//        case goal:
//            return getGoal(user: myUser)
//        case expense:
//            return getExpense(user: myUser)
//        default:
//            print("Error")
       // }
        return list
    }
    
    func getWallets() -> List<Wallet>?{

        let myUser = realm.objects(UserData.self)
        if myUser.count == 0 {return nil}
        return myUser[0].wallets
    }
    
    func getMyWallet(index: Int) -> Wallet{
        let myUser = realm.objects(UserData.self)[0]
        return myUser.wallets[index]
    }
    
    func getMyIncome(index: Int) -> Income{
        let myUser = realm.objects(UserData.self)[0]
        return myUser.incomes[index]
    }
    
    
   func getIncome(user: UserData) -> [Income]{
        var result = [Income]()
        for income in user.incomes {
            result.append(income)
        }
        return result
    }
    
    func getWallet(user: UserData) -> [Wallet]{
        var result = [Wallet]()
        for income in user.wallets {
            result.append(income)
        }
        return result
    }
    
    func getGoal(user: UserData) -> [Goal]{
        var result = [Goal]()
        for income in user.goals {
            result.append(income)
        }
        return result
    }
    
    func getExpense(user: UserData) -> [Expens]{
        var result = [Expens]()
        for income in user.expense {
            result.append(income)
        }
        return result
    }

    func getIncomes() -> List<Income>?{
      
        let myUser = realm.objects(UserData.self)
        if myUser.count == 0 {return nil}
        return myUser[0].incomes
    }
    
    func getExpens() -> List<Expens>?{
      
        let myUser = realm.objects(UserData.self)
        if myUser.count == 0 {return nil}
        return myUser[0].expense
    }
    
   
    
    func getGoals() -> List<Goal>?{
      
        let myUser = realm.objects(UserData.self)
        if myUser.count == 0 {return nil}
        return myUser[0].goals
    }
    
    func getTotalPlanned() -> String {
        var result = 0
        let myUser = realm.objects(UserData.self)[0]
        for budget in myUser.expense{
            result += budget.budget
        }
        return String(result)
    }
       
    
    func getTotalIncome() -> String {
        var result = 0
        let myUser = realm.objects(UserData.self)[0]
        for income in myUser.incomes{
            result += income.amount
        }
        return String(result)
    }
    
    func getTotalWallets() -> String {
        var result = 0
        let myUser = realm.objects(UserData.self)[0]
        for wallet in myUser.wallets{
            result += wallet.amount
        }
        return String(result)
    }
    
    func getTotalGoals() -> String {
        var result = 0
        let myUser = realm.objects(UserData.self)[0]
        for goal in myUser.goals{
            if goal.goal != 0 {
            result += (goal.goal - goal.amount)
            }
        }
        return String(result)
    }
    
    func getTotalExpense() -> String {
        var result = 0
        let myUser = realm.objects(UserData.self)[0]
        for expense in myUser.expense{
            result += expense.amount
        }
        return String(result)
    }
}
