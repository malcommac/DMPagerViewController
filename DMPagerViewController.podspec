#
# Be sure to run `pod lib lint DMPagerViewController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DMPagerViewController"
  s.version          = "0.1.0"
  s.summary          = "DMPagerViewController is page navigation controller like the one used in Twitter or Tinder"
  s.description      = <<-DESC
                       DMPagerViewController page navigation controller which aims to mimics the one used in Twitter or Tinder with navigation bar on top and a parallax effect on scrolling. 
                       DESC
  s.homepage         = "https://github.com/malcommac/DMPagerViewController"
  s.license          = 'MIT'
  s.author           = { "Daniele Margutti" => "me@danielemargutti.com" }
  s.source           = { :git => "https://github.com/malcommac/DMPagerViewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielemargutti'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'DMPagerViewController' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'
end
