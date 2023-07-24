//
//  HomeViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 22/07/2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import JGProgressHUD

class HomeViewController: UIViewController {
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    @IBAction func loginVC(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true)
    }
    

    @IBAction func logoutAction(_ sender: Any) {
        signOutAllUser()
    }
    
    private func signOutAllUser() {
     
        do{
            UserDefaults.standard.set("", forKey: "userInfo")
            try FirebaseAuth.Auth.auth().signOut()
            FBSDKLoginKit.LoginManager().logOut()
            GIDSignIn.sharedInstance.signOut()
            print("Signout")
            let userInfo = UserDefaults.standard.value(forKey: "userInfo") as? String ?? ""
            
            print("userInfo \(userInfo)")
        }catch {
            print("Failed to log out")
        }
    }
    
}
