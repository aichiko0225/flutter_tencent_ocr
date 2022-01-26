#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_tencent_ocr.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_tencent_ocr'
  s.version          = '0.0.1'
  s.summary          = 'flutter_tencent_ocr 身份证图片识别插件'
  s.description      = <<-DESC
flutter_tencent_ocr 身份证图片识别插件
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{h,m,mm,xib}'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  
  s.frameworks = 'Accelerate', 'CoreML'
  
  s.vendored_frameworks = 'lib/AipBase.framework', 'lib/AipOcrSdk.framework', 'lib/IdcardQuality.framework'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
