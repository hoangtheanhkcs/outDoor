//
//  UserInfoViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 25/07/2023.
//

import UIKit
import SDWebImage
import JGProgressHUD

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate , PreviewAvatarViewControllerDelegate {
    
    private let spinner = JGProgressHUD(style: .dark)
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
    
    var tt :[String] = []
    
    
    
    @IBOutlet weak var shadowAvatarView: UIView!
    
    
    @IBOutlet weak var shadowButtonView: UIView!
    
    
    let previewAvatarController = PreviewAvatarViewController()
    var viewPreview : UIView? {
        return previewAvatarController.view
    }
    
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
        
        addChild(previewAvatarController)
        previewAvatarController.delegete = self
        
        viewPreview?.frame = view.bounds
        viewPreview?.isHidden  = true
        view.addSubview(viewPreview!)
        didMove(toParent: self)
        
        setUpNavigation() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userPostBTAction(1)
        tableView.setContentOffset(.zero, animated: true)
        UIApplication.shared.statusBarStyle = .lightContent
        
      
        setupSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.frame.size.height = 550
        containerView.layer.borderWidth = 0.2
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        
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
        vc?.user = user
        vc?.delegate = self
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
        

        
    
    }
    
    func updateSubviews(userInfo: [String:Any], userImage: [String:Any], userLikePost: [String:Any]) {
        let firstName = userInfo["first_name"] as? String ?? ""
        let lastName = userInfo["last_name"] as? String ?? ""
        var description = ""
        if let updateDS = UserDefaults.standard.value(forKey: "userDSValue") as? String {
            description = updateDS
        }else {
            description = userInfo["description"] as? String ?? ""
        }
        let email = userInfo["email"] as? String ?? ""
        let gender = userInfo["gender"] as? String ?? ""
        let birth = userInfo["dateOfBirth"] as? String ?? ""
        let phone = userInfo["phoneNumber"] as? String ?? ""
        
        
        let backgroundImage = userImage["backgroundImage"] as? String ?? ""
        let avatar = userImage["avatar"] as? String ?? ""
        
        let numberOfFollowers = userLikePost["numberOfFollowers"] as? Int ?? 0
        let numberOfShares = userLikePost["numberOfShares"] as? Int ?? 0
        let numberOfLikes = userLikePost["numberOfLikes"] as? Int ?? 0
        
        user = OutDoorUser(firstName: firstName, lastName: lastName, gender: gender, dateOfBirth: birth , emailAddress: email, avatar: avatar, backgroundImage: backgroundImage, description: description, userPhoneNumbers: phone , numberOfFollowers: numberOfFollowers, numberOfShares: numberOfShares, numberOfLikes: numberOfLikes)
        
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
        
        followersLB.text = numberOfFollowers.description
        sharesLB.text = numberOfShares.description
        likesLB.text = numberOfLikes.description
        
        userDesLB.text = description.capitalized

        
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
    
    
    @IBAction func changeAvatarButton(_ sender: Any) {
        
        let alert = UIAlertController(title: Constants.Strings.titleAlertChangeAvatar, message: nil, preferredStyle: .alert)
//        alert.view.tintColor = Constants.Colors.alertAvatar.color
        alert.view.subviews.first?.backgroundColor = .clear
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .clear
        alert.view.subviews.first?.subviews.first?.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Constants.Colors.textColorType8.color
        alert.view.subviews.first?.subviews.first?.subviews.first?.subviews[1].backgroundColor = .white
        
        alert.setTitle(font: Constants.Fonts.SFBold17, color: Constants.Colors.textColorType1.color)
        alert.setTint(color: Constants.Colors.alertAvatar.color)
        let previewAvatarAction = UIAlertAction(title: Constants.Strings.previewAvatar, style: .default) {[weak self] _ in
            guard let self = self else {return}
            viewPreview?.isHidden  = false
           
        }
        previewAvatarAction.setValue(UIImage(named: "eye"), forKey: "image")
    
        
        let choosePhotoFromLibrary = UIAlertAction(title: Constants.Strings.alertChangeAvatarChoosePhotoFromLibrary, style: .default) { _ in
            print("Chọn ảnh từ thiết bị")
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true)
        }
        choosePhotoFromLibrary.setValue(UIImage(named: "image"), forKey: "image")
        let takeNewPhoto = UIAlertAction(title: Constants.Strings.alertChangeAvatarTakeNewPhoto, style: .default) { _ in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true)
        }
        takeNewPhoto.setValue(UIImage(named: "camera"), forKey: "image")
        
        alert.addAction(previewAvatarAction)
        alert.addAction(choosePhotoFromLibrary)
        alert.addAction(takeNewPhoto)
        
        present(alert, animated: true)
        
    }
    
    func didTapCloseBT() {
        viewPreview?.isHidden = true
        
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
            
            smallUserNameLB.frame.size = CGSize(width: 200, height: 24)
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
        
        
        if scrollView.contentOffset.y > 360 {
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
        }else if scrollView.contentOffset.y < 360 {
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


extension UserInfoViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage, let data = selectedImage.pngData(), let fileName = user?.profilePictureFileName  else {
            return
        }
        
        spinner.show(in: view)
        StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName) {[weak self] (result: Result<String, Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let downloadUrl):
                UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_avatar_url")
                print("downloadUrl is \(downloadUrl)")
                DatabaseManager.shared.updateUserImageAvatar(user: self.user, urlUpdate: downloadUrl) { succsess in
                    switch succsess {
                        
                    case true:
                        DispatchQueue.main.async {
                            self.userAvartarIMV.sd_setImage(with: URL(string: downloadUrl))
                            self.user?.avatar = downloadUrl
                            self.spinner.dismiss()
                        }
                        
                    case false:
                        print("faile to upload new photo to database RealmTime")
                    }
                }
            case .failure(let error):
                print("StorageManager error: \(error)")
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


extension UserInfoViewController: SettingViewControllerDelegate {
    func updateAvatar(avatarImage: String?) {
        
        DispatchQueue.main.async {
            self.userAvartarIMV.sd_setImage(with: URL(string: avatarImage ?? ""))
            self.user?.avatar = avatarImage
        }
    }
    func updateBackground(backgroundImage: String?) {
      
        DispatchQueue.main.async {
            self.userBackgroundIMV.sd_setImage(with: URL(string: backgroundImage ?? ""))
            self.user?.backgroundImage = backgroundImage
        }
    }
}

