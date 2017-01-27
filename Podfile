source 'https://github.com/CocoaPods/Specs'

platform :ios, '9.0'
use_frameworks!

# Add Application pods here
def app_pods
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'Decodable'
    pod 'DynamicColor'
    pod 'Eureka', :git => 'https://github.com/xmartlabs/Eureka.git', :branch => 'master'
    pod 'Hero'
    pod 'Material'
    pod 'Opera', :git => 'https://github.com/xmartlabs/Opera.git', :branch => 'Swift3'
    pod 'R.swift'
    pod 'RxAlamofire'
    pod 'RxCocoa'
    pod 'RxSwift'
    pod 'XLSwiftKit'
end

target 'TestingHero' do
    app_pods
end

post_install do |installer|
    installer.pods_project.build_configuration_list.set_setting('SWIFT_VERSION', '3.0')
    puts 'Removing static analyzer support'
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['OTHER_CFLAGS'] = "$(inherited) -Qunused-arguments -Xanalyzer -analyzer-disable-all-checks"
        end
    end
end
