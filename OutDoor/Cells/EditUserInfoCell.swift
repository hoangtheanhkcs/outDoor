//
//  EditUserInfoCell.swift
//  OutDoor01
//
//  Created by hoang the anh on 12/07/2023.
//

import UIKit

class EditUserInfoCell: UITableViewCell {
    
    @IBOutlet weak var editLable: UILabel!
    
    @IBOutlet weak var infoLable: UILabel!
    
    @IBOutlet weak var trailingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
