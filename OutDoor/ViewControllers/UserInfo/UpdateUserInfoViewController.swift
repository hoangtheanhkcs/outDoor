//
//  UpdateUserInfoViewController.swift
//  OutDoor01
//
//  Created by hoang the anh on 12/07/2023.
//

import UIKit

protocol UpdateUserInfoViewControllerDeleage :class {
    func receiveTraillingButtonTap(_ sender: UpDateUserInfoCell)
    func didTapTraillingCellButton()
}

class UpdateUserInfoViewController: UIViewController,  UpdateUserInfoViewControllerDeleage {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    

    
    var userEdit :[String] = ["Tên", "Giới tính", "Ngày sinh", "Điện thoại"]
    var userInfos :[String] = []
    var newUserInfo: OutDoorUser?
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        
        let nib = UINib(nibName: "UpDateUserInfoCell", bundle: nil)
        tableView.register(nib.self, forCellReuseIdentifier: "UpDateUserInfoCell")
        
        updateButton.layer.cornerRadius = 21
        updateButton.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        updateButton.setTitle("Cập nhật", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        
        
        
        setupSubviews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTapCellButton), name: NSNotification.Name("cellValue"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Thông Tin"
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

    
    
    private func setupSubviews() {
         guard let userInfo = UserDefaults.standard.value(forKey: "userIFValue") as? [String:Any] else {return}
         updateSubviews(userInfo: userInfo)
         
        
         
     }
     
     func updateSubviews(userInfo: [String:Any]) {
         let firstName = userInfo["first_name"] as? String ?? ""
         let lastName = userInfo["last_name"] as? String ?? ""
         let description = userInfo["description"] as? String ?? ""
         let gender = userInfo["gender"] as? String ?? ""
         let birthday = userInfo["dateOfBirth"] as? String ?? ""
         let phoneNumber = userInfo["phoneNumber"] as? String ?? ""
          
         let userName = firstName.capitalized  + " " + lastName.capitalized
         
         userInfos = [userName, gender, birthday, phoneNumber]
        
     }
    
    
    
  
    
    @IBAction func updateButtonAction(_ sender: Any) {
        let oldUserInfo =  UserDefaults.standard.value(forKey: "userIFValue") as? [String:Any]
        let fullName = userInfos[0]
        let gender = userInfos[1]
        let birth = userInfos[2]
        let phone = userInfos[3]
        
        let firstName = fullName.firstName().trimmingCharacters(in: .whitespaces)
        let lastName = fullName.lastName().trimmingCharacters(in: .whitespaces)
        let email = oldUserInfo?["email"] as? String ?? ""
        let description = oldUserInfo?["description"] as? String ?? ""
        
        
        newUserInfo = OutDoorUser(firstName: firstName, lastName: lastName, gender: gender, dateOfBirth: birth, emailAddress: email, description: description, userPhoneNumbers: phone)
        guard let newUserInfo = newUserInfo else {return}
        DatabaseManager.shared.updateUserInfomation(user: newUserInfo) { [weak self] success in
            guard let self = self else {return}
            switch success {
                
            case true:
                print("success")
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
        cell?.updateLable.text = userEdit[indexPath.row]
        cell?.updateLable.textColor = Constants.Colors.textColorType1.color
        cell?.updateLable.font = UIFont(name: "SanFranciscoText-Regular", size: 17)
        cell?.userInfoLable.text = userInfos[indexPath.row]
        cell?.userInfoLable.textColor = Constants.Colors.textColorType6.color
        cell?.userInfoLable.font = UIFont(name: "SanFranciscoText-Regular", size: 17)
     
        
        cell?.trailingButton.setImage(UIImage(named: "Group 77"), for: .normal)
        cell?.genderButtonForMan.semanticContentAttribute = .forceRightToLeft
        cell?.genderButtonForMan.setTitle("Nam   ", for: .normal)
        cell?.genderButtonForMan.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
        
        
        
        cell?.genderButtonForWomen.semanticContentAttribute = .forceRightToLeft
        cell?.genderButtonForWomen.setTitle("Nữ   ", for: .normal)
        cell?.genderButtonForWomen.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
        
        cell?.textField.text = cell?.userInfoLable.text
        
     
        
        if userEdit[indexPath.row] != "Giới tính" {
            cell?.genderButtonForMan.isHidden = true
            cell?.genderButtonForWomen.isHidden = true
        }else {
            cell?.genderButtonForMan.isHidden = false
            cell?.genderButtonForWomen.isHidden = false
            cell?.userInfoLable.isHidden = true
            cell?.trailingButton.isHidden = true
            cell?.xImage.isHidden = true
            
            if userInfos[1] == "Nữ" {
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
