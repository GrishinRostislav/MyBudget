//
//  HomeScreenVC.swift
//  MyBudget
//
//  Created by Rostislav Grishin on 22.02.2020.
//  Copyright © 2020 Rostislav Grishin. All rights reserved.
//

import UIKit

private let reusableCell = "collectionView"

class HomeScreenVC: UIViewController {

    @IBOutlet weak var walletsCollectionView: UICollectionView!
    
    @IBOutlet weak var startEnd: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var changeTime: UIButton!
    @IBOutlet weak var viewTitle: UIView!
    
    var isDown = false

    override func viewDidLoad() {
        super.viewDidLoad()
        changeTime.roundCorners([.bottomLeft, .bottomRight], radius: 50)
        startEnd.alpha = 0
        datePicker.alpha = 0
        startEnd.layer.cornerRadius = 0
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        self.isDown.toggle()
        if !isDown {
            self.datePicker.alpha = 0
            self.startEnd.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.changeTime.frame.origin.y -= self.datePicker.frame.size.height + self.startEnd.frame.size.height - 10
              //  self.changeTime.frame.size.width = self.view.frame.size.width
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.changeTime.frame.origin.y += self.datePicker.frame.size.height + self.startEnd.frame.size.height - 10
            }
            UIView.animate(withDuration: 0.2, delay: 0.4, options: .curveEaseInOut, animations: {
                self.startEnd.alpha = 1
                self.datePicker.alpha = 1
                self.datePicker.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                
            }, completion: nil)
        }
    }
}

extension HomeScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == walletsCollectionView {
            return 8
        }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell, for: indexPath)
        cell.layer.cornerRadius = 25
       
        return cell
    }
    
}
