//
//  SettingViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 27/07/2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import JGProgressHUD

protocol SettingViewControllerDelegate: class {
    func updateAvatar(avatarImage: String?)
    func updateBackground(backgroundImage: String?)
}

extension SettingViewControllerDelegate {
    func updateAvatar(avatarImage: String?) {}
    func updateBackground(backgroundImage: String?) {}
}

class SettingViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private var languague:String? {
        return  UserDefaults.standard.value(forKey: "language") as? String
    }
    private let spinner = JGProgressHUD(style: .dark)
    var sections :[String] {
        return [Constants.Strings.settingVCInfomation, Constants.Strings.setting]
    }
    var settings: [[Setting]] = []
    var user: OutDoorUser?
    weak var delegate : SettingViewControllerDelegate?
    var typeOfImage = ""
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = Constants.Strings.setting
        self.setupAutolocalization(withKey: Constants.Strings.setting, keyPath: "title")
//        sections = SettingData.shared.getAllSectionSetting()
        settings = SettingData.shared.getAllSetting()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .darkContent
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        setUpNavigation()

    }
    func setUpNavigation() {
       
        let backImage = UIImage(named: "Group 40")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
       
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }


}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.section]
       
        if section == sections[0] {

            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel?.text = settings[indexPath.section][indexPath.row].title
            let title = settings[indexPath.section][indexPath.row].title
            cell.textLabel?.setupAutolocalization(withKey: title, keyPath: "text")
            print(settings[indexPath.section][indexPath.row].title)
            cell.textLabel?.font = UIFont(name: "SanFranciscoText-Light", size: 17)

            return cell
        }
        if section == sections[1]  {
            
            let nib = UINib(nibName: "SettingCell", bundle: nil)

            tableView.register(nib.self, forCellReuseIdentifier: "SettingCell")
           let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
            let title = settings[indexPath.section][indexPath.row].title
            cell.settingLable.setupAutolocalization(withKey: title, keyPath: "text")
            
            
            cell.settingLable.font = UIFont(name: "SanFranciscoText-Light", size: 17)

            cell.firstButton.setupAutolocalization(withKey: "   Vie", keyPath: "autolocalizationTitle")
            cell.firstButton.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
            

            cell.secondButton.setupAutolocalization(withKey: "   Eng", keyPath: "autolocalizationTitle")
            cell.secondButton.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
            if settings[indexPath.section][indexPath.row].button != nil {
                cell.firstButton.isHidden = false
                cell.secondButton.isHidden = false
                cell.switchButton.isHidden = true
                
            } else if settings[indexPath.section][indexPath.row].switchButton != nil{
                cell.firstButton.isHidden = true
                cell.secondButton.isHidden = true
                cell.switchButton.isHidden = false
            } else if settings[indexPath.section][indexPath.row].indicator != nil{
                cell.firstButton.isHidden = true
                cell.secondButton.isHidden = true
                cell.switchButton.isHidden = true
                cell.accessoryType = .disclosureIndicator
            } else {
                cell.firstButton.isHidden = true
                cell.secondButton.isHidden = true
                cell.switchButton.isHidden = true
            }
            
            let userInforSettingTitle = settings[indexPath.section][indexPath.row].title
            if userInforSettingTitle == Constants.Strings.loggout {
                cell.settingLable.textColor = Constants.Colors.textColorType4.color
            }
            let image = UIImage(named: settings[indexPath.section][indexPath.row].image!)
            cell.settingImageView.image = image
            return cell
        }
        
       
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 40)))
        view.backgroundColor = Constants.Colors.textColorType8.color
        let lable = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 40))
        lable.font = Constants.Fonts.SFBold17
        lable.textColor = Constants.Colors.textColorType1.color
        let sectionTitle = sections[section]
        lable.setupAutolocalization(withKey: sectionTitle, keyPath: "text")
        view.addSubview(lable)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userInforSettingTitle = settings[indexPath.section][indexPath.row].title
        if userInforSettingTitle == Constants.Strings.settingVCInfomation {
            let vc = storyboard?.instantiateViewController(withIdentifier: "UserInfoDetailViewController") as? UserInfoDetailViewController
            vc?.modalPresentationStyle = .fullScreen
            vc?.user = user
            navigationController?.pushViewController(vc!, animated: true)
        }
        
        if userInforSettingTitle == Constants.Strings.updateAvatar {
            
           
            let title = Constants.Strings.changeAvatar.addLocalization(str: languague ?? "vi")
            let actionSheet = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
            actionSheet.setTitle(font: .boldSystemFont(ofSize: 17), color: Constants.Colors.textColorType3.color)
            actionSheet.setTint(color: Constants.Colors.textColorType7.color)
            
            let takeNPT = Constants.Strings.alertChangeAvatarTakeNewPhoto.addLocalization(str: languague ?? "vi")
            let takeNewPhoto = UIAlertAction(title: takeNPT, style: .default) {[weak self] _ in
                guard let self = self else {return}
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.typeOfImage = "avatar"
                self.present(picker, animated: true)
            }
            
            
            let choosePT = Constants.Strings.alertChangeAvatarChoosePhotoFromLibrary.addLocalization(str: languague ?? "vi")
            let getPhotoInYourDevice = UIAlertAction(title: choosePT, style: .default) {[weak self] _ in
                guard let self = self else {return}
                
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                self.typeOfImage = "avatar"
                self.present(picker, animated: true)
            }
            
            let cancelTitle = Constants.Strings.cancel.addLocalization(str: languague ?? "vi")
            let cancle = UIAlertAction(title: cancelTitle, style: .cancel)
            
            actionSheet.addAction(takeNewPhoto)
            actionSheet.addAction(getPhotoInYourDevice)
            actionSheet.addAction(cancle)
            
            actionSheet.setBackgroudColor(color: .white)
            present(actionSheet, animated: true)
        }
        
        if userInforSettingTitle == Constants.Strings.updateBackground {
            let titleSheet = Constants.Strings.changeBackground.addLocalization(str: languague ?? "vi")
            let actionSheet = UIAlertController(title: titleSheet, message: "", preferredStyle: .actionSheet)
            actionSheet.setTitle(font: .boldSystemFont(ofSize: 17), color: Constants.Colors.textColorType3.color)
            actionSheet.setTint(color: Constants.Colors.textColorType7.color)
            
            let takeNPT = Constants.Strings.alertChangeAvatarTakeNewPhoto.addLocalization(str: languague ?? "vi")
            let takeNewPhoto = UIAlertAction(title: takeNPT, style: .default) { [weak self] _ in
                guard let self = self else {return}
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.typeOfImage = "background"
                self.present(picker, animated: true)
            }
            
            let choosePT = Constants.Strings.alertChangeAvatarChoosePhotoFromLibrary.addLocalization(str: languague ?? "vi")
            let getPhotoInYourDevice = UIAlertAction(title: choosePT, style: .default) {[weak self] _ in
                guard let self = self else {return}
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                self.typeOfImage = "background"
                self.present(picker, animated: true)
            }
            
            let cancelTitle = Constants.Strings.cancel.addLocalization(str: languague ?? "vi")
            let cancle = UIAlertAction(title: cancelTitle, style: .cancel)
            
            actionSheet.addAction(takeNewPhoto)
            actionSheet.addAction(getPhotoInYourDevice)
            actionSheet.addAction(cancle)
            
            present(actionSheet, animated: true)
        }
        
        if userInforSettingTitle == Constants.Strings.updateDescription {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChangeUserDescriptionViewController") as? ChangeUserDescriptionViewController
            vc?.user = user
            let closeVC = Constants.Strings.closeVC.addLocalization(str: languague ?? "vi")
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: closeVC, style: .done, target: nil, action: nil)
            navigationController?.pushViewController(vc!, animated: true)
        }
        
       
        if userInforSettingTitle == Constants.Strings.loggout {
            spinner.show(in: view)
            
           
            
            
            FBSDKLoginKit.LoginManager().logOut()
            GIDSignIn.sharedInstance.signOut()
            UserDefaults.standard.set("", forKey: "userInfo")
            UserDefaults.standard.set("", forKey: "userIFValue")
            UserDefaults.standard.set("", forKey: "newUserInfo")
            UserDefaults.standard.set("", forKey: "userDSValue")
            
            
            
            do{
                try FirebaseAuth.Auth.auth().signOut()
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
                vc?.modalPresentationStyle = .fullScreen
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.spinner.dismiss()
                    self.present(vc!, animated: false)
                }
                
            }catch {
                print("Failed to log out")
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

extension SettingViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage, let data = selectedImage.pngData() else {
            return
        }
        
        spinner.show(in: view)
        
        var fileName = ""
        if self.typeOfImage == "avatar" {
            fileName = user?.profilePictureFileName ?? ""
        }else if self.typeOfImage == "background" {
            fileName = user?.profilePictureBackgoundFileName ?? ""
        }
        StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName) {[weak self] (result: Result<String, Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let downloadUrl):
                DatabaseManager.shared.updateUserImageAvatar(user: self.user, urlUpdate: downloadUrl) { succsess in
                    
                    switch succsess {
                    case true:
                        DispatchQueue.main.async {
                            if self.typeOfImage == "avatar" {
                                self.delegate?.updateAvatar(avatarImage: downloadUrl)
                            }else if self.typeOfImage == "background" {
                                self.delegate?.updateBackground(backgroundImage: downloadUrl)
                            }
                            self.spinner.dismiss()
                            self.navigationController?.popViewController(animated: true)
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





class SettingData {
    
    
    static let shared = SettingData()
    
   
    func getAllSectionSetting() -> [SectionSetting] {
        let section = [SectionSetting(title: Constants.Strings.settingVCInfomation, identifier: 0), SectionSetting(title: Constants.Strings.setting, identifier: 1)]
        
        return section
    }
    
    func getAllSetting() -> [[Setting]] {
        let setting1: [Setting] = [Setting(title: Constants.Strings.settingVCInfomation), Setting(title: Constants.Strings.updateAvatar), Setting(title: Constants.Strings.updateBackground), Setting(title: Constants.Strings.updateDescription)]
        
        
        let setting2: [Setting] = [Setting(title: Constants.Strings.receiveNotification, image: "ic_noti_setting", switchButton: true), Setting(title: Constants.Strings.policy, image: "ic_policy", indicator: true), Setting(title: Constants.Strings.provision, image: "ic_terminal", indicator: true), Setting(title: Constants.Strings.reports, image: "ic_report", indicator: true), Setting(title: Constants.Strings.language, image: "ic_language", button: true), Setting(title: Constants.Strings.instruct, image: "ic_open_intro"), Setting(title: Constants.Strings.loggout, image: "ic_logout")]
        
        return [setting1, setting2]
    }
}
