//
//  OudoorUser.swift
//  OutDoor
//
//  Created by hoang the anh on 23/07/2023.
//

import Foundation


struct OutDoorUser {
    var firstName:String?
    var lastName:String?
    var emailAddress:String?
    var avatar:String?
    var numberOfFollowers:Int = 0
    var numberOfShares: Int = 0
    var numberOfLikes:Int = 0
    var userPosts: [UserPost]?
    
    
    var safeEmail:String? {
        let email = emailAddress?.replacingOccurrences(of: ".", with: "-")
        return email
    }
    
}

struct UserPost {
    var dateOfPost: Date
    var imagePost:String
    var contentPost:String
    var numberOfLikePost:Int
    var numberOfSharesPost:Int
    var numberOfComment:Int
    var commentsPost: [CommentPost]
    
}

struct CommentPost {
    var userComment: OutDoorUser
    var dateOfComment: Date
    var replyComments:[ReplyCommnet]
}

struct ReplyCommnet {
    var userReply: OutDoorUser
    var dateOfReply:Date
    var contentReply:String
}
