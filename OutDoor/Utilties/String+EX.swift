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
