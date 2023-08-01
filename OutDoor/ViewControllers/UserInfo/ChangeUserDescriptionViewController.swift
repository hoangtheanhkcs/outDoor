//
//  ChangeUserDescriptionViewController.swift
//  OutDoor01
//
//  Created by hoang the anh on 12/07/2023.
//

import UIKit

class ChangeUserDescriptionViewController: UIViewController {
    
    @IBOutlet weak var topview: UIScrollView!
    
    
    @IBOutlet weak var textView: UITextView!
    
    
    
    @IBOutlet weak var textCountNumber: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    private var languague:String? {
        return  UserDefaults.standard.value(forKey: "language") as? String
    }
    
    var user: OutDoorUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Chỉnh sửa giới thiệu"
        self.setupAutolocalization(withKey: Constants.Strings.changeDescription, keyPath: "title")
        textView.becomeFirstResponder()
        textView.delegate = self
       
        textView.font = Constants.Fonts.SFReguler13
        textView.textColor = Constants.Colors.textColorType1.color
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.1
        textView.layer.cornerRadius = 5
        
        
        textCountNumber.textColor = Constants.Colors.textColorType6.color
        
       
        updateButton.layer.cornerRadius = 21
        updateButton.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        updateButton.setupAutolocalization(withKey: Constants.Strings.update, keyPath: "autolocalizationTitle")
        updateButton.setTitleColor(.white, for: .normal)
        let saveTitle = Constants.Strings.save.addLocalization(str: languague ?? "vi")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: saveTitle, image: nil, target: self, action: #selector(saveDidTap))
        
        let yourBackImage = UIImage(named: "Group 40")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        topview.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        setUpNavigation()
        setupSubviews()
        updateCharacterCount()
    }
    
    func setUpNavigation() {
        
        
        
        let backImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        let closeVC = Constants.Strings.closeVC.addLocalization(str: languague ?? "vi")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: closeVC, style: .done, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .white
       
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func setupSubviews() {
        guard let userIFValue =  UserDefaults.standard.value(forKey: "userIFValue") as? [String:Any] else {return}
        updateSubviews(userInfo: userIFValue)
    }
    
    func updateSubviews(userInfo: [String:Any]) {
       
        
        var description = ""
        if let updateDS = UserDefaults.standard.value(forKey: "userDSValue") as? String {
            if updateDS.count == 0 {
                description = user?.description ?? ""
            }else {
                description = updateDS
            }
        }else {
            description = userInfo["description"] as? String ?? ""
        }
//        textView.text = description
        textView.setupAutolocalization(withKey: description, keyPath: "text")
    }
    

    @IBAction func updateAction(_ sender: Any) {
        
        let updateDescription = textView.text
        let userDescription = OutDoorUser(description: updateDescription)
        DatabaseManager.shared.updateUserDescription(user: userDescription) {[weak self] success in
            guard let self = self else {return}
            switch success {
                
            case true:
                print("success to update description")
                self.navigationController?.popViewController(animated: true)
            case false:
                print("faile to update description")
                return
            }
        }
        
        
        
        
        
        
    }
    
    @objc func saveDidTap() {
        let updateDescription = textView.text
        let userDescription = OutDoorUser(description: updateDescription)
        DatabaseManager.shared.updateUserDescription(user: userDescription) { success in
            switch success {
                
            case true:
                print("success to update description")
            case false:
                print("faile to update description")
            }
        }
        
        
    }
    func updateCharacterCount() {
        
        if textView.text.count == 0 {
            self.textCountNumber.text = "0/100"
           
        }else {
            self.textCountNumber.text = "\(textView.text.count)/100"
            
        }
        
     }

}

extension ChangeUserDescriptionViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      
        return textView.text.count < 100
    }

  
    
    func textViewDidChange(_ textView: UITextView) {
       
        updateCharacterCount()
        
    }
     
}
