//
//  GaleryItemViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 10/08/2023.
//

import UIKit
import Photos
import AVKit
import MobileCoreServices


protocol GaleryItemViewControllerDelegate:class {
   
    func updateCollectedItem(collect: [AssetItem])
    func updateChooseItemForPost(collect: AssetItem)
}


enum SelectAssetMode {
    case one, four
    
}

class GaleryItemViewController: UIViewController, PostViewControllerDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: GaleryItemViewControllerDelegate?
    
    private var finishButton: UIButton?
    var heightConstantFNBT: CGFloat = 200
    
    private var galeryAsset: [AssetItem] = []
    private var galeryVideo:[AssetItem] = []
    private var selectedAsset: [AssetItem] = []
    private var selectedVideo: [AssetItem] = []
    
    var assetType: AssetType = .photo {
        didSet {
            getAllAsset()
        }
    }
    private var indexDeselect:[Int] = []
    var selectAssetMode: SelectAssetMode = .one
    private var oldSelect:Int?
    var indexSelect:Int = 0
    var indexSelectVideo:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
     
        collectionView .delegate = self
        collectionView.dataSource  = self
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        finishButton = UIButton()
        finishButton?.backgroundColor = Constants.Colors.buttonBackgroundColor.color
        finishButton?.setupAutolocalization(withKey: Constants.Strings.finishBTTitle, keyPath: "autolocalizationTitle")
        finishButton?.changeButtonFont(Constants.Fonts.SFLight16)
        finishButton?.setTitleColor(Constants.Colors.textColorType5.color, for: .normal)
        finishButton?.frame.size = CGSize(width: 80, height: 30)
        finishButton?.frame.origin.x = view.bounds.width - (finishButton?.frame.width)! - 20
        finishButton?.frame.origin.y = heightConstantFNBT
        finishButton?.layer.cornerRadius = 15
        finishButton?.addTarget(self, action: #selector(didTapFinishBT), for: .touchUpInside)
        view.insertSubview(finishButton!, aboveSubview: collectionView!)
    }
    @objc private func didTapFinishBT() {
        
        if selectAssetMode == .one {
            delegate?.updateChooseItemForPost(collect: selectedAsset.first!)
            navigationController?.popViewController(animated: true)
        }else if selectAssetMode == .four {
            
            switch assetType {
            case .photo:
                delegate?.updateCollectedItem(collect: selectedAsset)
            case .video:
                delegate?.updateCollectedItem(collect: selectedVideo)
            }
            
        }
    }
    
    
    
    private func getAllAsset(){
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        
        if assetType == .photo {
            if galeryAsset.count == 0 {
                
                galeryAsset = [AssetItem(imageTakeNewVideo: Constants.Images.takeNewPhotoCollectCell, lableTakeNewVideo: Constants.Strings.takeNewPhotoLAbleCLVC, assetType: .photo)]
                let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                
                fetchResult.enumerateObjects({ (object, count, stop) in
                    
                    let image = self.getImageFromVideo(asset: object, options: requestOptions)
                    let asset = AssetItem(image: image, assetType: .photo)
                    self.galeryAsset.append(asset )
                })
                
            }
        }else if assetType == .video {
            if galeryVideo.count == 0 {
                galeryVideo = [AssetItem(imageTakeNewVideo: Constants.Images.takeNewVideo, lableTakeNewVideo: Constants.Strings.takeNewVideo, assetType: .video)]
                let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions)
                fetchResult.enumerateObjects({ (object, count, stop) in
                    let image = self.getImageFromVideo(asset: object, options: requestOptions)
                    let asset = AssetItem(asset: object, image: image, assetType: .video)
                    self.galeryVideo.append(asset )
                })
            }
        }
        DispatchQueue.main.async {
        
            self.collectionView.reloadData()
        }
       
    }
    
    private func getImageFromVideo(asset: PHAsset, options: PHImageRequestOptions? ) -> UIImage? {
        var image : UIImage?
        PHCachingImageManager.default().requestImage(for: asset,
                                                     targetSize: CGSize(width: 500, height: 500),
                                                     contentMode: .aspectFill,
                                                     options: options) { (photo, _) in
            image = photo
        }
        return image
    }
    
    
    
    func selectedAsset(item: AssetItem) {
        
        switch assetType {
        case .photo:
            if let indexItem = galeryAsset.firstIndex(where: {$0.id == item.id && $0.isAdded == true}) {
                guard let cell = collectionView.cellForItem(at: IndexPath(item: indexItem, section: 0)) as? PhotoLibraryCollectionViewCell  else {return}
                
                cell.selectedAsset = false
                galeryAsset[indexItem].isAdded = false
                selectedAsset = galeryAsset.filter({$0.isAdded == true}).sorted(by: {$0.id < $1.id})
            }
        case .video:
                if let indexItem = galeryVideo.firstIndex(where: {$0.id == item.id && $0.isAdded == true}) {
                    guard let cell = collectionView.cellForItem(at: IndexPath(item: indexItem, section: 0)) as? VideoLibraryCollectionViewCell  else {return}
                    
                    cell.selectedAsset = false
                    galeryVideo[indexItem].isAdded = false
                    
                    
                    selectedVideo = galeryVideo.filter({$0.isAdded == true}).sorted(by: {$0.id < $1.id})
                }
            }
        }
    }

    
    



