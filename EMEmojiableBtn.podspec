#
# Be sure to run `pod lib lint EMEmojiableBtn.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EMEmojiableBtn"
  s.version          = "0.0.3"
  s.summary          = "Option selector that works similar to Reactions by fb. Objective-c version"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
Totally customizable Options (Emoji) Selector based on Reactions. Objective-c version
                       DESC

  s.homepage         = "https://github.com/Eke/EMEmojiableBtn"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Erekle Meskhi" => "ereklemesxi@gmail.com" }
  s.source           = { :git => "https://github.com/Eke/EMEmojiableBtn.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'EMEmojiableBtn' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
