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
            let value = snapshot.value as? [String:Any]
            let userIFValue = value?["UserInfomation"] as? [String:Any]
            let userIMValue = value?["userImage"] as? [String:Any]
            let userLPValue = value?["userLikePost"] as? [String:Any]
            DispatchQueue.main.async {
                UserDefaults.standard.set(userIFValue, forKey: "userIFValue")
                UserDefaults.standard.set(userIMValue, forKey: "userIMValue")
                UserDefaults.standard.set(userLPValue, forKey: "userLPValue")
                    completion(true)
            }
           
            
           
        }
    }
    
   
    func addNewUser(user: OutDoorUser, completion: @escaping (Bool)->Void) {
        
        let userAddress = "\(user.safeEmail ?? "")"
        let userInfomation = ["first_name": user.firstName ?? "", "last_name": user.lastName ?? "", "gender": user.gender ?? "", "dateOfBirth": user.dateOfBirth ?? "", "description": user.description ?? "", "email": user.safeEmail ?? "", "phoneNumber": user.userPhoneNumbers ?? ""] as [String : Any]
        let userImage = ["avatar": user.avatar ?? "", "backgroundImage": user.backgroundImage ?? ""] as [String : Any]
        let userLikePost = ["numberOfFollows": user.numberOfFollowers, "numberOfShares": user.numberOfShares, "numberOfLikes": user.numberOfLikes] as [String : Any]
        
        
        database.child("Users/\(userAddress)/UserInfomation").setValue(userInfomation) { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
            UserDefaults.standard.set(userInfomation, forKey: "userIFValue")
           
            print("success to write databse")
            completion(true)
        }
        database.child("Users/\(userAddress)/userImage").setValue(userImage) { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
            
            UserDefaults.standard.set(userImage, forKey: "userIMValue")
            
            print("success to write databse")
            completion(true)
        }
        database.child("Users/\(userAddress)/userLikePost").setValue(userLikePost) { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
            
            UserDefaults.standard.set(userLikePost, forKey: "userLPValue")
            print("success to write databse")
            completion(true)
        }
        
        
    }
    
    func updateUserInfomation(user: OutDoorUser, completion: @escaping (Bool)->Void) {
        let userInfo = UserDefaults.standard.value(forKey: "userInfo") as? String ?? ""
        let userInfomation = ["first_name": user.firstName ?? "", "last_name": user.lastName ?? "", "gender": user.gender ?? "", "dateOfBirth": user.dateOfBirth ?? "", "description": user.description ?? "", "email": user.safeEmail ?? "", "phoneNumber": user.userPhoneNumbers ?? ""] as [String : Any]
        
        database.child("Users/\(userInfo)/UserInfomation").setValue(userInfomation) { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
            UserDefaults.standard.set(userInfomation, forKey: "userIFValue")
           
            print("success to write databse")
            completion(true)
        }
    }
    
    func updateUserDescription(user: OutDoorUser, completion: @escaping (Bool)->Void) {
        let userInfo = UserDefaults.standard.value(forKey: "userInfo") as? String ?? ""
        let userInfomation = user.description ?? ""
        
        database.child("Users/\(userInfo)/UserInfomation/description").setValue(userInfomation) { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
         
            UserDefaults.standard.set(userInfomation, forKey: "userDSValue")
            
            
            print("success to write databse")
            completion(true)
        }
    }
    
    func updateUserImage(user: OutDoorUser, completion: @escaping (Bool)->Void) {
        let userInfo = UserDefaults.standard.value(forKey: "userInfo") as? String ?? ""
        let userImage = ["avatar": user.avatar ?? "", "backgroundImage": user.backgroundImage ?? ""] as [String : Any]
        
        database.child("Users/\(userInfo)/userImage").setValue(userImage) { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
            
            UserDefaults.standard.set(userImage, forKey: "userIMValue")
            
            print("success to write databse")
            completion(true)
        }
    }
    
    func updateUserLikePost(user: OutDoorUser, completion: @escaping (Bool)->Void) {
        let userInfo = UserDefaults.standard.value(forKey: "userInfo") as? String ?? ""
        let userLikePost = ["numberOfFollows": user.numberOfFollowers, "numberOfShares": user.numberOfShares, "numberOfLikes": user.numberOfLikes] as [String : Any]
        
        database.child("Users/\(userInfo)/userLikePost").setValue(userLikePost) { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
            
            UserDefaults.standard.set(userLikePost, forKey: "userLPValue")
            print("success to write databse")
            completion(true)
        }
    }
    
    
    
    
    
    
}
