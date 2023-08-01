//
//  Onboard1.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import UIKit

class Onboard1: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lable: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    private var languague:String? {
        return  UserDefaults.standard.value(forKey: "language") as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    

    func setupSubviews() {
        imageView.image = UIImage(named: Constants.Images.onboard1Image)
        lable.setupAutolocalization(withKey: Constants.Strings.onboard1Lable, keyPath: "text")
        lable.font = Constants.Fonts.SFBold34
        textView.settingTextView(text: Constants.Strings.onboard1TextView, textColor: Constants.Colors.textColorType6.color, font: Constants.Fonts.SFReguler17, lineSpacing: 8, str: languague)
    }

}
