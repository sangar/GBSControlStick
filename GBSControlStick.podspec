Pod::Spec.new do |s|
  s.name         = "GBSControlStick"
  s.version      = "0.1"
  s.summary      = "GBSControlStick is a joystick view."
  s.homepage     = "https://github.com/sangar/GBSControlStick"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Gard Sandholt" => "gard.sandholt@gmail.com" }
  s.social_media_url = "https://twitter.com/sangar"
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/sangar/GBSControlStick.git", :tag => "0.1" }
  s.source_files  = 'GBSControlStick', 'GBSControlStick/GBSControlStick.{h,m}', 'GBSControlStick/GBSStick.{h,m}'
  s.requires_arc = true
end
