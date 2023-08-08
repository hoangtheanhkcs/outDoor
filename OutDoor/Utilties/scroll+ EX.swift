//
//  scroll+ EX.swift
//  OutDoor
//
//  Created by hoang the anh on 04/08/2023.
//

import Foundation
import UIKit


extension UIScrollView {
   func scrollToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height + self.contentInset.bottom)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}



