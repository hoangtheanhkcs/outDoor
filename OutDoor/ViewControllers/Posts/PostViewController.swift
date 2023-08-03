//
//  PostViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 02/08/2023.
//

import UIKit

enum TypeOfPost {
    case articlePost, toolsPost
}

class PostViewController: UIViewController {
    
    var typeOfPost: TypeOfPost = .articlePost
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var groupView: UIView!
    
    private var groundView = UIView()
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var emptyImageView: UIImageView!
    
    @IBOutlet weak var emptyLable: UILabel!
    
    @IBOutlet weak var uploadPhoto: UIButton!
    
    @IBOutlet weak var uploadedPhotoImv: UIImageView!
    
    @IBOutlet weak var closeUplaodedPhotoBT: UIButton!
    
    @IBOutlet weak var postImageReport: UILabel!
    
    @IBOutlet weak var postLableReport: UILabel!
    
    @IBOutlet weak var postDescriptionReport: UILabel!
    
    private var imagePlaneColor: UIColor = Constants.Colors.paperPlane.color {
        didSet {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: Constants.Images.paperPlane)?.imageWithColor(color: imagePlaneColor), style: .plain, target: self, action: #selector(didTapPaperPlane))
        }
    }
    
    
    private var languague:String? {
        return  UserDefaults.standard.value(forKey: "language") as? String
    }
    
    
    private var imageUpload: UIImage? = nil {
        didSet {
            if imageUpload == nil {
                uploadedPhotoImv.isHidden = true
                closeUplaodedPhotoBT.isHidden = true
                emptyImageView.isHidden = false
                emptyLable.isHidden = false
                uploadPhoto.isHidden = false
            } else {
                uploadedPhotoImv.isHidden = false
                closeUplaodedPhotoBT.isHidden = false
                emptyImageView.isHidden = true
                emptyLable.isHidden = true
                uploadPhoto.isHidden = true
                postImageReport.setupAutolocalization(withKey: "", keyPath: "text")
            }
        }
    }
    
    
    @IBOutlet weak var articleTitleTextField: UITextField!
    
    @IBOutlet weak var contentArticleTextView: UITextView!
    
    @IBOutlet weak var keyboardGruopView: UIView!
    
    @IBOutlet weak var bottomConstants: NSLayoutConstraint!
    
    
    @IBOutlet weak var postImageKeyboardBT: UIButton!
    
    @IBOutlet weak var postVideoKeyboardBT: UIButton!
    
    @IBOutlet weak var postLocationKeyboardBT: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardGruopView.isHidden = true
        self.setupAutolocalization(withKey: Constants.Strings.postArticle, keyPath: "title")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Fonts.SFBold17]
        setupSubview()
        contentArticleTextView.delegate = self
        articleTitleTextField.delegate = self
        postImageReport.setupAutolocalization(withKey: "", keyPath: "text")
        postLableReport.setupAutolocalization(withKey: "", keyPath: "text")
        postDescriptionReport.setupAutolocalization(withKey: "", keyPath: "text")
        contentArticleTextView.autocorrectionType = .no
        contentArticleTextView.spellCheckingType = .no
        articleTitleTextField.autocorrectionType = .no
        articleTitleTextField.spellCheckingType = .no
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisplay), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHiddens), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        keyboardWillHidden()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .darkContent
        navigationController?.navigationBar.tintColor = Constants.Colors.paperPlane.color
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.textColorType1.color]
        setUpNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        groundView.frame.size = CGSize(width: containerView.bounds.width, height: containerView.bounds.height)
        groundView.frame.origin = CGPoint(x: containerView.frame.origin.x, y: containerView.frame.origin.y)
        groundView.addDashedBorder(Constants.Colors.emptyPhoto.color, withWidth: 2, cornerRadius: 5, dashPattern: [4, 4])
        groupView.insertSubview(groundView, belowSubview: containerView)
        groupView.backgroundColor = .clear
    }
    func setUpNavigation() {
       
//        let backImage = UIImage(named: "Group 40")
//        self.navigationController?.navigationBar.backIndicatorImage = backImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constants.Colors.paperPlane.color
       
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    

    private func setupSubview() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: Constants.Images.paperPlane), style: .plain, target: self, action: #selector(didTapPaperPlane))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: Constants.Images.xIcon), style: .done, target: self, action: #selector(didTapXIcon))
        
        
        separateView.backgroundColor = Constants.Colors.emptyPhoto.color
        
//        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        groundView.backgroundColor = Constants.Colors.textColorType8.color
        groundView.layer.cornerRadius = 5
        
        containerView.backgroundColor = .clear
        containerView.layer.cornerRadius = 5
