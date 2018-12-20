
Pod::Spec.new do |s|


  s.name         = "MBRPaySDK"
  s.version      = "1.0.11"
  s.summary      = "MBRPaySDK SDK for iOS."

  s.description  = <<-DESC
                   MBRPaySDK SDK for iOS，用于唤起MBR各种Pay支付.
                   DESC

  s.homepage     = "https://github.com/cqmbr/MBRPaySDK-iOS.git"

	s.license      = { :type => "Copyright", :text => "LICENSE Copyright 2017 - 2018 cqmbr.net, Inc. All rights reserved." }

  s.author       = {"zhanbin" => "27226850@qq.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/cqmbr/MBRPaySDK-iOS.git", :tag => "#{s.version}" }
  
  s.dependency 'BlocksKit', '~> 2.2.5'

    s.preserve_paths = "*.framework"
    s.vendored_frameworks = "#{s.name}.framework"
		s.resource = 'MBRPaySDK.framework/MBRPaySDKResource.bundle'
end

