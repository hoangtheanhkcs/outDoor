//
//  PostViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 02/08/2023.
//

import UIKit
import Photos
import TheAnimation

enum TypeOfPost {
    case articlePost, toolsPost
}

protocol PostViewControllerDelegate: class {
    func selectedImage(index: Int)
}

class PostViewController: UIViewController, GaleryViewControllerDelegate {
    
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
                uploadedPhotoImv.image = imageUpload
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
    
    var photoPostHidden:Bool = true
    
    var textviewExpand:CGFloat = 0
    
    
    @IBOutlet weak var stackFirstWidth: NSLayoutConstraint!
    
    @IBOutlet weak var stackPostImageConstants: NSLayoutConstraint!
    
    @IBOutlet weak var gestureTapView: UIView!
    
    var textViewHeightChange: CGFloat? {
        didSet {
            if textViewHeightChange != oldValue {
                scrollView.scrollToBottom(animated: false)
            }
        }
    }
    
    let bt1 = UIButton()
    let bt2 = UIButton()
    let bt3 = UIButton()
    let bt4 = UIButton()
    
    var chooseImagePost: [GaleryItem] = []
    weak var delegate: PostViewControllerDelegate?
    private var showChoosePostImage:Bool = false
    private var containerChildView: UIView?
    var galeryVC: GaleryViewController?
    
    
    
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
       
       
        stackFirstWidth.constant = (containerView.bounds.width - 10)/2
       
        stackPostImageConstants.constant = 0
        stackFirst.backgroundColor = .clear
        stackSecond.backgroundColor = .clear
        stackPostImage.backgroundColor = .clear
        