//        containerView.addDashedBorder(Constants.Colors.emptyPhoto.color, withWidth: 2, cornerRadius: 5, dashPattern: [4, 4])
        
        
        emptyImageView.image = UIImage(named: Constants.Images.emptyImage)
        emptyLable.setupAutolocalization(withKey: Constants.Strings.postProfilePicture, keyPath: "text")
        emptyLable.font = Constants.Fonts.SFLight15
        uploadPhoto.setupAutolocalization(withKey: Constants.Strings.uploadPhoto, keyPath: "autolocalizationTitle")
        uploadPhoto.changeButtonFont(Constants.Fonts.SFLight16)
        uploadPhoto.setTitleColor(Constants.Colors.textColorType5.color, for: .normal)
        uploadPhoto.layer.cornerRadius = 21
        uploadPhoto.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        uploadPhoto.setImage(UIImage(named: Constants.Images.uploadButton), for: .normal)
        
        
        
        
        contentArticleTextView.layer.borderWidth = 1
        contentArticleTextView.layer.borderColor = Constants.Colors.textColorType8.color.cgColor
        contentArticleTextView.layer.cornerRadius = 6
        contentArticleTextView.translatesAutoresizingMaskIntoConstraints = true
        contentArticleTextView.isScrollEnabled = false
        contentArticleTextView.textContainerInset = UIEdgeInsets(top: 10, left: 3, bottom: 15, right: 0)
        contentArticleTextView.backgroundColor = .white
        contentArticleTextView.font = Constants.Fonts.SFReguler17
        
        
        articleTitleTextField.font = Constants.Fonts.SFReguler17
        articleTitleTextField.textColor = Constants.Colors.textColorType6.color
        articleTitleTextField.autocapitalizationType = .sentences
        
        postImageReport.font = Constants.Fonts.SFLight13
        postImageReport.textColor = Constants.Colors.buttonBackgroundColor.color
        postLableReport.font = Constants.Fonts.SFLight13
        postLableReport.textColor = Constants.Colors.buttonBackgroundColor.color
        postDescriptionReport.font = Constants.Fonts.SFLight13
        postDescriptionReport.textColor = Constants.Colors.buttonBackgroundColor.color
        
        if imageUpload == nil {
            uploadedPhotoImv.isHidden = true
            closeUplaodedPhotoBT.isHidden = true
            emptyImageView.isHidden = false
            emptyLable.isHidden = false
            uploadPhoto.isHidden = false
        } else {
            uploadedPhotoImv.isHidden = false
            closeUplaodedPhotoBT.isHidden = false
            emptyImageView.isHidden = true
            emptyLable.isHidden = true
            uploadPhoto.isHidden = true
        }
        
        closeUplaodedPhotoBT.setImage(UIImage(named: Constants.Images.closeUploadedPhoto), for: .normal)
        setupTextView()
        keyboardGruopView.backgroundColor = Constants.Colors.textColorType8.color
        postImageKeyboardBT.setImage(UIImage(named: Constants.Images.imageKeyboard), for: .normal)
        postVideoKeyboardBT.setImage(UIImage(named: Constants.Images.videoKeyboard), for: .normal)
        postLocationKeyboardBT.setImage(UIImage(named: Constants.Images.locationKeyboard), for: .normal)
        postImageKeyboardBT.backgroundColor = .clear
        postVideoKeyboardBT.backgroundColor = .clear
        postLocationKeyboardBT.backgroundColor = .clear
    }
    
    private func setupTextView() {
        switch typeOfPost {
        case .articlePost:
            articleTitleTextField.setupAutolocalization(withKey: Constants.Strings.articleTitle, keyPath: "placeholder")
           
        case .toolsPost:
            articleTitleTextField.setupAutolocalization(withKey: Constants.Strings.toolName, keyPath: "placeholder")
        }
        if contentArticleTextView.text.count == 0 {
            
            switch typeOfPost {
            case .articlePost:
                contentArticleTextView.setupAutolocalization(withKey: Constants.Strings.content, keyPath: "text")
            case .toolsPost:
                contentArticleTextView.setupAutolocalization(withKey: Constants.Strings.toolDescription, keyPath: "text")
            }
           
            contentArticleTextView.selectedRange = NSMakeRange(0, 0)
            contentArticleTextView.textColor = Constants.Colors.defaultPlaceHolder
        }
    }

    @IBAction func uploadPhotoBTAction(_ sender: Any) {
       
        
    }
    
    
    @IBAction func closeUplaodedPhotoBTAction(_ sender: Any) {
    }
    
    @objc private func didTapPaperPlane(_ sender : UIBarButtonItem) {
        
        if imageUpload == nil {
            postImageReport.setupAutolocalization(withKey: Constants.Strings.postImageReport, keyPath: "text")
            containerView.addDashedBorder(Constants.Colors.buttonBackgroundColor.color, withWidth: 2, cornerRadius: 5, dashPattern: [4, 4])
            
        }else {
            postImageReport.setupAutolocalization(withKey: "", keyPath: "text")
        }
        
        switch typeOfPost {
        case .articlePost:
            if articleTitleTextField.text?.count == 0 {
                postLableReport.setupAutolocalization(withKey: Constants.Strings.postLableReport, keyPath: "text")
            }else {
                postLableReport.setupAutolocalization(withKey: "", keyPath: "text")
            }
            if contentArticleTextView.text == Constants.Strings.content.addLocalization(str: languague!) || contentArticleTextView.text.count == 0 {
                postDescriptionReport.setupAutolocalization(withKey: Constants.Strings.postDescriptionReport, keyPath: "text")
            }else {
                postDescriptionReport.setupAutolocalization(withKey: "", keyPath: "text")
            }
        case .toolsPost:
            if articleTitleTextField.text?.count == 0 {
                postLableReport.setupAutolocalization(withKey: Constants.Strings.postToolNameReport, keyPath: "text")
            }else {
                postLableReport.setupAutolocalization(withKey: "", keyPath: "text")
            }
            
            if contentArticleTextView.text == Constants.Strings.toolDescription.addLocalization(str: languague!) || contentArticleTextView.text.count == 0  {
                postDescriptionReport.setupAutolocalization(withKey: Constants.Strings.postToolDescriptionReport, keyPath: "text")
            }else {
                postDescriptionReport.setupAutolocalization(withKey: "", keyPath: "text")
            }
        }
       
        
        if postImageReport.text?.count == 0 && postLableReport.text?.count == 0 && postDescriptionReport.text?.count == 0 {
            sender.tintColor = Constants.Colors.planeCheckOk.color
        }else {
            sender.tintColor = Constants.Colors.buttonBackgroundColor.color
        }
        
        articleTitleTextField.resignFirstResponder()
        contentArticleTextView.resignFirstResponder()
        self.bottomConstants.constant = 0
        self.keyboardGruopView.isHidden = true
    }
    
    @objc private func didTapXIcon() {
        self.dismiss(animated: true)
        
    }
    
    @objc private func keyboardWillDisplay(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardReactangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardReactangle.height
            self.keyboardGruopView.isHidden = false
            self.bottomConstants.constant = keyboardHeight - 34
            
        }
    }
    
    @objc private func keyboardWillHiddens() {
        articleTitleTextField.resignFirstResponder()
        contentArticleTextView.resignFirstResponder()
        self.bottomConstants.constant = 0
        self.keyboardGruopView.isHidden = true
    }
    
    private func keyboardWillHidden() {
        let tapToHiddenKeyboard = UITapGestureRecognizer(target: self, action: #selector(didTapToView))
        view.addGestureRecognizer(tapToHiddenKeyboard)
    }
    @objc private func didTapToView() {
        view.endEditing(true)
        articleTitleTextField.resignFirstResponder()
        contentArticleTextView.resignFirstResponder()
        self.bottomConstants.constant = 0
        self.keyboardGruopView.isHidden = true
    }
    
    @IBAction func postImageKBAction(_ sender: Any) {
        
    }
    @IBAction func postVideoKBAction(_ sender: Any) {
        
    }
    @IBAction func postLocationKBAction(_ sender: Any) {
        
    }
    
    
}


