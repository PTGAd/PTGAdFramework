#
# Be sure to run `pod lib lint PTGAdSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PTGAdSDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PTGAdSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/yingzhao.fyz/PTGAdSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yingzhao.fyz' => 'yingzhao.fyz@alibaba-inc.com' }
  s.source           = { :git => 'https://github.com/yingzhao.fyz/PTGAdSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PTGAdSDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PTGAdSDK' => ['PTGAdSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.static_framework = true
  s.resource_bundles = {
    'PTGBundle' => ['PTGAdSDK/Classes/Resources/*.*']
  }
  
  s.dependency 'AFNetworking', '3.1.0'
  s.dependency 'YYModel', '1.0.4'
  s.dependency 'lottie-ios_Oc', '0.0.1'
  # s.dependency 'Bytedance-UnionAD', '2.9.0.1'
  # s.dependency 'GDTMobSDK', '4.10.10'
end
