//
//  MainTabBarController.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 20.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isUserOnline()
    }
    
    
    private func showLoginScreen() {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        DispatchQueue.main.async {
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    private func isUserOnline(){
        guard let isOnline = UserDefaults.standard.value(forKey: "isOnline") as? Bool else {return}
        if  !isOnline {
            print("User is Online")
            showLoginScreen()
        }
    }
}
