//
//  UserInfoViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 25/07/2023.
//

import UIKit
import SDWebImage

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    @IBOutlet weak var userBackgroundIMV: UIImageView!
    
    @IBOutlet weak var userAvartarIMV: UIImageView!
    
  
    @IBOutlet weak var editAvatarBT: UIButton!
    
    @IBOutlet weak var userNameLB: UILabel!
    
    @IBOutlet weak var followersLB: UILabel!
    
    @IBOutlet weak var sharesLB: UILabel!
    
    @IBOutlet weak var likesLB: UILabel!
    
    @IBOutlet weak var userDesLB: UILabel!
    
    @IBOutlet weak var userPostBT: UIButton!
    
    @IBOutlet weak var savePostBT: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stackButtonPost: UIStackView!
    
    @IBOutlet weak var containerView: UIView!
    var lastScroll:CGFloat = 0
    
    var smallUserAvatarIMV = UIImageView()
    var smallUserNameLB = UILabel()
    var navigationView = UIView()
    
    let stackview = UIStackView()
    let postBT = UIButton()
    let saveBT = UIButton()
    
    var user : OutDoorUser?
    
    var tt :[String] = ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"]
    
    
    
    @IBOutlet weak var shadowAvatarView: UIView!
    
    
    @IBOutlet weak var shadowButtonView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        
        let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView
        scrollView?.delegate = self
        
        shadowAvatarView.layer.cornerRadius = 75
        shadowAvatarView.layer.shadowRadius = 10
        shadowAvatarView.layer.shadowOffset = CGSize(width: 0, height: 10)
        shadowAvatarView.layer.shadowColor = Constants.Colors.buttonBackgroundColor.color.cgColor
        shadowAvatarView.layer.shadowOpacity = 0.2
        
        shadowButtonView.layer.cornerRadius = 10
        shadowButtonView.layer.shadowRadius = 2
        shadowButtonView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowButtonView.layer.shadowColor = Constants.Colors.buttonBackgroundColor.color.cgColor
        shadowButtonView.layer.shadowOpacity = 0.2
        
        setupSubviews()
        setUpNavigation() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userPostBTAction(1)
        tableView.setContentOffset(.zero, animated: true)
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
        
        
    }
   private func setUpNavigation() {
        navigationItem.rightBarButtonItem  = UIBarButtonItem(image: UIImage(named: "ic_arrow_left_white"), style: .plain, target: self, action: #selector(didTapSettingButton))
        
        let backImage = UIImage(named: "Group 40")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .white
       
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    @objc func didTapSettingButton() {
        tableView.setContentOffset(.zero, animated: false)
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController
        vc?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc!, animated: false)
        
    }
    
   private func setupSubviews() {
    
       guard let userIFValue =  UserDefaults.standard.value(forKey: "userIFValue") as? [String:Any], let userIMValue = UserDefaults.standard.value(forKey: "userIMValue") as? [String:Any], let userLPValue = UserDefaults.standard.value(forKey: "userLPValue") as? [String:Any] else {return}
      
        updateSubviews(userInfo: userIFValue, userImage: userIMValue, userLikePost: userLPValue)
        containerView.backgroundColor = .white
        userAvartarIMV.layer.cornerRadius = 75
        editAvatarBT.setImage(UIImage(named: Constants.Images.userEditAvatar), for: .normal)
        editAvatarBT.backgroundColor = .white
        editAvatarBT.layer.cornerRadius = 10
        
        userNameLB.font = Constants.Fonts.SFSemibold28
        userNameLB.textColor = Constants.Colors.textColorType1.color
        
        followersLB.font = Constants.Fonts.SFSemibold28
        followersLB.textColor = Constants.Colors.textColorType2.color
        sharesLB.font = Constants.Fonts.SFSemibold28
        sharesLB.textColor = Constants.Colors.textColorType2.color
        likesLB.font = Constants.Fonts.SFSemibold28
        likesLB.textColor = Constants.Colors.textColorType2.color
        
        userDesLB.font = Constants.Fonts.SFReguler17
        userDesLB.textColor = Constants.Colors.textColorType3.color
        
        userPostBT.layer.cornerRadius = 21
        userPostBT.layer.masksToBounds = true
        userPostBT.layer.borderWidth = 1
        userPostBT.layer.borderColor = Constants.Colors.buttonBackgroundColor.color.cgColor
        userPostBT.titleLabel?.font = Constants.Fonts.SFReguler17
        
        
        savePostBT.layer.cornerRadius = 21
        savePostBT.layer.masksToBounds = true
        savePostBT.layer.borderWidth = 1
        savePostBT.layer.borderColor = Constants.Colors.buttonBackgroundColor.color.cgColor
        
        stackButtonPost.frame.origin = CGPoint(x: (view.bounds.width - stackButtonPost.frame.width)/2, y: userDesLB.frame.maxY + 40)
        
    
    }
    
    func updateSubviews(userInfo: [String:Any], userImage: [String:Any], userLikePost: [String:Any]) {
        let firstName = userInfo["first_name"] as? String ?? ""
        let lastName = userInfo["last_name"] as? String ?? ""
        let description = userInfo["description"] as? String
        
        let backgroundImage = userImage["backgroundImage"] as? String ?? ""
        let avatar = userImage["avatar"] as? String ?? ""
        
        let numberOfFollowers = userLikePost["numberOfFollowers"] as? Int
        let numberOfShares = userLikePost["numberOfShares"] as? Int
        let numberOfLikes = userLikePost["numberOfLikes"] as? Int
        
        
        userNameLB.text = firstName.capitalized  + " " + lastName.capitalized
        if backgroundImage.count != 0 {
            userBackgroundIMV.sd_setImage(with: URL(string: backgroundImage))
        }else {
            userBackgroundIMV.image = UIImage(named: Constants.Images.userBackgrounDefault)
        }
        if avatar.count != 0 {
            userAvartarIMV.sd_setImage(with: URL(string: avatar))
        }else {
            userAvartarIMV.image = UIImage(named: Constants.Images.userAvatarDefault)
        }
        
        followersLB.text = numberOfFollowers?.description ?? "0"
        sharesLB.text = numberOfShares?.description ?? "0"
        likesLB.text = numberOfLikes?.description ?? "0"
        
//        userDesLB.text = description?.capitalized
        userDesLB.text = "25% off camping and outdoors equipment (Kelty, Alpine, Dakine, Coleman)..."
        
    }
    
   private func changeNavBar(navigationBar: UINavigationBar, to color: UIColor) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = color
                appearance.shadowColor = color
                navigationBar.standardAppearance = appearance;
                navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
    }
    
    
    @IBAction func userPostBTAction(_ sender: Any) {
        tt = ["post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1", "post1"]
        tableView.reloadData()
        
        userPostBT.setTitle("Bài viết của bạn", for: .normal)
        userPostBT.setTitleColor(.white, for: .normal)
        userPostBT.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        
        savePostBT.setTitle("Bài viết đã lưu", for: .normal)
        savePostBT.setTitleColor(Constants.Colors.buttonBackgroundColor.color, for: .normal)
        savePostBT.backgroundColor = .clear
        
        postBT.setTitle("Bài viết của bạn", for: .normal)
        postBT.setTitleColor(.white, for: .normal)
        postBT.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        
        saveBT.setTitle("Bài viết đã lưu", for: .normal)
        saveBT.setTitleColor(Constants.Colors.buttonBackgroundColor.color, for: .normal)
        saveBT.backgroundColor = .clear
    }
    
    @IBAction func savePostBTAction(_ sender: Any) {
        tt = ["post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2", "post2"]
        tableView.reloadData()
        userPostBT.setTitle("Bài viết của bạn", for: .normal)
        userPostBT.setTitleColor(Constants.Colors.buttonBackgroundColor.color, for: .normal)
        userPostBT.backgroundColor = .clear
        
        savePostBT.setTitle("Bài viết đã lưu", for: .normal)
        savePostBT.setTitleColor(.white, for: .normal)
        savePostBT.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        
        postBT.setTitle("Bài viết của bạn", for: .normal)
        postBT.setTitleColor(Constants.Colors.buttonBackgroundColor.color, for: .normal)
        postBT.backgroundColor = .clear
        
        saveBT.setTitle("Bài viết đã lưu", for: .normal)
        saveBT.setTitleColor(.white, for: .normal)
        saveBT.backgroundColor = Constants.Colors.buttonBackgroundColor.color
    }
    

}


