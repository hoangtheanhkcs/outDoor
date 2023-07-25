//
//  LoginViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import JGProgressHUD
import SnapKit


protocol LoginViewControllerDelegate: class {
    func presentHomeVC()
}
 
class LoginViewController: UIViewController {
   
    
    
    @IBOutlet weak var logginLogoImageView: UIImageView!
    
    @IBOutlet weak var logginImageView: UIImageView!
    
    @IBOutlet weak var helloLable: UILabel!
    
    @IBOutlet weak var welcomeTextView: UITextView!
    
    @IBOutlet weak var logginFacebookButton: UIButton!
    
    @IBOutlet weak var logginGoogleButton: UIButton!
    
    weak var delegate: LoginViewControllerDelegate?
    
    
    
    private let fbLoginButton : FBLoginButton = {
        let fbButton = FBLoginButton()
        fbButton.permissions = ["public_profile"]  //scope email đã ko còn được hỗ trợ cho developers
        let title = NSAttributedString(string: Constants.Strings.logginFacebook)
        fbButton.setAttributedTitle(title, for: .normal)
        fbButton.titleLabel?.font = Constants.Fonts.SFReguler17
        fbButton.titleLabel?.textColor = Constants.Colors.textColorType5.color
        fbButton.layer.masksToBounds = true
        fbButton.layer.cornerRadius = 26
        fbButton.setImage(UIImage(), for: .normal)
        return fbButton
    }()
    
  
    private let spinner = JGProgressHUD(style: .dark)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubview()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
//        signOutAllUser()
    }
    func setupSubview() {
        logginLogoImageView.image = UIImage(named: Constants.Images.loginOutdoorLogo)
        logginLogoImageView.contentMode = .scaleToFill
        logginImageView.image = UIImage(named: Constants.Images.loginImage)
        logginImageView.contentMode = .scaleToFill
        helloLable.text = Constants.Strings.loginHello
        helloLable.font = Constants.Fonts.SFBold34
        helloLable.textColor = Constants.Colors.textColorType1.color
        
        welcomeTextView.settingTextView(text: Constants.Strings.loginWelcome, textColor: Constants.Colors.textColorType6.color, font: Constants.Fonts.SFLight17, lineSpacing: 8)
        
        
        logginFacebookButton.isHidden = true
        
        fbLoginButton.frame.size = CGSize(width: 360, height: 52)
        fbLoginButton.frame.origin.x = logginFacebookButton.frame.origin.x
        fbLoginButton.frame.origin.y = logginFacebookButton.frame.origin.y
        fbLoginButton.frame.size = logginGoogleButton.frame.size
        fbLoginButton.delegate = self
        
        view.addSubview(fbLoginButton)
        
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 22, height: 22)
        imageView.image = UIImage(named: Constants.Images.logginFacebookButton)
        imageView.frame.origin.x = fbLoginButton.frame.origin.x + 60
        imageView.frame.origin.y = fbLoginButton.frame.origin.y + 15
        view.addSubview(imageView)
        
        let insertView = UIView()
        insertView.frame.size = CGSize(width: 52, height: 52)
        insertView.layer.cornerRadius = 26
        insertView.backgroundColor = Constants.Colors.logginFacebook.color
        insertView.frame.origin.x = fbLoginButton.frame.origin.x
        insertView.frame.origin.y = fbLoginButton.frame.origin.y
        view.addSubview(insertView)
        
        logginGoogleButton.setTitle(Constants.Strings.logginGoogle, for: .normal)
        logginGoogleButton.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
        logginGoogleButton.titleLabel?.font = Constants.Fonts.SFReguler16
        logginGoogleButton.layer.cornerRadius  = 26
        logginGoogleButton.layer.borderWidth = 1
        logginGoogleButton.layer.borderColor = Constants.Colors.logginGoogleBorder.color.cgColor
        logginGoogleButton.setImage(UIImage(named: Constants.Images.logginGoogleButton), for: .normal)
    }
    
    
    @IBAction func logginGoogleButton(_ sender: Any) {
        spinner.show(in: view)
        if GIDSignIn.sharedInstance.currentUser  == nil {
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] (result, error) in
                guard let strongSelf = self else {return}
                
                guard error == nil else {
                    if let error = error {
                        print("Failed to sign in google server \(error) ")
                    }
                    return
                }
                
                guard let user = result?.user,
                    let idToken = user.idToken?.tokenString
                  else {
                    print("User information authentication failed")
                    return
                  }
                
                if let email = user.profile?.email, let firstName = user.profile?.givenName, let lastName = user.profile?.familyName {
                    let userInfo = "\(firstName)\(lastName)\(email.replacingOccurrences(of: ".", with: "-"))"
                    UserDefaults.standard.set(userInfo, forKey: "userInfo")
                    
                    DatabaseManager.shared.checkUserExists(with: userInfo) { exist in
                        if !exist {
                            let user = OutDoorUser(firstName: firstName, lastName: lastName, emailAddress: email)
                            DatabaseManager.shared.addNewUser(user: user) { success in
                                if success {
                                    print("34343434343434343434343")
                                }
                            }
                        }
                    }
                    
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                 accessToken: user.accessToken.tokenString)
                
                FirebaseAuth.Auth.auth().signIn(with: credential) {(authResult, error) in
                    guard let result = authResult, error == nil else {
                        print("Failed to log in user with credential :\(credential)")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        strongSelf.spinner.dismiss()
                    }
                    let user = result.user
                    print("Loggeg In User: \(user.uid)")
                    
                   
                    strongSelf.dismiss(animated: true)
                    strongSelf.delegate?.presentHomeVC()
                }
               
                
        }
    }
    }
    
    private func signOutAllUser() {
        FBSDKLoginKit.LoginManager().logOut()
        GIDSignIn.sharedInstance.signOut()
        do{
            try FirebaseAuth.Auth.auth().signOut()
        }catch {
            print("Failed to log out")
        }
    }
    
   
    
}


extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        
        guard let token = result?.token?.tokenString else {
            print("User failed to log in with Facebook")
            return
        }
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields" : "email, first_name, last_name, picture.type(large)"], tokenString: token, version: nil, httpMethod: .get)
        
        
        facebookRequest.start { _, result, error in
            guard let result = result as? [String:Any], error == nil else {
                
                print("Failed to make facebook graph request")
                return
            }
            print("result is \(result)")
            guard let firstName = result["first_name"] as? String, let lastName = result["last_name"] as? String, let id = result["id"] as? String, let picture = result["picture"] as? [String:Any], let data = picture["data"] as? [String:Any], let pictureUrl = data["url"] as? String else {
                print("Failed to get email end name from facebook result")
                return
            }
            
            let userInfo = firstName + lastName + id
            UserDefaults.standard.set(userInfo, forKey: "userInfo")
            
            DatabaseManager.shared.checkUserExists(with: userInfo) { exist in
                if !exist {
                    let user = OutDoorUser(firstName: firstName, lastName: lastName, emailAddress: id)
                    DatabaseManager.shared.addNewUser(user: user) { success in
                        if success {
                            print("34343434343434343434343")
                        }
                    }
                }
            }
            
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            
            
            FirebaseAuth.Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                guard let strongSelf = self else {return}
                guard authResult != nil, error == nil else {
                    if let error = error {
                        print("Facebook credential login failed, MFA may be need - \(error)")
                    }
                    return
                }
                
                
                print("Successfully logged user in \(authResult?.user.uid ?? "")")
                
                strongSelf.dismiss(animated: true)
                strongSelf.delegate?.presentHomeVC()
            }
        }
    }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            
            FBSDKLoginKit.LoginManager().logOut()
            do{
                try FirebaseAuth.Auth.auth().signOut()
            }catch {
                
            }
        }
    }

