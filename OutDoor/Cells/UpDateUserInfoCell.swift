//
//  UpDateUserInfoCell.swift
//  OutDoor01
//
//  Created by hoang the anh on 12/07/2023.
//

import UIKit

class UpDateUserInfoCell: UITableViewCell {
    
    
    @IBOutlet weak var updateLable: UILabel!
    
    @IBOutlet weak var userInfoLable: UILabel!
    
    @IBOutlet weak var trailingButton: UIButton!
    
    @IBOutlet weak var genderButtonForMan: UIButton!
    
    @IBOutlet weak var genderButtonForWomen: UIButton!
    

    @IBOutlet weak var xImage: UIImageView!
    
    
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: UpdateUserInfoViewControllerDeleage?
    
    var userInfo: [AnyHashable : Any]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.isHidden = true
        updateLable.font = Constants.Fonts.SFReguler17
        updateLable.textColor = Constants.Colors.textColorType1.color
        
        userInfoLable.font = Constants.Fonts.SFReguler17
        userInfoLable.textColor = Constants.Colors.textColorType6.color
        
        textField.font = Constants.Fonts.SFReguler17
        textField.textColor = Constants.Colors.textColorType1.color
        textField.borderStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func genderManButton(_ sender: Any) {
        genderButtonForWomen.setImage(UIImage(named: "Group 126"), for: .normal)
        genderButtonForMan.setImage(UIImage(named: "Group 125"), for: .normal)
        delegate?.receiveTraillingButtonTap(self)
        userInfo = ["userInfoLable": (genderButtonForMan.titleLabel?.text?.replacingOccurrences(of: " ", with: ""))! as String]
        NotificationCenter.default.post(name: NSNotification.Name("cellValue"), object: nil, userInfo: userInfo)
        
        
    }
    
    @IBAction func genderWomenButton(_ sender: Any) {
        
        genderButtonForMan.setImage(UIImage(named: "Group 126"), for: .normal)
        genderButtonForWomen.setImage(UIImage(named: "Group 125"), for: .normal)
        delegate?.receiveTraillingButtonTap(self)
        userInfo = ["userInfoLable": (genderButtonForWomen.titleLabel?.text?.replacingOccurrences(of: " ", with: ""))! as String]
        NotificationCenter.default.post(name: NSNotification.Name("cellValue"), object: nil, userInfo: userInfo)
        
    }
    
    @IBAction func trailingBTAction(_ sender: Any) {
        
        userInfoLable.text = textField.text
        
        userInfo = ["userInfoLable": userInfoLable.text! as String]
        delegate?.receiveTraillingButtonTap(self)
        if !self.isEditing {
            self.isEditing = true
            textField.isHidden = false
            textField.becomeFirstResponder()
            userInfoLable.isHidden = true
            trailingButton.setImage(UIImage(named: "icons8-check-50"), for: .normal)
        }else {
            self.isEditing = false
            textField.isHidden = true
            userInfoLable.isHidden = false
            trailingButton.setImage(UIImage(named: "Group 77"), for: .normal)
            NotificationCenter.default.post(name: NSNotification.Name("cellValue"), object: nil, userInfo: userInfo)
            
        }
    }
    
}
