//
//  UIViewControllerEX.swift
//  OutDoor
//
//  Created by hoang the anh on 04/08/2023.
//

import Foundation
import UIKit
import TheAnimation
extension UIViewController {
     func animationMovement(from:CGFloat, to:CGFloat, targetView: UIView, duration:TimeInterval) {
            let animation = BasicAnimation(keyPath: .position) // di chuyển từ from đến to
        animation.fromValue = CGPoint(x: targetView.frame.width/2, y: from)
            animation.toValue = CGPoint(x: targetView.frame.width/2, y: to)
        animation.duration = duration
            animation.timingFunction = .easeInEaseOut
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            animation.beginTime = CACurrentMediaTime()
            animation.animate(in: targetView)
            
        }
}
