//
//  UIPageController.swift
//  OutDoor
//
//  Created by hoang the anh on 21/07/2023.
//

import Foundation
import UIKit
import SnapKit




extension UIView {

   func toImage() -> UIImage {
       UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
       self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
       let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return snapshotImageFromMyView!
   }

   }

extension UIView {
    func dropShadow(radius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        layer.shadowOpacity = 0.5
    }
}

extension UIView {
  func addDashedBorder(_ color: UIColor = UIColor.black, withWidth width: CGFloat = 2, cornerRadius: CGFloat = 5, dashPattern: [NSNumber] = [3,6]) {
 
    let shapeLayer = CAShapeLayer()
 
      shapeLayer.frame.size.width = self.bounds.width
      shapeLayer.frame.size.height = self.bounds.height
    shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
    shapeLayer.fillColor = nil
    shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = width
      shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
    shapeLayer.lineDashPattern = dashPattern
      shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
     
    self.layer.addSublayer(shapeLayer)
  }
}
