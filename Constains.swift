//
//  Constains.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import Foundation
import UIKit


enum Constants {
    enum Images {
        static let loadAppImage = "laodApp"
        static let loginOutdoorLogo = "logo ngang@4x 1"
        static let loginImage = "Group 6"
        static let logginFacebookButton = "Facebook logo 2019"
        static let logginGoogleButton = "google"
        
        static let onboard1Image = "Mask Group"
        static let onboard2Image = "Mask Group (1)"
        static let onboard3Image = "Mask Group (2)"
        static let onboard4Image = "Mask Group (3)"
        static let onboard5Image = "Mask Group (4)"
        
        static let onboardBottomButton = "Group 7"
        static let welcomeVCLogo = "logo-png@4x 2"
        static let welcomeVCYellowCart = "Group 3 (2)"
        static let welcomeVCRedCart = "Group 4 (1)"
        static let welcomeVCGreenCart = "Group 5 (1)"
        
        static let userAvatarDefault = "Person-icon-reversed-500x500-300x300"
        static let userBackgrounDefault = "Rectangle 37"
        static let userEditAvatar = "edit-2"
        
        static let updateCelliconCheck = "icons8-check-50"
    }
   
    enum Strings {
        // NSLocalizedString("", comment: "")
        static let loginHello = NSLocalizedString("Xin chào!", comment: "")
        static let loginWelcome = NSLocalizedString("     Chào mừng bạn đến với Outdoor ứng dụng tìm kiếm và chia sẻ kinh nghiệm dã ngoại cho gia đình, khuyến khích trẻ khám phá thiên nhiên.", comment: "")
        static let logginFacebook = NSLocalizedString("    Đăng nhập với Facebook", comment: "")
        static let logginGoogle = NSLocalizedString("    Đăng nhập với Google", comment: "")
        
        static let onboard1Lable = NSLocalizedString("Trải nghiệm", comment: "")
        static let onboard1TextView = NSLocalizedString("Hãy cùng cho trẻ ra ngoài trải nghiệm Thiên nhiên , làm quen với các kỹ năng mềm và nâng cao sức khỏe ", comment: "")
        static let onboard2Lable = NSLocalizedString("Chia sẻ", comment: "")
        static let onboard2TextView = NSLocalizedString("Bạn có thể đăng những bài review về địa điểm vui chơi ngoài trời mà mình đã đến bằng Hình Ảnh và Văn Bản hay kể cả là Dụng cụ mình đã sử dụng. ", comment: "")
        static let onboard3Lable = NSLocalizedString("Tìm kiếm", comment: "")
        static let onboard3TextView = NSLocalizedString("Bạn có thể search những địa điểm vui chơi ngoài thiên nhiên gần mình hoặc khắp nước Việt nam xinh đẹp này ", comment: "")
        static let onboard4Lable = NSLocalizedString("Lưu giữ", comment: "")
        static let onboard4TextView = NSLocalizedString("Bạn có thể Lưu bài viết , giao lưu kết bạn bằng cách bấm Follow các Phụ huynh khác cũng như Thả tim hoặc Comment bài viết ", comment: "")
        static let onboard5Lable = NSLocalizedString("Let’s GO!", comment: "")
        static let onboard5TextView = NSLocalizedString("Với mong muốn con phát triển toàn diện về Thể Chất và Tinh thần - các bậc phụ huynh hãy cùng chúng tôi chia sẻ và trải nghiệm", comment: "")
        
        static let welcomeVCYellowCartLable = NSLocalizedString("Cùng con khám phá", comment: "")
        static let welcomeVCYellowCartText = NSLocalizedString("Tìm kiếm các điểm vui chơi tăng sự phát triển cho con", comment: "")
        static let welcomeVCRedCartLable = NSLocalizedString("Chia sẻ", comment: "")
        static let welcomeVCRedCartText = NSLocalizedString("khoảnh khắc bên nhau", comment: "")
        static let welcomeVCGreenCartLable = NSLocalizedString("Giao lưu", comment: "")
        static let welcomeVCGreenCartText = NSLocalizedString("kinh nghiệm dã ngoại", comment: "")
        
        static let welcomeVCButton = NSLocalizedString("Khám phá", comment: "")
        
