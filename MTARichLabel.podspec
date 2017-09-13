Pod::Spec.new do |s|

  s.name         = "MTARichLabel"
  s.version      = "0.0.1"

  s.summary      = "到综商户技术富文本label"
  s.description  = <<-DESC
                    到综商户技术富文本label到综商户技术富文本label
                   DESC

  s.license      = "MIT"

  s.homepage     = "http://git.dianpingoa.com/v1/sh/projects/mtapodspecs/repos/MTARichLabel/browse"
  s.author       = { "yuzhuo" => "yuzhuo@meituan.com" }
  s.source       = { :git => "http://git.dianpingoa.com/scm/mtapodspecs/mtarichlabel.git", :tag => s.version.to_s }

  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files     = "Pod/Classes/**/*.{h,m}"
  s.resources = ["Pod/Resources/*.xcassets"]
end