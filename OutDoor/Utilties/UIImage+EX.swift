//
//  UIImage+EX.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import Foundation
import UIKit


extension UIImage {

    func imageWithColor(color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext() ?? image
        UIGraphicsEndImageContext()
        return image
    }

}
