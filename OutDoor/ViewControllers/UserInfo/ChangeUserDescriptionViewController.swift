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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chỉnh sửa giới thiệu"
        textView.becomeFirstResponder()
        textView.delegate = self
        textView.text = "Thêm giới thiệu bản thân"
        textView.selectedRange = NSMakeRange(0, 0)
        textView.textColor = Constants.Colors.textColorType6.color
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.1
        textView.layer.cornerRadius = 5
        
        textCountNumber.textColor = Constants.Colors.textColorType6.color
        updateCharacterCount()
       
        updateButton.layer.cornerRadius = 21
        updateButton.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        updateButton.setTitle("Cập nhật", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Lưu", image: nil, target: self, action: #selector(saveDidTap))
        
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
    }
    
    func setUpNavigation() {
        
        
        
        let backImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Đóng", style: .done, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .white
       
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }

    @IBAction func updateAction(_ sender: Any) {
        
    }
    
    @objc func saveDidTap() {
        
    }
    func updateCharacterCount() {
        var textCount = self.textView.text.count
        if textView.text == "Thêm giới thiệu bản thân" {
            textCount = 0
        }

        self.textCountNumber.text = "\((0) + textCount)/100"

        
     }

}

extension ChangeUserDescriptionViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == "Thêm giới thiệu bản thân" {
            textView.text = ""
            textView.textColor = Constants.Colors.textColorType1.color
        }
        return textView.text.count < 100
    }

  
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
           
            textView.text = "Thêm giới thiệu bản thân"
            textView.selectedRange = NSMakeRange(0, 0)
            textView.textColor = Constants.Colors.textColorType6.color
        }
        updateCharacterCount()
        
    }
     
}