        bt1.addTarget(self, action: #selector(didTapCloseImageTextView1), for: .touchUpInside)
        bt2.addTarget(self, action: #selector(didTapCloseImageTextView2), for: .touchUpInside)
        bt3.addTarget(self, action: #selector(didTapCloseImageTextView3), for: .touchUpInside)
        bt4.addTarget(self, action: #selector(didTapCloseImageTextView4), for: .touchUpInside)
        
        containerChildView = UIView()
        view.addSubview(containerChildView!)
        
        
        galeryVC = storyboard?.instantiateViewController(withIdentifier: "GaleryViewController") as? GaleryViewController
        galeryVC?.delegate = self
       
        self.delegate = galeryVC
        addChild(galeryVC!)
        galeryVC?.didMove(toParent: self)
        
        
        
        
        
        
        
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
    
    func setupStackImagePost() {
        var bt : [UIButton] = []
        
        bt = [bt1 , bt2, bt3, bt4]
        bt.forEach({$0.setImage(UIImage(named: Constants.Images.closeUploadedPhoto), for: .normal)})
        bt.forEach({$0.frame.size = CGSize(width: 24, height: 24)})
        bt.forEach({$0.backgroundColor = .clear})
      
        bt1.frame.origin = CGPoint(x: firstPostImage.frame.width - bt1.frame.width, y: 0)
        stackFirst.addSubview(bt1)
        
        bt2.frame.origin = CGPoint(x: secondImage.frame.width - bt2.frame.width, y: 0)
        stackSecond.addSubview(bt2)
        
        bt3.frame.origin = CGPoint(x: thirstImage.frame.width - bt3.frame.width, y: thirstImage.frame.origin.y)
        stackSecond.addSubview(bt3)
        
        bt4.frame.origin = CGPoint(x: fouthImage.frame.width - bt4.frame.width, y: fouthImage.frame.origin.y)
        stackFirst.addSubview(bt4)
        
    }
    
    @objc private func didTapCloseImageTextView1() {
        
        
        delegate?.selectedImage(index: 0)
        
    }
    @objc private func didTapCloseImageTextView2() {
        
        delegate?.selectedImage(index: 1)
    }
    @objc private func didTapCloseImageTextView3() {
       
        delegate?.selectedImage(index: 2)
    }
    @objc private func didTapCloseImageTextView4() {
        
        delegate?.selectedImage(index: 3)
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let vc = storyboard?.instantiateViewController(withIdentifier: "GaleryViewController") as? GaleryViewController
            vc?.selectMode = .one
            vc?.delegate = self
            vc?.heightConstantFNBT = 650
            self.navigationController?.pushViewController(vc!, animated: true)
        }
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
        
        keyboardWillHiddens()
      
        galeryVC?.selectMode = .four
        if showChoosePostImage == false {
            postImageKeyboardBT.setImage(UIImage(named: Constants.Images.imageKeyboard)?.imageWithColor(color: Constants.Colors.buttonBackgroundColor.color), for: .normal)
            containerChildView?.frame = CGRect(x: 0, y: keyboardGruopView.frame.maxY, width: view.bounds.width, height: view.bounds.height - keyboardGruopView.frame.maxY)
            galeryVC?.view.frame = containerChildView!.bounds
            containerChildView?.addSubview(galeryVC!.view)
            containerChildView?.isHidden = false
            showChoosePostImage = true
        }else if showChoosePostImage == true {
            
            print("ewrwrwrw")
            postImageKeyboardBT.setImage(UIImage(named: Constants.Images.imageKeyboard), for: .normal)
            containerChildView?.isHidden = true
            showChoosePostImage = false
            contentArticleTextView.becomeFirstResponder()
            
        }
       
        
        
        
        
        
        
        
        
        
    }
    
  
    @IBAction func postVideoKBAction(_ sender: Any) {
        
    }
    @IBAction func postLocationKBAction(_ sender: Any) {
        
    }
    
    
    func updateCollectedImage(collect: [GaleryItem]) {
        if collect.count != 0 {
            imageUpload = collect.first?.image
            
        }else {
            imageUpload = nil
        }
    }
    func updateCollectedFourImage(collect: [GaleryItem]) {
        
        print("rrwrwrwerwrwrwrwrwrwrw")
        print(collect.count)
    
        guard collect.count <= 4 else {return}
        if collect.count == 0 {
            stackPostImageConstants.constant = 0
            firstPostImage.isHidden = true
            secondImage.isHidden = true
            thirstImage.isHidden = true
            fouthImage.isHidden = true
            stackFirst.isHidden = true
            stackSecond.isHidden = true
            bt1.isHidden = true
            bt2.isHidden = true
            bt3.isHidden = true
            bt4.isHidden = true
          
            
            
        }
        
        if collect.count == 1 {
            stackPostImageConstants.constant = 225
            firstPostImage.isHidden = false
            firstPostImage.image = collect.first?.image
            secondImage.isHidden = true
            thirstImage.isHidden = true
            fouthImage.isHidden = true
            stackFirst.isHidden = false
            stackFirstWidth.constant = containerView.bounds.width
            stackSecond.isHidden = true
            bt1.isHidden = false
            bt2.isHidden = true
            bt3.isHidden = true
            bt4.isHidden = true
        
        }
        
        if collect.count == 2 {
            stackPostImageConstants.constant = 225
            firstPostImage.isHidden = false
            firstPostImage.image = collect.first?.image
            secondImage.isHidden = false
            secondImage.image = collect[1].image
            thirstImage.isHidden = true
            fouthImage.isHidden = true
            stackFirst.isHidden = false
            stackFirstWidth.constant = (containerView.bounds.width - 10)/2
            stackSecond.isHidden = false
            bt1.isHidden = false
            bt2.isHidden = false
            bt3.isHidden = true
            bt4.isHidden = true
           
            
        }
        if collect.count == 3 {
            stackPostImageConstants.constant = 225
            firstPostImage.isHidden = false
            firstPostImage.image = collect.first?.image
            secondImage.isHidden = false
            secondImage.image = collect[1].image
            thirstImage.isHidden = false
            thirstImage.image = collect[2].image
            fouthImage.isHidden = true
            stackFirst.isHidden = false
            stackFirstWidth.constant = containerView.bounds.width - 10 - 150
            stackSecond.isHidden = false
            bt1.isHidden = false
            bt2.isHidden = false
            bt3.isHidden = false
            bt4.isHidden = true
           
        }
        if collect.count == 4 {
            stackPostImageConstants.constant = 225
            firstPostImage.isHidden = false
            firstPostImage.image = collect.first?.image
            secondImage.isHidden = false
            secondImage.image = collect[1].image
            thirstImage.isHidden = false
            thirstImage.image = collect[2].image
            fouthImage.isHidden = false
            fouthImage.image = collect[3].image
            stackFirst.isHidden = false
            stackFirstWidth.constant = (containerView.bounds.width - 10)/2
            stackSecond.isHidden = false
            bt1.isHidden = false
            bt2.isHidden = false
            bt3.isHidden = false
            bt4.isHidden = false
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.scrollView.scrollToBottom(animated: true)
            self.setupStackImagePost()
        })
        
        
        
      
       
        
        
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
