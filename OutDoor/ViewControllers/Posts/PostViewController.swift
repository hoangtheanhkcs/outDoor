//
//  PostViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 02/08/2023.
//

import UIKit
import Photos
import TheAnimation
import AVKit

enum TypeOfPost {
    case articlePost, toolsPost
}


protocol PostViewControllerDelegate:class {
    func selectedAsset(item: AssetItem)
}

class PostViewController: UIViewController, GaleryItemViewControllerDelegate {
   
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
    
    @IBOutlet weak var articleTitleTextField: UITextField!
    
    @IBOutlet weak var contentArticleTextView: UITextView!
    
    @IBOutlet weak var keyboardGruopView: UIView!
    
    @IBOutlet weak var postImageKeyboardBT: UIButton!
    
    @IBOutlet weak var postVideoKeyboardBT: UIButton!
    
    @IBOutlet weak var postLocationKeyboardBT: UIButton!
    
    @IBOutlet weak var firstPostImage: UIImageView!
    
    @IBOutlet weak var secondImage: UIImageView!
    
    @IBOutlet weak var thirstImage: UIImageView!
    
    @IBOutlet weak var fouthImage: UIImageView!
    
    @IBOutlet weak var stackPostImage: UIStackView!
    
    @IBOutlet weak var stackFirst: UIStackView!
    
    @IBOutlet weak var stackSecond: UIStackView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stackFirstWidth: NSLayoutConstraint!
    
    @IBOutlet weak var stackPostImageConstants: NSLayoutConstraint!
    
    @IBOutlet weak var gestureTapView: UIView!
    
    
    @IBOutlet weak var firstPostVideoDuration: UILabel!
    
    @IBOutlet weak var secondPostVideoDuration: UILabel!
    
    @IBOutlet weak var thistPostVideoDuration: UILabel!
    
    @IBOutlet weak var fouthPostVideoDuration: UILabel!
    
    @IBOutlet weak var postLoctionIcon: UIImageView!
    
    @IBOutlet weak var postLocationLable: UILabel!
    
    
    
    
    
