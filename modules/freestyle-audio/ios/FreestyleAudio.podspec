Pod::Spec.new do |s|
  s.name = 'FreestyleAudio'
  s.version = '0.1.0'
  s.summary = 'Native audio prototype for Freestyle'
  s.description = 'Four synchronized voice loops using AVAudioEngine.'
  s.author = 'Freestyle contributors'
  s.homepage = 'https://github.com/Onyxuz666/freestyle'
  s.license = { :type => 'UNLICENSED' }
  s.platforms = { :ios => '16.0' }
  s.source = { :git => 'https://github.com/Onyxuz666/freestyle.git' }
  s.static_framework = true
  s.dependency 'ExpoModulesCore'
  s.source_files = '**/*.{h,m,mm,swift}'
  s.swift_version = '5.9'
end
