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
 NSObject的弱引用替身(影子对象)
 NSTimer以及其他以self作为参数易导致循环引用，weakProxy是NSObject的弱引用替身
 替身不会执行任何实际动作，对YYWeakProxy替身对象的所有调用都会转移到真身NSObject上执行。
 替身与真身的所有特征相同，对替身执行动作与直接对真身执行效果一样。如YYWeakProxy替身打印calss类型与真身self相同输出相同，外部只能通过isProxy方法识别替身与真身。
 
 通过self.weakProxy快速获取NSObject的默认替身。此外也可以通过以下代码创建更多替身: YYWeakProxy *proxy = [YYWeakProxy proxyWithTarget:(NSObject*)target];

 //快速使用
 self.timer = [NSTimer scheduledTimerWithTimeInterval:5
                                               target:self.weakProxy
                                             selector:@selector(onTimer:)
                                             userInfo:nil
                                              repeats:YES];
 [self.timer fire];
 
 */
@interface NSObject (WeakProxy)

/**
 self对象的弱引用替身
 每次访问都会新建一个weakProxy对象
 */
@property (nonatomic,weak,readonly) YYWeakProxy* weakProxy;


@end
