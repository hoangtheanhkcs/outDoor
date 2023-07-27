//
//  SettingViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 27/07/2023.
//

import UIKit

class SettingViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var sections: [SectionSetting] = []
    var settings: [[Setting]] = []
    var user: OutDoorUser?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.Strings.setting
        sections = SettingData.shared.getAllSectionSetting()
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
        
        let section = sections[indexPath.section].title
       
        if section == sections[0].title {

            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = settings[indexPath.section][indexPath.row].title
            print(settings[indexPath.section][indexPath.row].title)
            cell.textLabel?.font = UIFont(name: "SanFranciscoText-Light", size: 17)

            return cell
        }
        if section == sections[1].title  {
            
            let nib = UINib(nibName: "SettingCell", bundle: nil)

            tableView.register(nib.self, forCellReuseIdentifier: "SettingCell")
           let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
            cell.settingLable.text = settings[indexPath.section][indexPath.row].title
            cell.settingLable.font = UIFont(name: "SanFranciscoText-Light", size: 17)
            cell.firstButton.setTitle("  Vie", for: .normal)
            cell.firstButton.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
            
            cell.secondButton.setTitle("  Eng", for: .normal)
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
            if userInforSettingTitle == "Đăng xuất" {
                cell.settingLable.textColor = Constants.Colors.textColorType4.color
            }
            let image = UIImage(named: settings[indexPath.section][indexPath.row].image!)
            cell.settingImageView.image = image
            return cell
        }
        
       
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
            
        header.textLabel!.textColor = Constants.Colors.textColorType2.color
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userInforSettingTitle = settings[indexPath.section][indexPath.row].title
        if userInforSettingTitle == "Thông tin" {
            
        }
        
        if userInforSettingTitle == "Cập nhật ảnh đại diện" {
            
           
            
            let actionSheet = UIAlertController(title: "Thay ảnh đại diện", message: "", preferredStyle: .actionSheet)
            actionSheet.setTitle(font: .boldSystemFont(ofSize: 17), color: Constants.Colors.textColorType3.color)
            actionSheet.setTint(color: Constants.Colors.textColorType7.color)
            
            let takeNewPhoto = UIAlertAction(title: "Chụp ảnh mới", style: .default) { _ in
                
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true)
            }
            
            let getPhotoInYourDevice = UIAlertAction(title: "Chọn ảnh từ thiết bị", style: .default) { _ in
                print("Chọn ảnh từ thiết bị")
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true)
            }
            
            let cancle = UIAlertAction(title: "Hủy", style: .cancel)
            
            actionSheet.addAction(takeNewPhoto)
            actionSheet.addAction(getPhotoInYourDevice)
            actionSheet.addAction(cancle)
            
            actionSheet.setBackgroudColor(color: .white)
            present(actionSheet, animated: true)
        }
        
        if userInforSettingTitle == "Cập nhật ảnh bìa" {
            let actionSheet = UIAlertController(title: "Thay ảnh bìa", message: "", preferredStyle: .actionSheet)
            actionSheet.setTitle(font: .boldSystemFont(ofSize: 17), color: Constants.Colors.textColorType3.color)
            actionSheet.setTint(color: Constants.Colors.textColorType7.color)
            
            let takeNewPhoto = UIAlertAction(title: "Chụp ảnh mới", style: .default) { _ in
                print("chụp ảnh mới")
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true)
            }
            let getPhotoInYourDevice = UIAlertAction(title: "Chọn ảnh từ thiết bị", style: .default) { _ in
                print("Chọn ảnh từ thiết bị")
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true)
            }
            
            let cancle = UIAlertAction(title: "Hủy", style: .cancel)
            
            actionSheet.addAction(takeNewPhoto)
            actionSheet.addAction(getPhotoInYourDevice)
            actionSheet.addAction(cancle)
            
            present(actionSheet, animated: true)
        }
        
        if userInforSettingTitle == "Cập nhật giới thiệu bản thân" {
            
        }
        
       
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
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
