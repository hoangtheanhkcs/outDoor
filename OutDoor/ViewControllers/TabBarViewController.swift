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
    
    private var containerAddBTVeiw = UIView()
    var addButtonStage: Bool = false {
        didSet {
            if addButtonStage == true {
                addButton?.transform = CGAffineTransform(rotationAngle: .pi/4)
                postLoc?.isHidden = false
                postTools?.isHidden = false
            }else {
                addButton?.transform = CGAffineTransform(rotationAngle: 0)
                postLoc?.isHidden = true
                postTools?.isHidden = true
            }
        }
    }
    
    
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
        addButton?.center.y = tabBar.frame.minY - 35
        addButton?.layer.cornerRadius = 35
        addButton?.layer.borderWidth = 4
        addButton?.layer.borderColor = UIColor.white.cgColor
        addButton?.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        view.insertSubview(addButton!, aboveSubview: tabBar)
        
        postLoc = UIButton()
        postLoc?.contentMode = .scaleToFill
        postLoc?.setImage(UIImage(named: "ic_post_loc"), for: .normal)
        postLoc?.frame.size = CGSize(width: 50, height: 50)
        postLoc?.center.x = addButton!.center.x - 60
        postLoc?.center.y = addButton!.center.y - 65
        postLoc?.isHidden = true
        postLoc?.addTarget(self, action: #selector(didTapPostLoc), for: .touchUpInside)
        view.insertSubview(postLoc!, aboveSubview: tabBar)
        
        postTools = UIButton()
        postTools?.contentMode = .scaleToFill
        postTools?.setImage(UIImage(named: "ic_post_tools"), for: .normal)
        postTools?.frame.size = CGSize(width: 50, height: 50)
        postTools?.center.x = addButton!.center.x + 60
        postTools?.center.y = addButton!.center.y - 65
        postTools?.isHidden = true
        postTools?.addTarget(self, action: #selector(didTapPostTool), for: .touchUpInside)
        view.insertSubview(postTools!, aboveSubview: tabBar)
    }
    
    @objc private func didTapAddButton() {
        if addButtonStage == false {
            addButtonStage = true
        }else {
            addButtonStage = false
        }
    }
    
    @objc private func didTapAlertPV() {
        tabBar.isHidden = true
        addButton?.isHidden = true
        addButtonStage = false
       
    }
   
    @objc private func didTapClosePV() {
        tabBar.isHidden = false
        addButton?.isHidden = false
      
    }
  
    
    @objc func didTapPostLoc() {
       addButtonStage = false
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController
        vc?.typeOfPost = .articlePost
        let nav = UINavigationController(rootViewController: vc!)
        nav.modalPresentationStyle = .fullScreen
       present(nav, animated: true)
        
    }

    @objc func didTapPostTool() {
        addButtonStage = false
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController
        vc?.typeOfPost = .toolsPost
        let nav = UINavigationController(rootViewController: vc!)
        nav.modalPresentationStyle = .fullScreen
       present(nav, animated: true)
    }
    
}
