# ALFoundation

ALFoundation是基于系统Foundation库的扩展,用于搭建快速开发框架。
对应Foundation/Foundation.h此文件中的基础类及其扩展。

1. libextobjc    
Libextobjc是一个非常强大的Objective-C库的扩展,为Objective-C提供诸如Safe categories、Concrete protocols、简单和安全的key paths以及简单使用block中的弱变量等功能。   
libextobjc非常模块化，只需要一个或者两个依赖就能使用大部分类和模块。

2. ReactiveCocoa 


####YYWeakProxy
使用NSProxy实现弱引用对象的创建
WeakProxy持有一个target对象的弱引用(WeakProxy是target对象的影子替身)

1. NSTimer
2. CADisplayLink
3. 延迟调用 performSelector:withObject:afterDelay:
	
		对象释放时需要取消延迟调用 cancelPreviousPerformRequestsWithTarget:selector:object:
3. 以及其他会retainSelf导致循环引用的场景


####GCDMulticastDelegate
实现一对多弱引用代理

http://www.cnblogs.com/gugupluto/p/3673185.html
https://github.com/robbiehanson/XMPPFramework/wiki/MulticastDelegate

## Quick Start

目前都使用cocoapods安装，在Podfile中加入

```
pod "ALFoundation" 
```

## Example


## 实现原理


## 维护者

alex520biao <alex520biao@didichuxing.com>

## License

ALFoundation is available under the MIT license. See the LICENSE file for more info.


####TODO
1. 字典的valueForKeyPath方法，如果KeyPath不存在系统会抛出异常。需要封装为安全方法。