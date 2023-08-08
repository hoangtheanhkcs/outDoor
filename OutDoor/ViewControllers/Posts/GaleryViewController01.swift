//
//  GaleryViewController01.swift
//  OutDoor
//
//  Created by hoang the anh on 05/08/2023.
//

import UIKit
import Photos


enum SelectMode {
    case one, four
    
}

protocol GaleryViewControllerDelegate:class {
    func updateCollectedImage(collect: [GaleryItem])
    func updateCollectedFourImage(collect: [GaleryItem])
}


class GaleryViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PostViewControllerDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var galeryImages:[GaleryItem] = [GaleryItem( imageTakeNewPhoto: Constants.Images.takeNewPhotoCollectCell, lableTakeNewPhoto: Constants.Strings.takeNewPhotoLAbleCLVC)]
    
    var selectedImages: [GaleryItem] = []
    
    weak var delegate: GaleryViewControllerDelegate?
    var indexSelect:Int = 0
    var indexDeselect:[Int] = []
    var finishButton: UIButton?
    var heightConstantFNBT: CGFloat = 200
   
    var selectMode: SelectMode = .one
    private var oldSelect:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        let nib = UINib(nibName: "GaleryCollectionViewCell", bundle: nil)
        collectionView?.register(nib.self, forCellWithReuseIdentifier: "GaleryCollectionViewCell")
        
        
        grabPhotos {[weak self] images in
            guard let self = self else {return}
            let photo = images.compactMap({GaleryItem(image: $0)}) as? [GaleryItem] ?? []
            galeryImages.append(contentsOf: photo)
            collectionView?.reloadData()
        }
        
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
    func grabPhotos(completion: @escaping ([UIImage])-> Void){
        var imageArray:[UIImage] = []
        let imgManager=PHImageManager.default()
        let requestOptions=PHImageRequestOptions()
        requestOptions.isSynchronous=true
        requestOptions.deliveryMode = .highQualityFormat
        let fetchOptions=PHFetchOptions()
        fetchOptions.sortDescriptors=[NSSortDescriptor(key:"creationDate", ascending: false)]
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if fetchResult.count > 0 {
            for i in 0..<fetchResult.count{
                imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width:1000, height: 1000),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
                    imageArray.append(image!)
                })
            }
            DispatchQueue.main.async {
                completion(imageArray)
            }
        } else {
            print("You got no photos.")
        }
    }
    
    
    private func didTapTakeAPhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    
    
    @objc private func didTapFinishBT() {
        
        if selectMode == .one {
            delegate?.updateCollectedImage(collect: selectedImages)
            navigationController?.popViewController(animated: true)
        }
        if selectMode == .four {
            
            delegate?.updateCollectedFourImage(collect: selectedImages)
        }
    }
    
    func selectedImage(index: Int) {
        
        let item = selectedImages[index]
        if let indexItem = galeryImages.firstIndex(where: {$0.id == item.id && $0.isAdded == true}) {
            guard let cell = collectionView.cellForItem(at: IndexPath(item: indexItem, section: 0)) as? GaleryCollectionViewCell  else {return}
            
                cell.imageSelected = false
                galeryImages[indexItem].isAdded = false
                indexDeselect.append(galeryImages[indexItem].id)
               
            selectedImages = galeryImages.filter({$0.isAdded == true}).sorted(by: {$0.id < $1.id})
            
            DispatchQueue.main.async {
                self.delegate?.updateCollectedFourImage(collect: self.selectedImages)
            }
            
            
            
        }
    }
    
}



extension GaleryViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        galeryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GaleryCollectionViewCell", for: indexPath) as? GaleryCollectionViewCell else {return UICollectionViewCell()}
        cell.setupSubviewCell(item: galeryImages[indexPath.item])
                
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? GaleryCollectionViewCell
        let index = indexPath.item
        
        if index == 0{
            didTapTakeAPhoto()
        }
        
     
        if selectMode == .one {
            selectedImages = [galeryImages[index]]
            cell?.imageSelected = true
           
            if oldSelect != nil {
                let oldCell = collectionView.cellForItem(at: IndexPath(item: oldSelect!, section: 0)) as? GaleryCollectionViewCell
                oldCell?.imageSelected = false
            }
            oldSelect = index
        }
        if selectMode == .four {
            
            if index != 0 {
                
                if selectedImages.count == 0 {
                    indexDeselect = []
                }
                
                if cell?.imageSelected == false {
                    guard selectedImages.count < 4 else {return}
                    
                    
                    if indexDeselect.count != 0 {
                        let indexEdit = indexDeselect.first
                        galeryImages[index].isAdded = true
                        cell?.imageSelected = true
                        galeryImages[index].id = indexEdit!
                        indexDeselect.remove(at: 0)
                        print(indexEdit)
                    }else {
                        indexSelect += 1
                        galeryImages[index].isAdded = true
                        cell?.imageSelected = true
                        galeryImages[index].id = indexSelect
                    }
                    
                  
                }else if cell?.imageSelected == true {
                    cell?.imageSelected = false
                    galeryImages[index].isAdded = false
                    indexDeselect.append(galeryImages[index].id)
                   
                }
            }
            
          
            
            selectedImages = galeryImages.filter({$0.isAdded == true}).sorted(by: {$0.id < $1.id})
            
        
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





struct GaleryItem {
    var image:UIImage?
    var imageTakeNewPhoto:String?
    var lableTakeNewPhoto:String?
    var isAdded:Bool? = false
    var id:Int = 0
}
