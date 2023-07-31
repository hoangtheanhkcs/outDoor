//
//  PreviewAvatarViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 31/07/2023.
//

import UIKit
import SDWebImage

protocol PreviewAvatarViewControllerDelegate: class {
    func didTapCloseBT()
}

class PreviewAvatarViewController: UIViewController {
    
    var previewImageView: UIImageView?
    var closeIM : UIImageView?
    var closeButton: UIButton?
    weak var delegete: PreviewAvatarViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.55)
       
        
        
//        addBlurredView()
        setupSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        setupImageView()
    }
    
    
    private func setupSubviews() {
        
        previewImageView = UIImageView()
        previewImageView?.image = UIImage(named: "Person-icon-reversed-500x500-300x300")
        previewImageView?.frame.size = CGSize(width: view.bounds.width, height: 460)
        previewImageView?.frame.origin = CGPoint(x: 0, y: 200)
        
        
        view.addSubview(previewImageView!)
        
        closeButton = UIButton()
        closeButton?.setImage(UIImage(named: "Group 78"), for: .normal)
        closeButton?.frame.size = CGSize(width: 30, height: 30)
        closeButton?.frame.origin = CGPoint(x: view.frame.width - 40, y: 210)
        closeButton?.addTarget(self, action: #selector(didTapCloseBT), for: .touchUpInside)
        view.addSubview(closeButton!)
        
        
     
    }
    
    func setupImageView() {
        guard  let userIMValue = UserDefaults.standard.value(forKey: "userIMValue") as? [String:Any] else {return}
        updateSubviews(userImage: userIMValue)
    }
    func updateSubviews(userImage: [String:Any]) {
       
        let avatar = userImage["avatar"] as? String ?? ""
        
       
    
        if avatar.count != 0 {
            previewImageView?.sd_setImage(with: URL(string: avatar))
        }else {
            previewImageView?.image = UIImage(named: Constants.Images.userAvatarDefault)
        }
        
        
    }
    
    private func addBlurredView() {
            if !UIAccessibility.isReduceTransparencyEnabled {
                self.view.backgroundColor = .clear
                
                let blurEffect = UIBlurEffect(style: .light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = self.view.bounds
                
                blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                view.addSubview(blurEffectView)
            }else {
                view.backgroundColor = .darkGray
            }
        }
    
    @objc private func didTapCloseBT() {
        delegete?.didTapCloseBT()
    }
    
}