    var textViewHeightChange: CGFloat? {
        didSet {
            if textViewHeightChange != oldValue {
                scrollView.scrollToBottom(animated: false)
            }
        }
    }
    
   
    
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
                uploadedPhotoImv.image = imageUpload
                closeUplaodedPhotoBT.isHidden = false
                emptyImageView.isHidden = true
                emptyLable.isHidden = true
                uploadPhoto.isHidden = true
                postImageReport.setupAutolocalization(withKey: "", keyPath: "text")
            }
        }
    }
    
    
    var chooseImagePost: [String: AssetItem?] = [:]
    
    weak var delegate: PostViewControllerDelegate?
    
    private var containerChildView: UIView?

    var galeryVC: GaleryItemViewController?
    
    var photoPostHidden:Bool = true
    var textviewExpand:CGFloat = 0
    
    @IBOutlet weak var containerPostImage01: UIView!
    
    @IBOutlet weak var containerPostImage02: UIView!
    
    @IBOutlet weak var containerPostImage03: UIView!
    
    @IBOutlet weak var containerPostImage04: UIView!
    
    
    enum PostButton {
        case image, video, locaton, keyboard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubview()
        setupKeyboardWithComponent()
        setupTextViewTextField()
        setPostImagePostVideoShowInView()
        
        containerChildView?.frame = CGRect(x: 0, y: keyboardGruopView.frame.maxY, width: view.bounds.width, height: view.bounds.height - keyboardGruopView.frame.maxY)
        galeryVC?.view.frame = containerChildView!.bounds
        containerChildView?.addSubview(galeryVC!.view)
    containerChildView?.isHidden = true
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisplay), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHiddens), name: UIResponder.keyboardWillHideNotification, object: nil)
     
    }
    
    private func setupTextViewTextField() {
        contentArticleTextView.delegate = self
        articleTitleTextField.delegate = self
        postImageReport.setupAutolocalization(withKey: "", keyPath: "text")
        postLableReport.setupAutolocalization(withKey: "", keyPath: "text")
        postDescriptionReport.setupAutolocalization(withKey: "", keyPath: "text")
        contentArticleTextView.autocorrectionType = .no
        contentArticleTextView.spellCheckingType = .no
        articleTitleTextField.autocorrectionType = .no
        articleTitleTextField.spellCheckingType = .no
        
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
    }
    
    private func setPostImagePostVideoShowInView() {
        stackFirstWidth.constant = (containerView.bounds.width - 10)/2
        
        stackPostImageConstants.constant = 0
        stackFirst.backgroundColor = .clear
        stackSecond.backgroundColor = .clear
        stackPostImage.backgroundColor = .clear
        
        firstPostVideoDuration.layer.cornerRadius = 6.5
        firstPostVideoDuration.layer.masksToBounds = true
        firstPostVideoDuration.isHidden = true
        
        secondPostVideoDuration.layer.cornerRadius = 6.5
        secondPostVideoDuration.layer.masksToBounds = true
        secondPostVideoDuration.isHidden = true
        
        thistPostVideoDuration.layer.cornerRadius = 6.5
        thistPostVideoDuration.layer.masksToBounds = true
        thistPostVideoDuration.isHidden = true
        
        fouthPostVideoDuration.layer.cornerRadius = 6.5
        fouthPostVideoDuration.layer.masksToBounds = true
        fouthPostVideoDuration.isHidden = true
        
        
        postLoctionIcon.image = UIImage(named: Constants.Images.locationKeyboard)
        postLocationLable.text = "775 Rolling Green Rd."
        
        
    }
    
    private func setupKeyboardWithComponent() {
        keyboardGruopView.backgroundColor = Constants.Colors.textColorType8.color
        keyboardGruopView.isHidden = true
        
        keyboardWillHidden()
        
        postImageKeyboardBT.setImage(UIImage(named: Constants.Images.imageKeyboard), for: .normal)
        postVideoKeyboardBT.setImage(UIImage(named: Constants.Images.videoKeyboard), for: .normal)
        postLocationKeyboardBT.setImage(UIImage(named: Constants.Images.locationKeyboard), for: .normal)
        postImageKeyboardBT.backgroundColor = .clear
        postVideoKeyboardBT.backgroundColor = .clear
        postLocationKeyboardBT.backgroundColor = .clear
        
        
        containerChildView = UIView()
        view.addSubview(containerChildView!)
       
        
      
        
        
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
        
        galeryVC = storyboard?.instantiateViewController(withIdentifier: "GaleryItemViewController") as? GaleryItemViewController
        galeryVC?.delegate = self
       
        self.delegate = galeryVC
        addChild(galeryVC!)
        galeryVC?.didMove(toParent: self)
        
        
        self.setupAutolocalization(withKey: Constants.Strings.postArticle, keyPath: "title")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Fonts.SFBold17]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: Constants.Images.paperPlane), style: .plain, target: self, action: #selector(didTapPaperPlane))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: Constants.Images.xIcon), style: .done, target: self, action: #selector(didTapXIcon))
        
        
        separateView.backgroundColor = Constants.Colors.emptyPhoto.color
        groundView.backgroundColor = Constants.Colors.textColorType8.color
        groundView.layer.cornerRadius = 5
        
        containerView.backgroundColor = .clear
        containerView.layer.cornerRadius = 5

        uploadedPhotoImv.contentMode = .scaleToFill
        closeUplaodedPhotoBT.backgroundColor = .clear
        
        emptyImageView.image = UIImage(named: Constants.Images.emptyImage)
        emptyLable.setupAutolocalization(withKey: Constants.Strings.postProfilePicture, keyPath: "text")
        emptyLable.font = Constants.Fonts.SFLight15
        uploadPhoto.setupAutolocalization(withKey: Constants.Strings.uploadPhoto, keyPath: "autolocalizationTitle")
        uploadPhoto.changeButtonFont(Constants.Fonts.SFLight16)
        uploadPhoto.setTitleColor(Constants.Colors.textColorType5.color, for: .normal)
        uploadPhoto.layer.cornerRadius = 21
        uploadPhoto.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        uploadPhoto.setImage(UIImage(named: Constants.Images.uploadButton), for: .normal)
        
    
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
    }
    
   
    
    
    
    @IBAction func closeBT01Action(_ sender: Any) {
        guard let item = chooseImagePost["image01"] as? AssetItem else {return}
        delegate?.selectedAsset(item: item)
        containerPostImage01.isHidden = true
        
        updateStackView()
    }
    
    
    @IBAction func closeBT02Action(_ sender: Any) {
        guard let item = chooseImagePost["image02"] as? AssetItem else {return}
        delegate?.selectedAsset(item: item)
        containerPostImage02.isHidden = true
        updateStackView()
    }
    
    @IBAction func closeBT03Action(_ sender: Any) {
        guard let item = chooseImagePost["image03"] as? AssetItem else {return}
        delegate?.selectedAsset(item: item)
        containerPostImage03.isHidden = true
        updateStackView()
    }
    
    @IBAction func closeBT04Action(_ sender: Any) {
        guard let item = chooseImagePost["image04"] as? AssetItem else {return}
        delegate?.selectedAsset(item: item)
        containerPostImage04.isHidden = true
        updateStackView()
    }
    
    
   
    private func updateStackView() {
        if containerPostImage01.isHidden == true && containerPostImage02.isHidden == true {
            stackSecond.axis = .horizontal
            stackFirst.isHidden = true
        }
        if containerPostImage03.isHidden == true && containerPostImage04.isHidden == true {
            stackFirst.axis = .horizontal
            stackSecond.isHidden = true
        }
        
        if containerPostImage01.isHidden == true && containerPostImage02.isHidden == true && containerPostImage03.isHidden == true && containerPostImage04.isHidden == true {
            stackPostImageConstants.constant = 0
        }
        DispatchQueue.main.async {
            self.scrollView.scrollToBottom(animated: true)
        }
        
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
       let photoAuthorization = PHPhotoLibrary.authorizationStatus()
        if photoAuthorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.gotoGaleryPhotoVC()
                } else {
                    let alert = UIAlertController(title: "Photos Access Denied", message: "App needs access to photos library.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        } else if photoAuthorization == .authorized {
            gotoGaleryPhotoVC()
        }
    }
    
    private func gotoGaleryPhotoVC() {
       
            let vc = storyboard?.instantiateViewController(withIdentifier: "GaleryItemViewController") as? GaleryItemViewController
            
            vc?.assetType = .photo
        vc?.selectAssetMode = .one
            vc?.delegate = self
            vc?.heightConstantFNBT = 650
            self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
  
    
    
    @IBAction func closeUplaodedPhotoBTAction(_ sender: Any) {
        imageUpload = nil
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
            updatePostButtonState(.keyboard)
            containerChildView?.isHidden = true
        }
    }
    
    @objc private func keyboardWillHiddens() {
        articleTitleTextField.resignFirstResponder()
        contentArticleTextView.resignFirstResponder()
       

    }
    
    
    private func keyboardWillHidden() {
        let tapToHiddenKeyboard = UITapGestureRecognizer(target: self, action: #selector(didTapToView))
        gestureTapView.addGestureRecognizer(tapToHiddenKeyboard)
    }
    
    @objc private func didTapToView() {
        view.endEditing(true)
        articleTitleTextField.resignFirstResponder()
        contentArticleTextView.resignFirstResponder()
      
    }
    
    @IBAction func postImageKBAction(_ sender: Any) {
        updatePostButtonState(.image)
        let photoAuthorization = PHPhotoLibrary.authorizationStatus()
        if photoAuthorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.gotoGaleryImageVC()
                } else {
                    let alert = UIAlertController(title: "Photos Access Denied", message: "App needs access to videos library.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        } else if photoAuthorization == .authorized {
            gotoGaleryImageVC()
        }
        
    }
    private func gotoGaleryImageVC() {
       
        galeryVC?.assetType = .photo
        galeryVC?.selectAssetMode = .four
    
        containerChildView?.isHidden = false
        
        keyboardWillHiddens()
    }
    
  
    @IBAction func postVideoKBAction(_ sender: Any) {
        updatePostButtonState(.video)
        let photoAuthorization = PHPhotoLibrary.authorizationStatus()
         if photoAuthorization == .notDetermined {
             PHPhotoLibrary.requestAuthorization({status in
                 if status == .authorized{
                     self.gotoGaleryVideoVC()
                 } else {
                     let alert = UIAlertController(title: "Photos Access Denied", message: "App needs access to videos library.", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
                 }
             })
         } else if photoAuthorization == .authorized {
             gotoGaleryVideoVC()
         }
        
    }
    
    private func gotoGaleryVideoVC() {
        
        updatePostButtonState(.video)
        galeryVC?.assetType = .video
        galeryVC?.selectAssetMode = .four
        
        
        containerChildView?.isHidden = false
        keyboardWillHiddens()
        
    }
    
    
    
    @IBAction func postLocationKBAction(_ sender: Any) {
        updatePostButtonState(.locaton)
        containerChildView?.isHidden = true
        
        keyboardWillHiddens()
    }
    
    
    
    @IBAction func downForPostKeyboardAction(_ sender: Any) {
        
        keyboardGruopView.isHidden = true
        containerChildView?.isHidden = true
        keyboardWillHiddens()
    }
    
    
   
    private func updatePostButtonState(_ buttonSelect: PostButton) {
        if buttonSelect == .image {
            postImageKeyboardBT.setImage(UIImage(named: Constants.Images.imageKeyboard)?.imageWithColor(color: Constants.Colors.buttonBackgroundColor.color), for: .normal)
            
            
            postVideoKeyboardBT.setImage(UIImage(named: Constants.Images.videoKeyboard), for: .normal)
            
            
            postLocationKeyboardBT.setImage(UIImage(named: Constants.Images.locationKeyboard), for: .normal)
        }
        if buttonSelect == .video {
            postImageKeyboardBT.setImage(UIImage(named: Constants.Images.imageKeyboard), for: .normal)
           
            
            postVideoKeyboardBT.setImage(UIImage(named: Constants.Images.videoKeyboard)?.imageWithColor(color: Constants.Colors.buttonBackgroundColor.color), for: .normal)
            
            
            postLocationKeyboardBT.setImage(UIImage(named: Constants.Images.locationKeyboard), for: .normal)
        }
        if buttonSelect == .locaton {
            postImageKeyboardBT.setImage(UIImage(named: Constants.Images.imageKeyboard), for: .normal)
            postVideoKeyboardBT.setImage(UIImage(named: Constants.Images.videoKeyboard), for: .normal)
            postLocationKeyboardBT.setImage(UIImage(named: Constants.Images.locationKeyboard)?.imageWithColor(color: Constants.Colors.buttonBackgroundColor.color), for: .normal)
        }
        if buttonSelect == .keyboard {
            postImageKeyboardBT.setImage(UIImage(named: Constants.Images.imageKeyboard), for: .normal)
            postVideoKeyboardBT.setImage(UIImage(named: Constants.Images.videoKeyboard), for: .normal)
            postLocationKeyboardBT.setImage(UIImage(named: Constants.Images.locationKeyboard), for: .normal)
        }
        
    }
    
    func updateCollectedImage(collect: [AssetItem]) {
        if collect.count != 0 {
            imageUpload = collect.first?.image
            
        }else {
            imageUpload = nil
        }
    }
    
}


extension PostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        postImageKeyboardBT.isEnabled = true
        postVideoKeyboardBT.isEnabled = true
        postLocationKeyboardBT.isEnabled = true
        
        
        
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
        textView.frame.size.height = newFrame.height
        textViewHeightChange = newFrame.height
        
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        postImageKeyboardBT.isEnabled = false
        postVideoKeyboardBT.isEnabled = false
        postLocationKeyboardBT.isEnabled = false
    }
    
    
}



