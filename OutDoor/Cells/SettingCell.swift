//
//  SettingCell.swift
//  OutDoor01
//
//  Created by hoang the anh on 11/07/2023.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var settingLable: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    

    @IBOutlet weak var secondButton: UIButton!
    
    
    @IBOutlet weak var switchButton: UISwitch!
    
    
    @IBOutlet weak var settingImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupSubviews() {
       
            firstButton.setImage(UIImage(named: "ic_disc_red"), for: .normal)
            secondButton.setImage(UIImage(named: "ic_circle_gray"), for: .normal)
       
    }
    
    @IBAction func firstButtonAction(_ sender: Any) {
        firstButton.setImage(UIImage(named: "ic_disc_red"), for: .normal)
        secondButton.setImage(UIImage(named: "ic_circle_gray"), for: .normal)
        print("1111111111")
    }
    
  
    @IBAction func secondButton(_ sender: Any) {
        secondButton.setImage(UIImage(named: "ic_disc_red"), for: .normal)
        firstButton.setImage(UIImage(named: "ic_circle_gray"), for: .normal)
        
        print("22222222")
    }
    
    
    
}
