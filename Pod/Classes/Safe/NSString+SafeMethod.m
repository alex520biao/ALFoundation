//
//  NSString+SafeMethod.m
//  Pods
//
//  Created by alex520biao on 16/4/22.
//
//

#import "NSString+SafeMethod.h"

@implementation NSString (SafeMethod)

+ (instancetype)sf_stringWithString:(NSString *)aString{
    if (aString && aString.length>0) {
        return [NSString stringWithString:aString];
    }
    return nil;
}

- (NSString *)sf_stringByAppendingString:(NSString *)aString{
    if (aString && aString.length>0) {
        return [self stringByAppendingString:aString];
    }
    return self;
}

@end

@implementation NSMutableString (SafeMethod)

- (void)sf_appendString:(NSString *)aString{
    if (aString && aString.length>0) {
        [self appendString:aString];
    }
}

@end

