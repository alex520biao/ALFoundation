//
//  NSArray+SafeMethod.h
//  Pods
//
//  Created by liubiao on 16/4/22.
//
//

#import <Foundation/Foundation.h>
#import <Foundation/NSArray.h>

@interface NSArray (SafeMethod)

/*!
 *  @brief 代替+[NSSArray arrayWithObject:]
 *
 *  @param anObject
 *
 *  @return 
 */
+ (instancetype)sf_arrayWithObject:(id)anObject;
@end
