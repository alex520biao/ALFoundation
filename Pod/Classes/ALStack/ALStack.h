//
//  ALStack.h
//  Pods
//
//  Created by alex on 2017/2/14.
//
//

#import <Foundation/Foundation.h>

/**
 由于Object-C中没有提供Stack容器,因此自己实践了一个简单的stack容器
 LIFO，即后进先出（Last in, first out）
 典型的使用场景是
 */
@interface ALStack : NSObject
    
/**
 Stack中元素数目
 */
@property (nonatomic,assign,readonly) int count;

/**
 入栈操作
 向栈中添加一个元素,此元素成为栈顶元素

 @param anObject
 */
- (void)push:(id)anObject;
    
/**
 出栈操作
 @return 返回本地出栈的元素
 */
- (id)pop;


/**
 获取当前栈顶元素

 @return 栈顶元素
 */
- (id)top;
    
/**
 返回栈中所有元素
 可用于遍历
 */
- (NSArray*)stackArray;
    
/**
 清空堆栈
 */
- (void)clear;
    
/**
 快速遍历栈中元素

 @param block
 */
- (void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block;
    

@end



