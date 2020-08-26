#
# Be sure to run `pod lib lint .podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PTGAdFramework'
  s.version          = '1.0.0'
  s.summary          = 'PTGAdFramework is a SDK from  providing union AD service.'
  s.description      = <<-DESC
  PTGAdFramework provides Union ADs which include native、banner、feed、splash、RewardVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Siwant' => 'xiangrongsu' }

  s.homepage         = 'https://github.com/xiangrongsu/PTGAdFramework'
  s.source           = { :git => 'https://github.com/xiangrongsu/PTGAdFramework.git', :tag => s.version.to_s }
  s.platform     = :ios, "9.0"  
  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3'

  s.vendored_frameworks =  ['PTGAdFrameworkd/Frameworks/PTGAdSDK.framework']
  valid_archs = ['armv7', 'armv7s', 'x86_64', 'arm64']
  s.xcconfig = {
    'VALID_ARCHS' =>  valid_archs.join(' '),
  }
end
