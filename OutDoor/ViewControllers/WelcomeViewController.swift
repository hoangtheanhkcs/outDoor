//
//  WelcomeViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 21/07/2023.
//

import UIKit


class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    @IBOutlet weak var yelloCartImageView: UIImageView!
    
    
    @IBOutlet weak var redCartImageView: UIImageView!
    
    @IBOutlet weak var greenCartImageView: UIImageView!
    
    @IBOutlet weak var yellowCartLable: UILabel!
    
    @IBOutlet weak var yelloCartContentLable: UILabel!
    
    @IBOutlet weak var yellowCartButton: UIButton!
    
    @IBOutlet weak var redCartLable: UILabel!
    
    @IBOutlet weak var redCartContent: UILabel!
    
    @IBOutlet weak var redCartButton: UIButton!
    
    
    @IBOutlet weak var greenCartLable: UILabel!
    
    @IBOutlet weak var greenCartContent: UILabel!
    
    
    @IBOutlet weak var greenCartButton: UIButton!
    
    
    private var languague:String? {
        return  UserDefaults.standard.value(forKey: "language") as? String
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupSubviews()
    }
    
    func setupSubviews() {
        logoImageView.image = UIImage(named: Constants.Images.welcomeVCLogo)
        yelloCartImageView.image = UIImage(named: Constants.Images.welcomeVCYellowCart)
        redCartImageView.image = UIImage(named: Constants.Images.welcomeVCRedCart)
        greenCartImageView.image = UIImage(named: Constants.Images.welcomeVCGreenCart)
        
//        yellowCartLable.text = Constants.Strings.welcomeVCYellowCartLable
        yellowCartLable.setupAutolocalization(withKey: Constants.Strings.welcomeVCYellowCartLable, keyPath: "text")
        yellowCartLable.font = Constants.Fonts.SFBold24
        yellowCartLable.textColor = Constants.Colors.textColorType5.color
        
        yelloCartContentLable.settingLableText(text: Constants.Strings.welcomeVCYellowCartText, textColor: Constants.Colors.textColorType5.color, font: Constants.Fonts.SFReguler15, lineSpacing: 2, str: languague)
        
//        yellowCartButton.setTitle(Constants.Strings.welcomeVCButton, for: .normal)
        yellowCartButton.setupAutolocalization(withKey: Constants.Strings.welcomeVCButton, keyPath: "autolocalizationTitle")
        yellowCartButton.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
        yellowCartButton.changeButtonFont(Constants.Fonts.SFLight16)
        yellowCartButton.backgroundColor = Constants.Colors.textColorType5.color
        yellowCartButton.layer.cornerRadius = 15
        yellowCartButton.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        
        
//        redCartLable.text = Constants.Strings.welcomeVCRedCartLable
        redCartLable.setupAutolocalization(withKey: Constants.Strings.welcomeVCRedCartLable, keyPath: "text")
        redCartLable.textColor = Constants.Colors.textColorType5.color
        redCartLable.font = Constants.Fonts.SFBold20
        
        
        redCartContent.settingLableText(text: Constants.Strings.welcomeVCRedCartText, textColor: Constants.Colors.textColorType5.color, font: Constants.Fonts.SFReguler15, lineSpacing: 2, str: languague)
        
        redCartButton.setTitle(Constants.Strings.welcomeVCButton, for: .normal)
        redCartButton.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
        redCartButton.changeButtonFont(Constants.Fonts.SFLight13)
        redCartButton.backgroundColor = Constants.Colors.textColorType5.color
        redCartButton.layer.cornerRadius = 12.5
        redCartButton.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        
        greenCartLable.setupAutolocalization(withKey: Constants.Strings.welcomeVCGreenCartLable, keyPath: "text")
        greenCartLable.textColor = Constants.Colors.textColorType5.color
        greenCartLable.font = Constants.Fonts.SFBold20
        
        
        greenCartContent.settingLableText(text: Constants.Strings.welcomeVCGreenCartText, textColor: Constants.Colors.textColorType5.color, font: Constants.Fonts.SFReguler15, lineSpacing: 2, str: languague)
        
        greenCartButton.setTitle(Constants.Strings.welcomeVCButton, for: .normal)
        greenCartButton.setTitleColor(Constants.Colors.textColorType1.color, for: .normal)
        greenCartButton.changeButtonFont(Constants.Fonts.SFLight13)
        greenCartButton.backgroundColor = Constants.Colors.textColorType5.color
        greenCartButton.layer.cornerRadius = 12.5
        greenCartButton.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        
    }
   
    @objc private func didTapCartButton() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OnboardViewController") as? OnboardViewController
        
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true)
    }

}