extension PostViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch typeOfPost {
        case .articlePost:
            let placeholder = Constants.Strings.content.addLocalization(str: languague ?? "vi")
            if textView.text == placeholder {
                textView.text = ""
            }
        case .toolsPost:
            let placeholder = Constants.Strings.toolDescription.addLocalization(str: languague ?? "vi")
            if textView.text == placeholder {
                textView.text = ""
            }
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            
            switch typeOfPost {
            case .articlePost:
                textView.setupAutolocalization(withKey: Constants.Strings.content, keyPath: "text")
            case .toolsPost:
                textView.setupAutolocalization(withKey: Constants.Strings.toolDescription, keyPath: "text")
            }
           
            textView.selectedRange = NSMakeRange(0, 0)
            textView.textColor = Constants.Colors.defaultPlaceHolder
        }
    }
    func textViewDidChange(_ textView: UITextView) {
          let fixedWidth = textView.frame.size.width
          let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
          var newFrame = textView.frame
          newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
          textView.frame = newFrame
        
        textView.settingSpacing(lineSpacing: 5, textAlignment: .left)
        
        if textView.text.count == 0 {
            
            switch typeOfPost {
            case .articlePost:
                textView.setupAutolocalization(withKey: Constants.Strings.content, keyPath: "text")
            case .toolsPost:
                textView.setupAutolocalization(withKey: Constants.Strings.toolDescription, keyPath: "text")
            }
           
            textView.selectedRange = NSMakeRange(0, 0)
            textView.textColor = Constants.Colors.defaultPlaceHolder
        }else {
            textView.textColor = Constants.Colors.textColorType6.color
            postDescriptionReport.setupAutolocalization(withKey: "", keyPath: "text")
        }
    }
}
extension PostViewController: UITextFieldDelegate {
  
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count != 0 {
            postLableReport.setupAutolocalization(withKey: "", keyPath: "text")
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentArticleTextView.becomeFirstResponder()
    }
    
    
}

