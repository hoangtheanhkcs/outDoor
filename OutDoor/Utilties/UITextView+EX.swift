//
//  UITextView+EX.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import Foundation
import UIKit

extension UITextView {
    
    func settingTextView(text: String, textColor:UIColor?, font: UIFont?, lineSpacing: CGFloat) {
        
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
        self.textAlignment = .center
        self.font = font
        self.textColor = textColor
        
    }
}
