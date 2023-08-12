//
//  PhotoLibraryCollectionViewCell.swift
//  OutDoor
//
//  Created by hoang the anh on 12/08/2023.
//

import UIKit
import AVKit
import Photos

class PhotoLibraryCollectionViewCell: UICollectionViewCell {
    var containerVideoView = UIView()
    var videoImage = UIImageView()
    var cilceImage = UIImageView()
    var selectVideoButton = UIButton()
    var durationLable = UILabel()
    var recoringImageView = UIImageView()
    var recordingLable = UILabel()
    
    var selectedAsset:Bool = false {
        
        didSet {
            if selectedAsset == false {
                selectVideoButton.isHidden = true
                videoImage.layer.opacity = 1
                
            }else {
                selectVideoButton.isHidden = false
                videoImage.layer.opacity = 0.8
            }
        }
    }
    
    var imagePhoto: UIImage? {
        didSet {
            if imagePhoto != nil {
                recoringImageView.isHidden = true
                recordingLable.isHidden = true
                containerVideoView.isHidden = false
                durationLable.isHidden = true
            }else if imagePhoto == nil {
                recoringImageView.isHidden = false
                recordingLable.isHidden = false
                containerVideoView.isHidden = true
                durationLable.isHidden = true
            }
        }
    }
    
    var imageVideo: PHAsset? {
        didSet {
            if imageVideo != nil {
                recoringImageView.isHidden = true
                recordingLable.isHidden = true
                containerVideoView.isHidden = false
                durationLable.isHidden = false
            }else if imageVideo == nil {
                recoringImageView.isHidden = false
                recordingLable.isHidden = false
                containerVideoView.isHidden = true
                durationLable.isHidden = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedAsset = false
        DispatchQueue.main.async {
            self.setupSubview()
        }
    }
    
    private func setupSubview() {
        
        containerVideoView.frame = contentView.bounds
        containerVideoView.backgroundColor = .clear
        contentView.addSubview(containerVideoView)
        videoImage.frame = containerVideoView.bounds
        containerVideoView.addSubview(videoImage)
        cilceImage.frame.size = CGSize(width: 27, height: 27)
        cilceImage.image = UIImage(named: Constants.Images.cicleButton)
        cilceImage.frame.origin = CGPoint(x: containerVideoView.bounds.width - cilceImage.bounds.width, y: 0)
        containerVideoView.insertSubview(cilceImage, aboveSubview: videoImage)
        selectVideoButton.setImage(UIImage(named: Constants.Images.selectButton), for: .normal)
        selectVideoButton.frame.size = CGSize(width: 18, height: 18)
        selectVideoButton.center.x = cilceImage.center.x
        selectVideoButton.center.y = cilceImage.center.y - 0.8
        
        containerVideoView.insertSubview(selectVideoButton, aboveSubview: cilceImage)
        
        durationLable.frame.size = CGSize(width: 36, height: 13)
        durationLable.frame.origin = CGPoint(x: containerVideoView.bounds.width - durationLable.bounds.width - 5, y: containerVideoView.bounds.height - durationLable.bounds.height - 10)
        durationLable.backgroundColor = .black
        durationLable.layer.cornerRadius = 6.5
        durationLable.layer.masksToBounds = true
        durationLable.textColor = .white
        
        durationLable.textAlignment = .center
        durationLable.font = Constants.Fonts.SFReguler11
        containerVideoView.insertSubview(durationLable, aboveSubview: videoImage)
        
        
        recoringImageView.frame.size = CGSize(width: 24, height: 24)
        recoringImageView.center.x = contentView.center.x
        recoringImageView.center.y = contentView.center.y - 10
        contentView.insertSubview(recoringImageView, belowSubview: containerVideoView)
        recordingLable.frame.size = CGSize(width: contentView.bounds.width, height: 18)
        recordingLable.center.y = contentView.center.y + 15
        
        recordingLable.font = Constants.Fonts.SFLight13
        recordingLable.textColor = Constants.Colors.textColorType1.color
        recordingLable.textAlignment = .center
        contentView.insertSubview(recordingLable, belowSubview: containerVideoView)
        
    }
    
    
    func setupImage(item: AssetItem) {
        guard item.assetType == .photo else {return}
        if item.isAdded == true {
            selectedAsset = true
        }else {
            selectedAsset = false
        }
        
        
        if item.image == nil {
            imagePhoto = nil
            recoringImageView.image = UIImage(named: Constants.Images.takeNewPhotoCollectCell)
            recordingLable.setupAutolocalization(withKey: Constants.Strings.takeNewPhotoLAbleCLVC, keyPath: "text")
        }else if item.image != nil {
            imagePhoto = item.image
            videoImage.image = item.image
            }
        }
    }