extension PostViewController {
    
    
    
    
    func updateChooseItemForPost(collect: AssetItem) {
        
        DispatchQueue.main.async {
            self.imageUpload = collect.image
        }
       
    }
    
    
    func updateCollectedItem(collect: [AssetItem]) {
        
        
       
         guard collect.count <= 4 else {return}
         if collect.count == 0 {
             stackPostImageConstants.constant = 0
             
             chooseImagePost["image01"] = nil
             chooseImagePost["image02"] = nil
             chooseImagePost["image03"] = nil
             chooseImagePost["image04"] = nil
             
             
         }
         
         if collect.count == 1 {
             stackPostImageConstants.constant = 225
            
             
             chooseImagePost["image01"] = collect.first
             chooseImagePost["image02"] = nil
             chooseImagePost["image03"] = nil
             chooseImagePost["image04"] = nil
         
         }
         
         if collect.count == 2 {
             stackPostImageConstants.constant = 225
          
             
             chooseImagePost["image01"] = collect.first
             chooseImagePost["image02"] = collect.last
             chooseImagePost["image03"] = nil
             chooseImagePost["image04"] = nil
            
             
         }
         if collect.count == 3 {
             stackPostImageConstants.constant = 225
         
             
             chooseImagePost["image01"] = collect.first
             chooseImagePost["image02"] = collect[1]
             chooseImagePost["image03"] = collect.last
             chooseImagePost["image04"] = nil
            
         }
         if collect.count == 4 {
             stackPostImageConstants.constant = 225
         
             
             chooseImagePost["image01"] = collect.first
             chooseImagePost["image02"] = collect[1]
             chooseImagePost["image03"] = collect[2]
             chooseImagePost["image04"] = collect.last
             
         }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.updateImagePost()
            self.updateVideoDeration()
            self.scrollView.scrollToBottom(animated: true)
           
            
        })


         
     }
    
    
    private func updateImagePost() {
        if let item01 = chooseImagePost["image01"] as? AssetItem {
            firstPostImage.image = item01.image
            containerPostImage01.isHidden = false
            stackFirst.isHidden = false
            
            
        }else {
            containerPostImage01.isHidden = true
            
        }
        
        if let item02 = chooseImagePost["image02"] as? AssetItem {
            secondImage.image = item02.image
            containerPostImage02.isHidden = false
            stackFirst.isHidden = false
        }else {
            containerPostImage02.isHidden = true
            
        }
        if let item03 = chooseImagePost["image03"] as? AssetItem {
            thirstImage.image = item03.image
            containerPostImage03.isHidden = false
            stackSecond.isHidden = false
        }else {
            containerPostImage03.isHidden = true
           
        }
       if let item04 = chooseImagePost["image04"] as? AssetItem {
           fouthImage.image = item04.image
           containerPostImage04.isHidden = false
           stackSecond.isHidden = false
       }else {
           containerPostImage04.isHidden = true
           
       }
        
        if stackFirst.isHidden == false && stackSecond.isHidden == false {
            stackFirst.axis = .vertical
            stackSecond.axis = .vertical
        }
        
        
        
    }
    
    private func updateVideoDeration() {
        if let item01 = chooseImagePost["image01"] as? AssetItem {
            if item01.assetType == .video {
                let duration = String.duration(from: item01.asset!.duration)
                firstPostVideoDuration.text = duration
                firstPostVideoDuration.isHidden = false
            }else if item01.assetType == .photo {
                firstPostVideoDuration.isHidden = true
            }
        }
        if let item02 = chooseImagePost["image02"] as? AssetItem {
            if item02.assetType == .video {
                let duration = String.duration(from: item02.asset!.duration)
                secondPostVideoDuration.text = duration
                secondPostVideoDuration.isHidden = false
            }else if item02.assetType == .photo {
                secondPostVideoDuration.isHidden = true
            }
        }
        if let item03 = chooseImagePost["image03"] as? AssetItem {
            if item03.assetType == .video {
                let duration = String.duration(from: item03.asset!.duration)
                thistPostVideoDuration.text = duration
                thistPostVideoDuration.isHidden = false
            }else if item03.assetType == .photo {
                thistPostVideoDuration.isHidden = true
            }
        }
        if let item04 = chooseImagePost["image04"] as? AssetItem {
            if item04.assetType == .video {
                let duration = String.duration(from: item04.asset!.duration)
                fouthPostVideoDuration.text = duration
                fouthPostVideoDuration.isHidden = false
            }else if item04.assetType == .photo {
                fouthPostVideoDuration.isHidden = true
            }
        }
        
        
        
    }
    
    
}






extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
