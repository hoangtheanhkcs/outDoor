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
    func checkUserExists(with userInfo: String, completion: @escaping (Bool) -> Void) {
        
        print("111111111111111111")
        database.child(userInfo).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists() != false else {
                print("222222222222222222222222")
                completion(false)
                return
            }
            print("333333333333333333333")
            print(snapshot.description)
            completion(true)
        }
    }
    
    
    
    func addNewUser(user: OutDoorUser, completion: @escaping (Bool)->Void) {
        print("4444444444444444444444444444")
        let userInfo = "\(user.firstName ?? "")\(user.lastName ?? "")\(user.safeEmail ?? "")"
        database.child(userInfo).setValue(["first_name": user.firstName, "last_name": user.lastName]) { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
            
            print("success to write databse")
            completion(true)
            
            
            
        }
    }
}
