//
//  LoginViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logginLogoImageView: UIImageView!
    
    @IBOutlet weak var logginImageView: UIImageView!
    
    @IBOutlet weak var helloLable: UILabel!
    
    @IBOutlet weak var welcomeTextView: UITextView!
    
    @IBOutlet weak var logginFacebookButton: UIButton!
    
    @IBOutlet weak var logginGoogleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubview()
        
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
        
        logginFacebookButton.setTitle(Constants.Strings.logginFacebook, for: .normal)
        logginFacebookButton.setTitleColor(Constants.Colors.textColorType5.color, for: .normal)
        logginFacebookButton.titleLabel?.font = Constants.Fonts.SFReguler16
        logginFacebookButton.setTitleColor(Constants.Colors.textColorType5.color, for: .normal)
        logginFacebookButton.backgroundColor = Constants.Colors.logginFacebook.color
        logginFacebookButton.layer.cornerRadius = 26
        logginFacebookButton.setImage(UIImage(named: Constants.Images.logginFacebookButton), for: .normal)
        
        logginGoogleButton.setTitle(Constants.Strings.logginGoogle, for: .normal)
        logginGoogleButton.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
        logginGoogleButton.titleLabel?.font = Constants.Fonts.SFReguler16
        logginGoogleButton.layer.cornerRadius  = 26
        logginGoogleButton.layer.borderWidth = 1
        logginGoogleButton.layer.borderColor = Constants.Colors.logginGoogleBorder.color.cgColor
        logginGoogleButton.setImage(UIImage(named: Constants.Images.logginGoogleButton), for: .normal)
    }
    
    
    

    @IBAction func logginFacebookAction(_ sender: Any) {
    }
    

    @IBAction func logginGoogleButton(_ sender: Any) {
    }
    
    
}