        static let homeContainerTopbarTitleSpotlight = NSLocalizedString("Tiêu điểm", comment: "")
        static let homeContainerTopbarTitleBreakingNews = NSLocalizedString("Tin mới", comment: "")
        static let homeContainerTopbarTitleFollowing = NSLocalizedString("Theo dõi", comment: "")
        
       
        static let settingVCInfomation = NSLocalizedString("Thông tin", comment: "")
        static let updateAvatar = NSLocalizedString("Cập nhật ảnh đại diện", comment: "")
        static let updateBackground = NSLocalizedString("Cập nhật ảnh bìa", comment: "")
        static let updateDescription = NSLocalizedString("Cập nhật giới thiệu bản thân", comment: "")
        static let setting = NSLocalizedString("Cài đặt", comment: "")
        static let receiveNotification = NSLocalizedString("Nhận thông báo", comment: "")
        static let policy = NSLocalizedString("Chính sách", comment: "")
        static let provision = NSLocalizedString("Điều khoản", comment: "")
        static let reports = NSLocalizedString("Báo cáo vi phạm", comment: "")
        static let language = NSLocalizedString("Ngôn ngữ", comment: "")
        static let instruct = NSLocalizedString("Hướng dẫn", comment: "")
        static let loggout = NSLocalizedString("Đăng xuất", comment: "")
        
        static let userInfoDetailGender = NSLocalizedString("Giới tính", comment: "")
        static let userInfoDetailBirth = NSLocalizedString("Ngày sinh", comment: "")
        static let userInfoDetailPhoneNumber = NSLocalizedString("Điện thoại", comment: "")
        
    }
    enum Fonts {
        
        static let SFBold34 = UIFont(name: "SanFranciscoText-Bold", size: 34)
        
        static let SFBold28 = UIFont(name: "SanFranciscoText-Bold", size: 28)
        static let SFSemibold28 = UIFont(name: "SanFranciscoText-Semibold", size: 28)
        
        static let SFBold24 = UIFont(name: "SanFranciscoText-Bold", size: 24)
        static let SFSemibold24 = UIFont(name: "SanFranciscoText-Semibold", size: 24)
        
        static let SFBold20 = UIFont(name: "SanFranciscoText-Bold", size: 20)
        
        static let SFThin17 = UIFont(name: "SanFranciscoText-Thin", size: 17)
        static let SFLight17 = UIFont(name: "SanFranciscoText-Light", size: 17)
        static let SFReguler17 = UIFont(name: "SanFranciscoText-Regular", size: 17)
        static let SFMedium17 = UIFont(name: "SanFranciscoText-Medium", size: 17)
        static let SFSemibold17 = UIFont(name: "SanFranciscoText-Semibold", size: 17)
        static let SFBold17 = UIFont(name: "SanFranciscoText-Bold", size: 17)
        static let SFHeavy17 = UIFont(name: "SanFranciscoText-Heavy", size: 17)
        
        static let SFSemibold16 = UIFont(name: "SanFranciscoText-Semibold", size: 16)
        static let SFReguler16 = UIFont(name: "SanFranciscoText-Regular", size: 16)
        static let SFLight16 = UIFont(name: "SanFranciscoText-Light", size: 16)
        
        static let SFReguler15 = UIFont(name: "SanFranciscoText-Regular", size: 15)
        static let SFLight15 = UIFont(name: "SanFranciscoText-Light", size: 15)
        
        static let SFLight13 = UIFont(name: "SanFranciscoText-Light", size: 13)
        
    }
    enum Colors {
        static let sliderTintColor = "#6FCF97"
        static let buttonBackgroundColor = "#F97165"
        static let textColorType1 = "#333333"
        static let textColorType2 = "#4F4F4F"
        static let textColorType3 = "#000000"
        static let textColorType4 = "#F97165"
        static let textColorType5 = "#FFFFFF"
        static let textColorType6 = "#828282"
        static let textColorType7 = "#2F80ED"
        static let textColorType8 = "#F2F2F2"
        
        static let logginFacebook = "#1877F2"
        static let logginGoogleBorder = "#E0E0E0"
        
       

    }
}
