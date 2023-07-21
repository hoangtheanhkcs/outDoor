//
//  Objc+AssociatedValue.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import Foundation


import Foundation


public func associatedValue<T>(for object: Any, key: UnsafeRawPointer, policy: objc_AssociationPolicy, defaultValue: T) -> T {
    if let nonNilValue = objc_getAssociatedObject(object, key) {
        guard let typeSafeValue = nonNilValue as? T else {
            fatalError("Unexpected: different kind of value already exists for key '\(key)': \(nonNilValue)")
        }
        return typeSafeValue
    } else {
        let newValue = defaultValue
        objc_setAssociatedObject(object, key, newValue, policy)
        assert(objc_getAssociatedObject(object, key) != nil, "Associated values are not supported for object: \(object)")
        assert(objc_getAssociatedObject(object, key) is T, "Associated value could not be cast back to specified type: \(String(describing: T.self))")
        return newValue
    }
}
