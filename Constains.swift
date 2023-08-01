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
        static let loginHello = "Xin chào!"
        static let loginWelcome = "Chào mừng bạn đến với Outdoor ứng dụng tìm kiếm và chia sẻ kinh nghiệm dã ngoại cho gia đình, khuyến khích trẻ khám phá thiên nhiên."
        static let logginFacebook = "Đăng nhập với Facebook"
        static let logginGoogle = "    Đăng nhập với Google"
        
        static let onboard1Lable = "Trải nghiệm"
        static let onboard1TextView = "Hãy cùng cho trẻ ra ngoài trải nghiệm Thiên nhiên , làm quen với các kỹ năng mềm và nâng cao sức khỏe"
        static let onboard2Lable = "Chia sẻ"
        static let onboard2TextView = "Bạn có thể đăng những bài review về địa điểm vui chơi ngoài trời mà mình đã đến bằng Hình Ảnh và Văn Bản hay kể cả là Dụng cụ mình đã sử dụng."
        static let onboard3Lable = "Tìm kiếm"
        static let onboard3TextView = "Bạn có thể search những địa điểm vui chơi ngoài thiên nhiên gần mình hoặc khắp nước Việt nam xinh đẹp này"
        static let onboard4Lable = "Lưu giữ"
        static let onboard4TextView = "Bạn có thể Lưu bài viết , giao lưu kết bạn bằng cách bấm Follow các Phụ huynh khác cũng như Thả tim hoặc Comment bài viết"
        static let onboard5Lable = "Let’s GO!"
        static let onboard5TextView = "Với mong muốn con phát triển toàn diện về Thể Chất và Tinh thần - các bậc phụ huynh hãy cùng chúng tôi chia sẻ và trải nghiệm"
        
        static let welcomeVCYellowCartLable = "Cùng con khám phá"
        static let welcomeVCYellowCartText = "Tìm kiếm các điểm vui chơi tăng sự phát triển cho con"
        static let welcomeVCRedCartLable = "Chia sẻ"
        static let welcomeVCRedCartText = "khoảnh khắc bên nhau"
        static let welcomeVCGreenCartLable = "Giao lưu"
        static let welcomeVCGreenCartText = "kinh nghiệm dã ngoại"
        
        static let welcomeVCButton = "Khám phá"
        
        static let homeContainerTopbarTitleSpotlight = "Tiêu điểm"
        static let homeContainerTopbarTitleBreakingNews = "Tin mới"
        static let homeContainerTopbarTitleFollowing = "Theo dõi"
        
       
        static let settingVCInfomation = "Thông tin"
        static let updateAvatar = "Cập nhật ảnh đại diện"
        static let updateBackground = "Cập nhật ảnh bìa"
        static let updateDescription = "Cập nhật giới thiệu bản thân"
        static let setting = "Cài đặt"
        static let receiveNotification = "Nhận thông báo"
        static let policy = "Chính sách"
        static let provision = "Điều khoản"
        static let reports = "Báo cáo vi phạm"
        static let language = "Ngôn ngữ"
        static let instruct = "Hướng dẫn"
        static let loggout = "Đăng xuất"
        
        static let userInfoDetailGender = "Giới tính"
        static let userInfoDetailBirth = "Ngày sinh"
        static let userInfoDetailPhoneNumber = "Điện thoại"
        
        static let titleAlertChangeAvatar = "Ảnh đại diện"
        static let previewAvatar = "Xem ảnh đại diện"
        static let alertChangeAvatarChoosePhotoFromLibrary = "Chọn ảnh từ thiết bị"
        static let alertChangeAvatarTakeNewPhoto = "Chụp ảnh mới"
        static let changeAvatar = "Thay ảnh đại diện"
        static let changeBackground = "Thay ảnh bìa"
        
        static let yourPost = "Bài viết của bạn"
        static let savedPost = "Bài viết đã lưu"
        
        static let cancel = "Hủy"
        static let changeUserInfo = "Đổi thông tin"
        static let name = "Tên"
        static let gender = "Giới tính"
        static let birth = "Ngày sinh"
        static let phone = "Điện thoại"
        static let update = "Cập nhật"
        static let man = "Nam"
        static let women = "Nữ"
        
        static let changeDescription = "Chỉnh sửa giới thiệu"
        static let closeVC = "Đóng"
        static let save = "Lưu"
        
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
        
        static let SFReguler13 = UIFont(name: "SanFranciscoText-Regular", size: 13)
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
        
        static let alertAvatar = "#759E50"
        
       

    }
}