extension GaleryItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        
        switch assetType {
            
        case .photo:
           return galeryAsset.count
        case .video:
          return  galeryVideo.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch assetType {
            
        case .photo:
            let nib = UINib(nibName: "PhotoLibraryCollectionViewCell", bundle: nil)
            collectionView.register(nib.self, forCellWithReuseIdentifier: "PhotoLibraryCollectionViewCell")
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoLibraryCollectionViewCell", for: indexPath) as? PhotoLibraryCollectionViewCell else {return UICollectionViewCell()}
        
            let asset = galeryAsset[indexPath.item]
            let index = indexPath.item
            print("asset at \(index) is added \(asset.isAdded)")
           
                cell.setupImage(item: asset)
            
            
            return cell
        case .video:
            let nib = UINib(nibName: "VideoLibraryCollectionViewCell", bundle: nil)
            collectionView.register(nib.self, forCellWithReuseIdentifier: "VideoLibraryCollectionViewCell")
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoLibraryCollectionViewCell", for: indexPath) as? VideoLibraryCollectionViewCell else {return UICollectionViewCell()}
           
            let asset = galeryVideo[indexPath.item]
            cell.setupVide0(item: asset)
            return cell
        }
       
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
        switch assetType {
            
        case .photo:
            let cell = collectionView.cellForItem(at: indexPath) as? PhotoLibraryCollectionViewCell
            let index = indexPath.item
            
            if index == 0{
                    didTapTakeAPhoto()
            }
            
            
            if selectAssetMode == .one {
                
                selectedAsset = [galeryAsset[index]]
                cell?.selectedAsset = true
               
                if oldSelect != nil {
                    let oldCell = collectionView.cellForItem(at: IndexPath(item: oldSelect!, section: 0)) as? PhotoLibraryCollectionViewCell
                    oldCell?.selectedAsset = false
                }
                oldSelect = index
            }
            if selectAssetMode == .four {
                
                if index != 0 {
                    if cell?.selectedAsset == false {
                        guard selectedAsset.count < 4 else {return}
                        indexSelect += 1
                        cell?.selectedAsset = true
            
                        galeryAsset[index].isAdded = true
                        galeryAsset[index].indexSelect = indexSelect
                    }else if cell?.selectedAsset == true {
                        cell?.selectedAsset = false
                        galeryAsset[index].isAdded = false
                    }
                }
            
                DispatchQueue.main.async {
                    self.selectedAsset = self.galeryAsset.filter({$0.isAdded == true}).sorted(by: {$0.indexSelect! < $1.indexSelect!})
                }
                
            }
        case .video:
            let cell = collectionView.cellForItem(at: indexPath) as? VideoLibraryCollectionViewCell
            let index = indexPath.item
            
            if index == 0{
                didTapTakeAVideo()
            }
            
            if selectAssetMode == .four {
                
               
                
                if index != 0 {
                    if cell?.selectedAsset == false {
                        guard selectedVideo.count < 4 else {return}
                        indexSelectVideo += 1
                        cell?.selectedAsset = true
            
                        galeryVideo[index].isAdded = true
                        galeryVideo[index].indexSelect = indexSelectVideo
                    }else if cell?.selectedAsset == true {
                        cell?.selectedAsset = false
                        galeryVideo[index].isAdded = false
                    }
                }
            
                DispatchQueue.main.async {
                    self.selectedVideo = self.galeryVideo.filter({$0.isAdded == true}).sorted(by: {$0.indexSelect! < $1.indexSelect!})
                }
                
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 14) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 2
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
    
}


extension GaleryItemViewController:  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private func didTapTakeAPhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    private func  didTapTakeAVideo() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.mediaTypes = [kUTTypeMovie as String]
                imagePicker.videoMaximumDuration = 10 // or whatever you want
                imagePicker.videoQuality = .typeMedium
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true, completion: nil)
            }else {
                print("Rear camera dosenot exist")
            }
        }else {
            print("cannot access camera")
        }
    }
}













enum AssetType {
    case photo, video
}



struct AssetItem {
    var asset:PHAsset?
    var image: UIImage?
    var imageTakeNewVideo:String?
    var lableTakeNewVideo:String?
    var isAdded:Bool? = false
    var id : String = UUID().uuidString
    var indexSelect:Int?
    var assetType: AssetType?
}
