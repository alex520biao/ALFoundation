//
//  NSArray+SafeMethod.m
//  Pods
//
//  Created by liubiao on 16/4/22.
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
