//
//  String+EX.swift
//  OutDoor
//
//  Created by hoang the anh on 28/07/2023.
//

import Foundation


extension String {
    func firstName() -> String {
        let stringComponents = self.components(separatedBy: " ")
        var lastComponent = ""
        if stringComponents.count > 1 {
            lastComponent = stringComponents.last!
        }else {
            lastComponent = ""
        }
        return self.replacingOccurrences(of: lastComponent, with: "")
    }
    
    func lastName() -> String {
        let stringComponents = self.components(separatedBy: " ")
        var lastComponent = ""
        if stringComponents.count > 1 {
            lastComponent = stringComponents.last!
        }else {
            lastComponent = self
        }
        
        return lastComponent
    }
}


extension String {
    func addLocalization(str:String) -> String {
        let path = Bundle.main.path(forResource: str, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}


extension String {
    static func duration(from timeInterval: TimeInterval) -> String {
        let duration: Int = Int(ceil(timeInterval))
        let seconds = duration % 60
        let minutes = (duration / 60) % 60
        let hour = duration / 60 / 60
        var durationString = String(format: "%02d:%02d", minutes, seconds)
        if hour > 0 {
            durationString = "\(hour):" + durationString
        }
        return durationString
    }
}
