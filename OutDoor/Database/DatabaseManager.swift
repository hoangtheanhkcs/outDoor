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






final class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
}

extension DatabaseManager {
    typealias DataUser = [String:Any]
    func checkUserExists(with userInfo: String, completion: @escaping (Bool) -> Void) {
        
        database.child("Users/\(userInfo)").observeSingleEvent(of: .value) {[weak self] snapshot in
            guard let self = self else {return}
            guard snapshot.exists() != false else {
               
                completion(false)
                return
            }
            let userValue = snapshot.value as? [String:Any]
            DispatchQueue.main.async {
                UserDefaults.standard.set(userValue, forKey: "userValue")
                    completion(true)
            }
           
            
           
        }
    }
    
   
    
   
    
    func addNewUser(user: OutDoorUser, completion: @escaping (Bool)->Void) {
        
        let userInfo = "\(user.firstName ?? "")\(user.lastName ?? "")\(user.safeEmail ?? "")"
        let userToSet = ["first_name": user.firstName ?? "", "last_name": user.lastName ?? "", "gender": user.gender ?? "", "dateOfBirth": user.dateOfBirth ?? "", "description": user.description ?? "", "email": user.safeEmail ?? "", "avatar": user.avatar ?? "", "backgroundImage": user.backgroundImage ?? "", "phoneNumber": user.userPhoneNumbers , "numberOfFollowers": user.numberOfFollowers, "numberOfShares": user.numberOfShares, "numberOfLikes": user.numberOfLikes] as [String : Any]
        
        
        database.child("Users/\(userInfo)").setValue(userToSet) { error, _ in
        

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