extension UserInfoViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tt[indexPath.row]
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 180 {
           
            smallUserAvatarIMV.frame.size = CGSize(width: 36, height: 36)
            smallUserAvatarIMV.frame.origin = CGPoint(x: 80, y: 50)
            smallUserAvatarIMV.layer.cornerRadius = 18
            smallUserAvatarIMV.clipsToBounds = true
            smallUserAvatarIMV.image = userAvartarIMV.image
            
            smallUserNameLB.frame.size = CGSize(width: 120, height: 24)
            smallUserNameLB.frame.origin = CGPoint(x: smallUserAvatarIMV.frame.maxX + 20, y: smallUserAvatarIMV.frame.minY + 6)
            smallUserNameLB.text = userNameLB.text
            smallUserNameLB.font = Constants.Fonts.SFSemibold17
            smallUserNameLB.textColor = Constants.Colors.textColorType5.color
            changeNavBar(navigationBar: navigationController!.navigationBar, to: Constants.Colors.buttonBackgroundColor.color)
            navigationController?.view.addSubview(smallUserAvatarIMV)
            navigationController?.view.addSubview(smallUserNameLB)
        }else if scrollView.contentOffset.y < 180 {
            tableView.contentInsetAdjustmentBehavior = .never
            smallUserAvatarIMV.image = UIImage()
            smallUserAvatarIMV.backgroundColor = .clear
            
            smallUserNameLB.text = ""
            smallUserNameLB.textColor = .clear
            
            changeNavBar(navigationBar: navigationController!.navigationBar, to: .clear)
        }
        
        
        if scrollView.contentOffset.y > 380 {
            navigationView.frame.size = CGSize(width: view.bounds.width, height: 100)
            navigationView.frame.origin = CGPoint(x: 0, y: (navigationController?.navigationBar.frame.maxY)!)
            navigationView.backgroundColor = .white
            navigationView.isHidden = false
            
            stackview.frame.size = stackButtonPost.frame.size
            stackview.frame.origin = CGPoint(x: (navigationView.bounds.width - stackview.frame.width)/2, y: 33)
            stackview.axis = .horizontal
            stackview.spacing = 20
            stackview.distribution = .fillEqually
            stackview.backgroundColor = .white
            stackview.isHidden = false
            
            postBT.setTitle("Bài viết của bạn", for: .normal)
            postBT.titleLabel?.font = Constants.Fonts.SFReguler17
            postBT.layer.cornerRadius = 21
            postBT.layer.masksToBounds = true
            postBT.layer.borderWidth = 1
            postBT.layer.borderColor = Constants.Colors.buttonBackgroundColor.color.cgColor
            postBT.addTarget(self, action: #selector(postBTAction) , for: .touchUpInside)
            postBT.isHidden = false
            
            saveBT.setTitle("Bài viết đã lưu", for: .normal)
            saveBT.titleLabel?.font = Constants.Fonts.SFReguler17
            saveBT.layer.cornerRadius = 21
            saveBT.layer.masksToBounds = true
            saveBT.layer.borderWidth = 1
            saveBT.layer.borderColor = Constants.Colors.buttonBackgroundColor.color.cgColor
            saveBT.addTarget(self, action: #selector(saveBTAction) , for: .touchUpInside)
            saveBT.isHidden = false
            stackview.addArrangedSubview(postBT)
            stackview.addArrangedSubview(saveBT)
            
            
            
            
            
            
            
            navigationView.addSubview(stackview)
            
            navigationController?.view.addSubview(navigationView)
        }else if scrollView.contentOffset.y < 380 {
            navigationView.backgroundColor = .clear
            navigationView.isHidden = true
            stackview.isHidden = true
            postBT.isHidden = true
            saveBT.isHidden = true
            
        }
    }
    
    @objc private func postBTAction(_ sender: UIButton) {
        userPostBTAction(sender)
    }
    
    @objc private func saveBTAction(_ sender: UIButton) {
        savePostBTAction(sender)
    }
    
    
    
    
}
