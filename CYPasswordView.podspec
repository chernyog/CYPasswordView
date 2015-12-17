Pod::Spec.new do |s|
  s.name         = "CYPasswordView"
  s.version      = "0.0.1"
  s.summary      = "This is a simple but powerful password box control"
  s.homepage     = "https://github.com/chernyog/CYPasswordView"
  s.license      = "MIT"
  s.author       = {"CoderYChen" => "chenyios@126.com"}
  s.source       = { :git => "https://github.com/chernyog/CYPasswordView.git", :tag => "0.0.1" }
  s.source_files  = "CYPasswordView/*.{h,m}"
  s.resource     = "CYPasswordView/CYPasswordView.bundle"
  s.requires_arc = true
end
