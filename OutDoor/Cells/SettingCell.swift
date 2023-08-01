//
//  SettingCell.swift
//  OutDoor01
//
//  Created by hoang the anh on 11/07/2023.
//

import UIKit
import DPLocalization


protocol SettingCellDelegate: class {
    func switchButtonChangeValue(isOn: Bool)
}

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var settingLable: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    

    @IBOutlet weak var secondButton: UIButton!
    
    
    @IBOutlet weak var switchButton: UISwitch!
    
    
    @IBOutlet weak var settingImageView: UIImageView!
    
    weak var delegate: SettingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let language = UserDefaults.standard.value(forKey: "language") as? String
        if language == "vi" {
            
            firstButtonAction(1)
        }else if language == "en"{
            
            secondButton(1)
        }
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
    @IBAction func firstButtonAction(_ sender: Any) {
        firstButton.setImage(UIImage(named: "ic_disc_red"), for: .normal)
        secondButton.setImage(UIImage(named: "ic_circle_gray"), for: .normal)
        dp_set_current_language("vi")
        UserDefaults.standard.set("vi", forKey: "language")
    }
    
  
    @IBAction func secondButton(_ sender: Any) {
        secondButton.setImage(UIImage(named: "ic_disc_red"), for: .normal)
        firstButton.setImage(UIImage(named: "ic_circle_gray"), for: .normal)
        
        dp_set_current_language("en")
        UserDefaults.standard.set("en", forKey: "language")
    }
    
    @IBAction func switchButtonAC(_ sender: UISwitch) {
        if sender.isOn {
            delegate?.switchButtonChangeValue(isOn: true)
            
        }else {
            delegate?.switchButtonChangeValue(isOn: false)
        }
    }
    
}
