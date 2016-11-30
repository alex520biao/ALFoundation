#
# Be sure to run `pod lib lint ALFoundation.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ALFoundation"
  s.version          = "0.1.0"
  s.summary          = "A short description of ALFoundation."
  s.description      = <<-DESC.gsub(/^\s*\|?/,'')
                       An optional longer description of ALFoundation

                       | * Markdown format.
                       | * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/alex520biao/ALFoundation"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'BSD'
  s.author           = { "alex520biao" => "alex520biao@didichuxing.com" }
  s.source           = { :git => "https://github.com/alex520biao/ALFoundation.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.source_files = 'Pod/Classes/**/*'

  # Uncomment following lines if ALFoundation has some resource files.
  s.resource_bundles = {
    'ALFoundation' => ['Pod/Assets/*']
  }

  # Uncomment following lines if ALFoundation needs to link with some static libraries.
  # s.vendored_libraries = [
  #   'Pod/lib/a-static-library.a',
  # ]

  # Uncomment following lines if ALFoundation depends on any system framework.
  # s.frameworks = 'UIKit', 'MapKit'

  # Uncomment following lines if ALFoundation depends on any public or private pod.
  # s.dependency 'AFNetworking', '~> 2.5.4'
  # s.dependency 'ReactiveViewModel', '~> 0.3.0'

  #s.dependency 'ReactiveCocoa', '~> 2.5.0'
  s.dependency 'JSONModel', '~> 1.1.0'

  #Objective-C库的扩展,为Objective-C提供诸如常见宏定义、Safe categories、Concrete protocols、简单和安全的key paths以及简单使用block中的弱变量等功能。
  #s.dependency 'libextobjc', '~> 0.4.1'

  # GVUserDefault是一个NSUserDefault的扩展，通过扩展一个实体类的方式来进行键值对的存储
  # 其原理是给自定义类的@property属性创建生成getter和setter方法，并在方法中加入NSUserDefault的setValue和getValue方法，从而达到本地保存的效果
  # https://github.com/gangverk/GVUserDefaults
  #s.dependency 'GVUserDefaults'

  #NSObject扩展: 面向方面编程为现有的NSObject类的方法或者实例添加代码，同时考虑插入点位置，比如before/instead/after。
  #s.dependency 'Aspects', '1.4.1'

  #使用KeyPath分发APNS消息
  s.dependency 'ALAPNSManager', '0.1.4'

  #iOS组件化实施方案,模块间解耦URL工具
  s.dependency 'ALURLRouter', '1.1.0'

  #NSNotificationCenter的简单替代工具
  s.dependency 'ALObserverManager', '0.1.7'

  #类别中通过关联应用添加属性
  #s.dependency 'ObjcAssociatedObjectHelpers', '2.0.1'

    s.dependency 'SDWebImage'
    s.dependency 'SDWebImage/WebP'

    #可以引入整个ONEUIKit库也可以只引入ONEUIKit的subSpec
    #s.dependency 'ONEUIKit'
    #s.dependency 'ONEUIKit/Theme'
    s.dependency 'ONEUIKit/HUD'

end
