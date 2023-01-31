#
# Be sure to run `pod lib lint YSTools-Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YSTools-Swift'
  s.version          = '0.1.2'
  s.summary          = 'collection commom tools used in projects.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  collection commom tools used in projects. private project.
                       DESC

  s.homepage         = 'https://github.com/peanutgao/YSTools-Swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'peanutgao' => 'joseph0750@gmail.com' }
  s.source           = { :git => 'https://github.com/peanutgao/YSTools-Swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5.0']

  # s.source_files = 'YSTools-Swift/Classes/**/*'
    
  # 模块1
  s.subspec 'Extension' do |sp|
    sp.source_files = 'YSTools-Swift/Classes/Extension/**/*'
  end
  # 子模块
  s.subspec 'Create' do |sp|
      sp.source_files = 'YSTools-Swift/Classes/Create/**/*'
      sp.dependency 'YSTools-Swift/Extension'
      sp.dependency 'SDWebImage', '~> 5.0.0'
  end 
  s.subspec 'Utils' do |sp|
      sp.source_files = 'YSTools-Swift/Classes/Utils/**/*'
      sp.dependency 'SDWebImage', '~> 5.0.0'
  end 
  # s.resource_bundles = {
  #   'YSTools-Swift' => ['YSTools-Swift/Assets/*']
  # }

  # s.public_header_files = 'YSTools-Swift/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'


end
