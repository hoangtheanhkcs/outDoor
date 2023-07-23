//
//  DatabaseManager.swift
//  OutDoor
//
//  Created by hoang the anh on 23/07/2023.
//

import Foundation
import FirebaseDatabase
import MessageKit
import CoreLocation

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
}

extension DatabaseManager {
    func checkUserExists(with userID: String, completion: @escaping (Bool) -> Void) {
        database.child(userID).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    
    func addNewUser(user: OutDoorUser, completion: @escaping (Bool)->Void) {
        
    }
}
