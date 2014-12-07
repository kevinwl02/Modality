Pod::Spec.new do |s|
  s.name         = 'Modality'
  s.version      = '0.0.1'
  s.authors      = {'Kevin Wong' => 'kevin.wl.02@gmail.com'}
  s.summary      = 'View focused transitions library. (Modals and other custom transitions)'
  s.homepage     = 'https://bitbucket.org/kevin_gammaki/modality'
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.platform     =  :ios, '7.0'
  s.source       =  {:git => 'https://bitbucket.org/kevin_gammaki/modality', :tag => '0.0.1'}
  s.source_files = 'Modality/**/*.{h,m,mm}', 'Modality/**/**/*.{h,m,mm}'
  s.requires_arc = true
end