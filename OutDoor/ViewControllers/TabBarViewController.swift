//
//  HomeViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 25/07/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private var addButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarIcon()
        setupButton()
    }
    
    private func setupTabBarIcon() {
        guard let items = tabBar.items else { return}
        items[0].image = UIImage(named: "Component 6")
        items[1].image = UIImage(named: "search")
        items[1].titlePositionAdjustment = UIOffset(horizontal: -20.0, vertical: 0.0)
        items[2].image = UIImage(named: "bell")
        items[2].titlePositionAdjustment = UIOffset(horizontal: 20.0, vertical: 0.0)
        items[3].image = UIImage(named: "user")
        items[0].title = ""
        items[1].title = ""
        items[2].title = ""
        items[3].title = ""
        tabBar.tintColor = Constants.Colors.buttonBackgroundColor.color
        tabBar.itemPositioning = .automatic
        tabBar.itemSpacing = 50
        
    }
    
    
    private func setupButton() {
        addButton = UIButton()
        addButton?.contentMode = .scaleToFill
        addButton?.setImage(UIImage(named: "Group 34"), for: .normal)
        addButton?.frame.size = CGSize(width: 70, height: 70)
        addButton?.center.x = view.center.x
        addButton?.center.y = tabBar.frame.minX
        addButton?.layer.cornerRadius = 35
        addButton?.layer.borderWidth = 4
        addButton?.layer.borderColor = UIColor.white.cgColor
        tabBar.addSubview(addButton!)
    }

}
