//
//  NSArray+SafeMethod.h
//  Pods
//
//  Created by alex520biao on 16/4/22.
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

@interface NSMutableArray (Safe)

/*!
 *  @brief 代替insertObject:atIndex
 *
 *  @param anObject
 *  @param index
 */
-(void)sf_insertObject:(id)anObject atIndex:(NSUInteger)index;

@end

