# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'OutDoor' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OutDoor

pod 'FBSDKCoreKit/Swift'
pod 'FBSDKLoginKit/Swift'
pod 'FBSDKShareKit/Swift'


pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'



pod 'GoogleSignIn'

pod 'MessageKit'

pod 'SDWebImage'
pod 'InputBarAccessoryView'

pod 'RealmSwift'
pod 'SnapKit'
pod 'JGProgressHUD'
pod 'DPLocalization'
pod 'TheAnimation'

end
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
