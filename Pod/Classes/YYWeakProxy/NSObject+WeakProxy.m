//
//  NSObject+WeakProxy.m
//  Pods
//
//  Created by alex on 2016/12/1.
//
//

#import "NSObject+WeakProxy.h"
#import <objc/runtime.h>

@implementation NSObject (WeakProxy)

/**
 self对象的弱引用替身
 NSTimer以及其他以self作为参数易导致循环引用，weakProxy是NSObject的弱引用提升
 
 @return
 */
- (YYWeakProxy*)weakProxy {
    YYWeakProxy *proxy = [YYWeakProxy proxyWithTarget:self];
    return proxy;
}


@end
