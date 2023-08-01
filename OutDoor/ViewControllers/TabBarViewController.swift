//
//  HomeViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 25/07/2023.
//

import UIKit


class TabBarViewController: UITabBarController {
    
    private var addButton: UIButton?
    private var postLoc : UIButton?
    private var postTools: UIButton?
    private let layer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarIcon()
        setupButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTapAlertPV), name: NSNotification.Name("openPreviewAvatar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTapClosePV), name: NSNotification.Name("closePreviewAvatar"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        addButton?.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        tabBar.addSubview(addButton!)
        
        postLoc = UIButton()
        postLoc?.contentMode = .scaleToFill
        postLoc?.setImage(UIImage(named: "ic_post_loc"), for: .normal)
        postLoc?.frame.size = CGSize(width: 50, height: 50)
        postLoc?.center.x = addButton!.center.x - 60
        postLoc?.center.y = addButton!.center.y - 65
        postLoc?.isHidden = true
        tabBar.addSubview(postLoc!)
        
        postTools = UIButton()
        postTools?.contentMode = .scaleToFill
        postTools?.setImage(UIImage(named: "ic_post_tools"), for: .normal)
        postTools?.frame.size = CGSize(width: 50, height: 50)
        postTools?.center.x = addButton!.center.x + 60
        postTools?.center.y = addButton!.center.y - 65
        postTools?.isHidden = true
        tabBar.addSubview(postTools!)
    }
    
    @objc private func didTapAddButton() {
        if postLoc?.isHidden == true {
            addButton?.transform = CGAffineTransform(rotationAngle: .pi/4)
            postLoc?.isHidden = false
            postTools?.isHidden = false
            
        }else {
            addButton?.transform = CGAffineTransform(rotationAngle: 0)
            postLoc?.isHidden = true
            postTools?.isHidden = true
        }
    }
    
    @objc private func didTapAlertPV() {
        tabBar.isHidden = true
    }
   
    @objc private func didTapClosePV() {
        tabBar.isHidden = false
    }
  

}
