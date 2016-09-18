//
//  NSArray+SafeMethod.m
//  Pods
//
//  Created by alex520biao on 16/4/22.
//
//

#import "NSArray+SafeMethod.h"

@implementation NSArray (SafeMethod)

+ (instancetype)sf_arrayWithObject:(id)anObject{
    if (anObject!=nil) {
        return [NSArray arrayWithObject:anObject];
    }
    return nil;
}

@end

@implementation NSMutableArray (Safe)

-(void)sf_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if(anObject !=nil && index < self.count){
        [self insertObject:anObject atIndex:index];
    }
}

@end

