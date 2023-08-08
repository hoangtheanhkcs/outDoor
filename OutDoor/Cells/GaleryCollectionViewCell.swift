//
//  GaleryCollectionViewCell.swift
//  OutDoor
//
//  Created by hoang the anh on 03/08/2023.
//

import UIKit

class GaleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var selectImageButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var takeNewPhotoIMV: UIImageView!
    
    @IBOutlet weak var takeNewPhotoLable: UILabel!
    
    @IBOutlet weak var containerButton: UIImageView!
    
    
    var imageSelected: Bool? = false {
        didSet {
            if imageSelected == false {
                selectImageButton.isHidden = true
                imageView.layer.opacity = 1
            }else {
                selectImageButton.isHidden = false
                imageView.layer.opacity = 0.8
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        takeNewPhotoLable.setupAutolocalization(withKey: Constants.Strings.takeNewPhotoLAbleCLVC, keyPath: "text")
        takeNewPhotoLable.font = Constants.Fonts.SFLight13
        takeNewPhotoLable.textColor = Constants.Colors.textColorType1.color
        selectImageButton.backgroundColor = .clear
        selectImageButton.layer.cornerRadius = 6
        containerView.backgroundColor = Constants.Colors.emptyPhoto.color
        takeNewPhotoIMV.image = UIImage(named: Constants.Images.takeNewPhotoCollectCell)
        selectImageButton.setImage(UIImage(named: "Ellipse 28"), for: .normal)
        imageSelected = false
        
    }

    @IBAction func selectImageBTAction(_ sender: Any) {
    }
    
    
    func setupSubviewCell(item: GaleryItem?) {
        
        if item?.image == nil {
            containerButton.isHidden = true
            imageSelected = false
            imageView.isHidden = true
            containerView.isHidden = false
            takeNewPhotoIMV.isHidden = false
            takeNewPhotoLable.isHidden = false
            imageSelected = false
        }else {
            containerButton.isHidden = false
            imageView.isHidden = false
            imageView.image = item?.image
            imageView.contentMode = .scaleToFill
            containerView.isHidden = true
            takeNewPhotoIMV.isHidden = true
            takeNewPhotoLable.isHidden = true
        }
        
        
    }
    
  
}
