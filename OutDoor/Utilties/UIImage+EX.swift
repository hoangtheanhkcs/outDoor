//
//  UIImage+EX.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import Foundation
import UIKit



extension UIImage {
    func imageWithColor(color:UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext() ?? image
        UIGraphicsEndImageContext()
        return image
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func load(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


    extension UIImageView {
        func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
            containerView.clipsToBounds = false
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOpacity = 1
            containerView.layer.shadowOffset = CGSize.zero
            containerView.layer.shadowRadius = 10
            containerView.layer.cornerRadius = cornerRadious
            containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
            self.clipsToBounds = true
            self.layer.cornerRadius = cornerRadious
        }
    }


