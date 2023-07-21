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
