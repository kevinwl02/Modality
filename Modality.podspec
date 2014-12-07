Pod::Spec.new do |s|
  s.name         = 'Modality'
  s.version      = '0.0.1'
  s.authors      = {'Kevin Wong' => 'kevin.wl.02@gmail.com'}
  s.summary      = 'View focused transitions library. (Modals and other custom transitions)'
  s.homepage     = 'https://github.com/kevinwl02/Modality.git'
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.platform     =  :ios, '8.0'
  s.source       =  {:git => 'https://github.com/kevinwl02/Modality.git', :tag => '0.0.1'}
  s.source_files = 'Modality/**/*.{h,m,mm}', 'Modality/**/**/*.{h,m,mm}'
  s.requires_arc = true
end