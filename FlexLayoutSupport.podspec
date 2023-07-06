#
# pod trunk push FlexLayoutSupport.podspec --allow-warnings
#
# pod lib lint FlexLayoutSupport.podspec --allow-warnings
#
#

Pod::Spec.new do |s|
  s.name             = 'FlexLayoutSupport'
  s.version          = '0.2.1'
  s.summary          = 'FunctionBuilder for FlexBoxSupport.'

  s.homepage         = 'https://github.com/NeverAgain11/FlexLayoutSupport'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ljk' => 'liujk0723@gmail.com' }
  s.source           = { :git => 'https://github.com/NeverAgain11/FlexLayoutSupport.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'
  
  s.source_files = 'Sources/**/*'
  
  
  # s.resource_bundles = {
  #   'FlexBoxSupport' => ['FlexBoxSupport/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'FlexLayout', '~> 1.3.33'
end
