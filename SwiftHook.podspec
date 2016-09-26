Pod::Spec.new do |s|
  s.name             = 'SwiftHook'
  s.version          = '2.0.0'
  s.summary          = 'A simple and key-based callback library written in Swift.'
  s.description      = <<-DESC
SwiftHook is a simple and key-based callback library written in Swift.
                       DESC
  s.social_media_url = "https://twitter.com/vknabel"
  s.homepage         = 'https://github.com/vknabel/SwiftHook'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Valentin Knabel' => 'develop@vknabel.com' }
  s.source           = { :git => 'https://github.com/vknabel/SwiftHook.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
	s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source_files = 'Sources/SwiftHook/*.swift'
end
