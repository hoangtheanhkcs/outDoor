//
//  UpdateUserInfoViewController.swift
//  OutDoor01
//
//  Created by hoang the anh on 12/07/2023.
//

import UIKit
import JGProgressHUD

protocol UpdateUserInfoViewControllerDeleage :class {
    func receiveTraillingButtonTap(_ sender: UpDateUserInfoCell)
    func didTapTraillingCellButton()
}

class UpdateUserInfoViewController: UIViewController,  UpdateUserInfoViewControllerDeleage {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    private let spinner = JGProgressHUD(style: .dark)
    
    var userEdit :[String] = [Constants.Strings.name, Constants.Strings.gender, Constants.Strings.birth, Constants.Strings.phone]
    var userInfos :[String] = []
    var newUserInfo: [String: Any]?
    var oldUserInfo: OutDoorUser?
    
    var index:Int = 0
    var allIndex:[Int] = []
    var isCellEditting:Bool = false {
        didSet {
            if isCellEditting == true {
                updateButton.isEnabled = false
            }else {
                updateButton.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<userEdit.count {
            allIndex.append(index)
        }
        
        let firstName = oldUserInfo?.firstName ?? ""
        let lastName = oldUserInfo?.lastName ?? ""
        let fullName = firstName.capitalized  + " " + lastName.capitalized
        
        userInfos = [fullName, oldUserInfo?.gender ?? "", oldUserInfo?.dateOfBirth ?? "", oldUserInfo?.userPhoneNumbers ?? ""]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        
        let nib = UINib(nibName: "UpDateUserInfoCell", bundle: nil)
        tableView.register(nib.self, forCellReuseIdentifier: "UpDateUserInfoCell")
        
        updateButton.layer.cornerRadius = 21
        updateButton.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        
        updateButton.setupAutolocalization(withKey: Constants.Strings.update, keyPath: "autolocalizationTitle")
        updateButton.setTitleColor(.white, for: .normal)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTapCellButton), name: NSNotification.Name("cellValue"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        title = "Thông Tin"
        self.setupAutolocalization(withKey: Constants.Strings.settingVCInfomation, keyPath: "title")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setUpNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topView.frame.size.height = view.safeAreaInsets.top
        topView.backgroundColor = Constants.Colors.buttonBackgroundColor.color
    }

    func setUpNavigation() {
        tableView.setContentOffset(.zero, animated: true)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        
        let backImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .white
       
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }

    
    
    @IBAction func updateButtonAction(_ sender: Any) {
        
        spinner.show(in: view)
        let fullName = userInfos[0]
        let gender = userInfos[1]
        let birth = userInfos[2]
        let phone = userInfos[3]
        
        let firstName = fullName.firstName().trimmingCharacters(in: .whitespaces)
        let lastName = fullName.lastName().trimmingCharacters(in: .whitespaces)
        let email = oldUserInfo?.safeEmail ?? ""
        let description = oldUserInfo?.description ?? ""
        let avatar = oldUserInfo?.avatar ?? ""
        let background = oldUserInfo?.backgroundImage ?? ""
        let numberOfFollow = oldUserInfo?.numberOfFollowers ?? 0
        let numberOfShares = oldUserInfo?.numberOfShares ?? 0
        let numberOfLikes = oldUserInfo?.numberOfLikes ?? 0
        
       
        
        newUserInfo = ["firstName": firstName, "lastName": lastName, "gender": gender, "dateOfBirth": birth, "emailAddress": email, "avatar": avatar, "backgroundImage": background, "description": description, "userPhoneNumbers": phone, "numberOfFollowers": numberOfFollow, "numberOfShares": numberOfShares, "numberOfLikes": numberOfLikes]
        let user = OutDoorUser(firstName: firstName, lastName: lastName, gender: gender, dateOfBirth: birth, emailAddress: email, avatar: avatar, backgroundImage: background, description: description, userPhoneNumbers: phone, numberOfFollowers: numberOfFollow, numberOfShares: numberOfShares, numberOfLikes: numberOfLikes)
        
        DatabaseManager.shared.updateUserInfomation(user: user) { [weak self] success in
            guard let self = self else {return}
            switch success {
                
            case true:
                print("success")
                DispatchQueue.main.async {
                    self.spinner.dismiss()
                }
                UserDefaults.standard.set(newUserInfo, forKey: "newUserInfo")
                self.navigationController?.popViewController(animated: true)
                
            case false:
                print("not success")
            }
        }
        
    }
    
    @objc private func didTapCellButton(_ notification: Notification) {
        if let dict = notification.userInfo as NSDictionary? {
                    if let userIF = dict["userInfoLable"] as? String{
                        
                        
                        userInfos[index] = userIF
                        
                        
                        
                    }
                }
    }
    
    func receiveTraillingButtonTap(_ sender: UpDateUserInfoCell) {
        let indexPath = tableView.indexPath(for: sender)
        index = indexPath!.row
      
        if index != 1 {
            if sender.edittingCell == true {
                isCellEditting = false
            }else {
                isCellEditting = true
            }
        }
        
    }
    
    func didTapTraillingCellButton() {
        let restIndex = allIndex.filter({!($0 == index)})
       let currentCell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? UpDateUserInfoCell
        if currentCell?.edittingCell == true {
            restIndex.forEach { index in
                guard index != 1 else {return}
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? UpDateUserInfoCell
                cell?.trailingButton.isEnabled = true
            }
        }else {
            restIndex.forEach { index in
                guard index != 1 else {return}
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? UpDateUserInfoCell
                cell?.trailingButton.isEnabled = false
            }
        }
    }
    
   
    
}

extension UpdateUserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userEdit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpDateUserInfoCell", for: indexPath) as? UpDateUserInfoCell
        cell?.delegate = self
        cell?.selectionStyle = .none
        let userEditText = userEdit[indexPath.row]
        cell?.updateLable.setupAutolocalization(withKey: userEditText, keyPath: "text")
        cell?.updateLable.textColor = Constants.Colors.textColorType1.color
        cell?.updateLable.font = UIFont(name: "SanFranciscoText-Regular", size: 17)
        cell?.userInfoLable.text = userInfos[indexPath.row]
        cell?.userInfoLable.textColor = Constants.Colors.textColorType6.color
        cell?.userInfoLable.font = UIFont(name: "SanFranciscoText-Regular", size: 17)
     
        
        cell?.trailingButton.setImage(UIImage(named: "Group 77"), for: .normal)
        cell?.genderButtonForMan.semanticContentAttribute = .forceRightToLeft
        cell?.genderButtonForMan.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
        
        
        
        cell?.genderButtonForWomen.semanticContentAttribute = .forceRightToLeft
        cell?.genderButtonForWomen.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
        
//        cell?.textField.text = cell?.userInfoLable.text
        cell?.textField.setupAutolocalization(withKey: cell?.userInfoLable.text, keyPath: "text")
     
        
        if userEdit[indexPath.row] != Constants.Strings.gender{
            cell?.genderButtonForMan.isHidden = true
            cell?.genderButtonForWomen.isHidden = true
        }else {
            cell?.genderButtonForMan.isHidden = false
            cell?.genderButtonForWomen.isHidden = false
            cell?.userInfoLable.isHidden = true
            cell?.trailingButton.isHidden = true
            cell?.xImage.isHidden = true
            
            if userInfos[1] == Constants.Strings.women {
                cell?.genderButtonForMan.setImage(UIImage(named: "Group 126"), for: .normal)
                cell?.genderButtonForWomen.setImage(UIImage(named: "Group 125"), for: .normal)
            }else {
                cell?.genderButtonForWomen.setImage(UIImage(named: "Group 126"), for: .normal)
                cell?.genderButtonForMan.setImage(UIImage(named: "Group 125"), for: .normal)
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
