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
    

    @IBAction func logoutAction(_ sender: Any) {
        signOutAllUser()
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
