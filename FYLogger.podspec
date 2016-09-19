#
#  Be sure to run `pod spec lint FYLogger.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "FYLogger"
  s.version      = "0.82"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.homepage     = "https://github.com/syxc/FYLogger"
  s.author       = { "syxc" => "gaibing2009@gmail.com" }
  s.summary      = "A tiny logging framework for iOS"
  s.source       = { :git => "https://github.com/syxc/FYLogger.git", :tag => s.version }
  s.ios.deployment_target = "8.0"
  s.source_files = ["FYLogger/Source/*.{swift, h}", "FYLogger/*.h"]
  s.ios.frameworks = "UIKit", "Foundation"
  s.requires_arc = true
end
