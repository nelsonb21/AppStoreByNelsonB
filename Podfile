source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.2'
use_frameworks!

target 'AppStoreByNelsonB' do
    pod 'Alamofire', '~> 3.1.4'
    pod 'ChameleonFramework/Swift', '~> 2.0.6'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        end
    end
end