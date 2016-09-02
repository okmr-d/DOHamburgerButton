Pod::Spec.new do |s|
  s.name         = "DOHamburgerButton"
  s.version      = "0.0.4"
  s.summary      = "Animated Hamburger Button written in Swift"
  s.homepage     = "https://github.com/okmr-d/DOHamburgerButton"
  s.screenshots  = "https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOHamburgerButton/demo.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Daiki Okumura" => "daiki.okumura@gmail.com" }
  s.social_media_url = "http://twitter.com/okmr_d"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/okmr-d/DOHamburgerButton.git", :tag => s.version.to_s }
  s.source_files = "DOHamburgerButton/*.swift"
  s.framework    = "UIKit"
  s.requires_arc = true
end
