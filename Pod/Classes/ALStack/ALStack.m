//
//  ALStack.m
//  Pods
//
//  Created by alex on 2017/2/14.
//
//

#import "ALStack.h"
#import <Foundation/NSEnumerator.h>

@interface ALStack ()

/**
 使用NSMutableArray作为stack容器
 */
@property(nonatomic,strong,readwrite)NSMutableArray *m_array;

/**
 Stack中元素数目
 */
@property(nonatomic,assign,readwrite)int count;

@end

@implementation ALStack
    
- (id)init{
    if( self=[super init] ){
        _m_array = [[NSMutableArray alloc] init];
        _count = 0;
    }
    return self;
}
    
- (void)dealloc {
    _m_array = nil;
}
    
- (void)push:(id)anObject{
    [self.m_array addObject:anObject];
    self.count = self.m_array.count;
}
    
- (id)pop{
    id obj = nil;
    if(self.m_array.count > 0){
        obj = [self.m_array lastObject];
        [self.m_array removeLastObject];
        self.count = self.m_array.count;
    }
    return obj;
}
    
/**
 获取当前栈顶元素
 
 @return 栈顶元素
 */
- (id)top{
    id obj = [self.m_array lastObject];
    return obj;
}
    
- (void)clear{
    [self.m_array removeAllObjects];
    self.count = 0;
}

/**
 返回栈中所有元素
 可用于遍历
 */
- (NSArray*)stackArray{
    NSArray *array =  [NSArray arrayWithArray:self.m_array];
    return array;
}
    
- (void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block{
    NSArray *array =  [NSArray arrayWithArray:self.m_array];
    [array enumerateObjectsUsingBlock:block];
}

@end
