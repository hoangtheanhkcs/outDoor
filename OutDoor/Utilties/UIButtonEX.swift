//
//  UIButtonEX.swift
//  OutDoor
//
//  Created by hoang the anh on 23/07/2023.
//

import Foundation
import UIKit

extension UIButton {
    
    func changeButtonFont(_ font: UIFont?) {
        self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
          var outgoing = incoming
          outgoing.font = font
          return outgoing
         }
    }
}
