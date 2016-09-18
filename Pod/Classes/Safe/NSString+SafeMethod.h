//
//  NSString+SafeMethod.h
//  Pods
//
//  Created by alex520biao on 16/4/22.
//
//

#import <Foundation/Foundation.h>

/*!
 *  @brief NSString常用方法保护
 *  @note  SafeMethod方法统一添加sf前缀
 */
@interface NSString (SafeMethod)

/*!
 *  @brief 替换+[NSString stringWithString:]方法
 *
 *  @param string
 *
 *  @return
 */
+ (instancetype)sf_stringWithString:(NSString *)string;

/*!
 *  @brief 替换-[NSString stringByAppendingString:]方法
 *
 *  @param aString
 *
 *  @return
 */
- (NSString *)sf_stringByAppendingString:(NSString *)aString;


@end

@interface NSMutableString (SafeMethod)

/*!
 *  @brief 替换-[NSMutableString appendString:]
 *
 *  @param aString
 */
- (void)sf_appendString:(NSString *)aString;

@end
