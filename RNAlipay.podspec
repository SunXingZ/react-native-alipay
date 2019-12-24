require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "RNAlipay"
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = package['author']
  s.homepage     = package['repository']['url']
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/SunXingZ/react-native-alipay.git", :tag => "master" }
  s.source_files  = "**/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  s.resource = 'AlipaySDK.bundle'
  s.vendored_frameworks = 'AlipaySDK.framework'
  #s.vendored_libraries = "libAlipaySDK.a"
  s.frameworks = "SystemConfiguration", "CoreTelephony", "QuartzCore", "CoreText", "CoreGraphics", "UIKit", "Foundation", "CFNetwork", "CoreMotion"
  s.library = "c++", "z", "sqlite3.0"

end

  