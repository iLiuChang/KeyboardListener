Pod::Spec.new do |s|
  s.name         = "LCKeyboardListener"
  s.version      = "1.2.0"
  s.summary      = "Prevent keyboard from covering UITextField/UITextView"
  s.homepage     = "https://github.com/iLiuChang/KeyboardListener"
  s.license      = "MIT"
  s.author       = "LiuChang"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/iLiuChang/KeyboardListener.git", :tag => s.version }
  s.source_files  =  "LCKeyboardListener/**/*.{h,m}"
  s.requires_arc = true
end