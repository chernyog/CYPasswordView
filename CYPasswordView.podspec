#
#  Be sure to run `pod spec lint CYPasswordView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "CYPasswordView"
  s.version      = "0.0.3"
  s.authors     = { 'chernyog' => 'chenyios@126.com' }
  s.summary      = "CYPasswordView 是一个模仿支付宝输入支付密码的密码框。"
  s.homepage     = "https://github.com/chernyog/CYPasswordView"
  s.license      =  { :type => "MIT", :file => "LICENSE" }
  s.author             = { "cheny" => "yong.chen@jimubox.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/chernyog/CYPasswordView.git", :tag => "0.0.3" }
  s.source_files  = "CYPasswordView/**/*.{h,m}"
  s.public_header_files = "CYPasswordView/*.h"
  s.resources = "CYPasswordView/CYPasswordView.bundle"
  s.requires_arc = true

end
