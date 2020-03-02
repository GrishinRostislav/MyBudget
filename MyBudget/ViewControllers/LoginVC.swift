//
//  ViewController.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 20.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit
import RealmSwift

class LoginVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.showsVerticalScrollIndicator = false
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(recognizer)

        // Implementing the touch(), outside of viewDidLoad:

    }
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotification()
    }
    
    @objc func touch() {
        //print("Touches")
        self.view.endEditing(true)
    }

    @IBAction func loginTapped() {
        let savedUser = realm.objects(UserData.self)
        for user in savedUser {
            if user.email == emailTF.text! {
                if user.password == passwordTF.text! {
                    try! realm.write {
                        user.isOnline = true
                    }
                    UserDefaults.standard.set(true, forKey: "isOnline")
                    showMainScreen()
                    return
                } else {
                    return
                }
            }
        }
        DispatchQueue.main.async {
            try! realm.write {
                let user = UserData(value: ["email": self.emailTF.text!, "password":self.passwordTF.text!, "isOnline": true])
                realm.add(user)
            }
            UserDefaults.standard.set(true, forKey: "isOnline")
            self.showMainScreen()
        }
    }
    
    private func showMainScreen() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainController") as! MainTabBarController
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}



extension LoginVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

    func registerForKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else if notification.name == UIResponder.keyboardWillShowNotification {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height + 10, right: 0)
           scrollView.scrollRectToVisible(CGRect(x: 0, y: 200, width: 0, height: 100), animated: true)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF {
            textField.resignFirstResponder()
            passwordTF.becomeFirstResponder()
        } else {
            loginTapped()
        }
        return true
    }
}
