//
//  NSObject+WeakProxy.h
//  Pods
//
//  Created by alex on 2016/12/1.
//
//

#import <Foundation/Foundation.h>
#import "YYWeakProxy.h"

/**
    NSObject的弱引用替身
 */
@interface NSObject (WeakProxy)

/**
 self对象的弱引用替身
 NSTimer以及其他以self作为参数易导致循环引用，weakProxy是NSObject的弱引用提升

 */
@property (nonatomic, readonly) YYWeakProxy* weakProxy;


@end
